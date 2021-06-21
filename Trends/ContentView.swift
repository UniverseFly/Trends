//
//  ContentView.swift
//  Trends
//
//  Created by 魏宇翔 on 2021/6/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        TabView {
            PaperListView()
                .tabItem {
                    Image(systemName: "doc.richtext.fill")
                    Text("Papers")
                }
            PostListView()
                .tabItem {
                    Image(systemName: "signpost.right.fill")
                    Text("Posts")
                }
        }
    }
}
