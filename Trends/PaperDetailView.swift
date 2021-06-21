//
//  PaperDetailView.swift
//  Trends
//
//  Created by 魏宇翔 on 2021/6/21.
//

import SwiftUI

struct PaperDetailView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @ObservedObject var paper: Paper
    @State var date: Date = Date()
    
    struct Key {
        static let general = "General Info"
        static let title = "Title"
        static let link = "Link to Source"
        static let star = "Star this Paper"
        static let date = "Date Published"
        static let unknown = "Unknown"
    }
    
    var body: some View {
        Form {
            Section(header: Text(Key.general)) {
                NavigationLink(destination: setting(for: Key.title, text: Binding($paper.title)!)) {
                    ItemView(title: Key.title, value: paper.title!)
                }
                NavigationLink(destination: setting(for: Key.link, text: Binding($paper.url)!)) {
                    ItemView(title: "Link to Source", value: paper.url!)
                }
                Toggle("Star this Paper", isOn: $paper.isLiked)
            }
            Section(header: Text("Authors")) {
                Text("TODO")
            }
            Section(header: Text("Publication")) {
                NavigationLink(destination: datePicker) {
                    ItemView(title: "Date Published", value:  paper.publishDate?.description ?? "Unknown")
                }
                
                if let conference = paper.conference {
                    ItemView(title: "Conference", value: conference.name ?? "Unknown")
                }
                if let journal = paper.journal {
                    ItemView(title: "Journal", value: journal.name ?? "Unknown")
                }
            }
        }
        .navigationTitle("Paper Details")
    }
    
    var datePicker: some View {
        Form {
            DatePicker("Date", selection: $date)
                .navigationBarTitle("Date Published", displayMode: .inline)
                .onDisappear {
                    paper.publishDate = date
                    viewContext.saveOrError()
                }
        }
    }
    
    var titleSetting: some View {
        Form {
            TextField("Enter the title", text: Binding($paper.title)!)
        }
        .navigationBarTitle("Title", displayMode: .inline)
        .onDisappear {
            viewContext.saveOrError()
        }
    }
    
    func setting(for title: String, text: Binding<String>, titleKey: String? = nil) -> some View {
        Form {
            TextField(titleKey ?? "Enter the \(title.lowercased())", text: text)
        }.navigationBarTitle(title, displayMode: .inline)
        .onDisappear {
            viewContext.saveOrError()
        }
    }
}

struct PaperDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PaperDetailView(paper: Paper(context: PersistenceController.preview.container.viewContext))
                .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }.environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
