//
//  EditMemoView.swift
//  swiftui-coredata
//
//  Created by yuki naniwa on 2025/03/13.
//

import SwiftUI

struct EditMemoView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var title: String
    @State private var content: String
    
    private var memo: Memo
    
    init(memo: Memo) {
        self.memo = memo
        self.title = memo.title ?? ""
        self.content = memo.content ?? ""
    }
    
    var body: some View {
        VStack {
            TextField("タイトル", text: $title)
                .font(.title)
            
            TextEditor(text: $content)
                .font(.body)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    saveMemo()
                }) {
                    Text("保存")
                }
            }
        }
    }
    
    private func saveMemo() {
        memo.title = title
        memo.content = content
        memo.updatedAt = Date()

        try? viewContext.save()
    }
}

#Preview {
    EditMemoView(memo: Memo())
}
