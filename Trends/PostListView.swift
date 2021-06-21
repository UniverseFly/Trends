//
//  PostListView.swift
//  Trends
//
//  Created by 魏宇翔 on 2021/6/21.
//

import SwiftUI
import UIKit

struct PostListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [])
    var posts: FetchedResults<Post>
    
    struct PostData {
        var title = ""
        var content = ""
        var date = Date()
        var url = ""
        var color: Color = .green
    }
    
    @State var newPost = PostData()
    @State var isPresented = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(posts) { post in
                    PostView(post: post)
                        .listRowBackground(post.color != nil &&  UIColor.decode(data: post.color!) != nil ? AnyView(Color(UIColor.decode(data: post.color!)!)) : AnyView(EmptyView()))
                }.onDelete(perform: deletePosts)
            }
            .sheet(isPresented: $isPresented, content: {
                newPostSheet
            })
            .navigationTitle("List of Posts")
            .navigationBarItems(trailing: Button(action: {
                self.isPresented = true
            }) {
                Label("Add post", systemImage: "plus")
            })
        }
    }
    
    private func deletePosts(offsets: IndexSet) {
        offsets.map { posts[$0] }.forEach(viewContext.delete)
        viewContext.saveOrError()
    }
    
    var newPostSheet: some View {
        NavigationView {
            Form {
                TextField("Title", text: $newPost.title)
                TextField("Content", text: $newPost.content)
                ColorPicker("Color", selection: $newPost.color)
                TextField("Link to Post", text: $newPost.url)
                DatePicker("Creation Date", selection: $newPost.date)
            }
            .navigationBarItems(leading: Button("Dismiss") {
                self.isPresented = false
            }, trailing: Button("Add") {
                let post = Post(context: viewContext)
                post.title = newPost.title
                post.content = newPost.content
                post.date = newPost.date
                post.url = newPost.url
                post.color = UIColor(newPost.color).encode()
                viewContext.saveOrError()
                self.isPresented = false
            })
        }
    }
}

struct PostListView_Previews: PreviewProvider {
    static var previews: some View {
        PostListView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
