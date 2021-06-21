//
//  PaperItemView.swift
//  Trends
//
//  Created by 魏宇翔 on 2021/6/20.
//

import SwiftUI

struct PaperItemView: View {
    @ObservedObject var paper: Paper
    
    var body: some View {
        HStack {
            Image(systemName: paper.isLiked ? "star.fill" : "star")
                .foregroundColor(.orange)
                .onTapGesture {
                    withAnimation {
                        paper.isLiked.toggle()
                        try? paper.managedObjectContext?.save()
                    }
                }
            VStack(alignment: .leading) {
                Text(paper.title ?? "Unknown")
                Text("Area: \(paper.area?.name ?? "Database")")
                    .font(.caption)
                    .foregroundColor(.purple)
            }
        }
    }
}
