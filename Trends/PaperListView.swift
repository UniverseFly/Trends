//
//  PaperListView.swift
//  Trends
//
//  Created by 魏宇翔 on 2021/6/21.
//

import SwiftUI

struct PaperListView: View {
    
    struct PaperData {
        var title: String = ""
        var url: String = ""
        var isLiked = false
        var date: Date = Date()
    }
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [])
    private var papers: FetchedResults<Paper>
    
    @State var isPresented = false
    @State var newPaper = PaperData()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(papers) { paper in
                    NavigationLink(destination: PaperDetailView(paper: paper)) {
                        PaperItemView(paper: paper)
                    }
                }.onDelete(perform: deletePapers)
            }.navigationTitle("List of papers")
            .navigationBarItems(trailing: Button(action: {
                self.isPresented = true
            }) {
                Label("Add paper", systemImage: "plus")
            })
        }
        .sheet(isPresented: $isPresented) {
            NavigationView {
                newPaperSheet
                    .navigationBarItems(leading: Button("Dismiss") {
                        self.isPresented = false
                    }, trailing: Button("Add") {
                        let paper = Paper(context: viewContext)
                        paper.title = newPaper.title
                        paper.url = newPaper.url
                        paper.isLiked = newPaper.isLiked
                        paper.publishDate = newPaper.date
                        viewContext.saveOrError()
                        self.isPresented = false
                    })
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private func deletePapers(offsets: IndexSet) {
        offsets.map { papers[$0] }.forEach(viewContext.delete)
        viewContext.saveOrError()
    }
    
    private var newPaperSheet: some View {
        Form {
            Section(header: Text("General")) {
                TextField("Title", text: $newPaper.title)
                TextField("Link to Paper", text: $newPaper.url)
                Toggle("Like this Paper", isOn: $newPaper.isLiked)
            }
            
            Section(header: Text("Date")) {
                DatePicker("Published Date", selection: $newPaper.date)
            }
        }
    }
}
