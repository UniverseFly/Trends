//
//  PostView.swift
//  Trends
//
//  Created by 魏宇翔 on 2021/6/21.
//

import SwiftUI

struct PostView: View {
    let post: Post
    
    var body: some View {
        if let colorData = post.color, let uiColor = UIColor.decode(data: colorData) {
            let swiftUIColor = Color(uiColor)
            return AnyView(bodyNoColor.foregroundColor(swiftUIColor.accessibleFontColor))
        } else {
            return AnyView(bodyNoColor)
        }
    }
    
    var bodyNoColor: some View {
        VStack(alignment: .leading) {
            Text(post.title?.description ?? "Unknown")
                .font(.headline)
            Text(post.content ?? "Unknown")
            Spacer()
            HStack {
                Label(post.account?.nickname ?? "Unknown", systemImage: "person")
                Spacer()
                Label(post.date?.description ?? "Unknown", systemImage: "clock")
                    .padding(.trailing, 20)
            }
            .font(.caption)
        }
        .padding()
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView(post: Post(context: PersistenceController.preview.container.viewContext))
//            .background(scrum.color)
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
