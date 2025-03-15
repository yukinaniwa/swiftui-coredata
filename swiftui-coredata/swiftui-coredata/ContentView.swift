//
//  ContentView.swift
//  swiftui-coredata
//
//  Created by yuki naniwa on 2025/03/13.
//

import SwiftUI
import CoreData
import WidgetKit

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Memo.updatedAt, ascending: false)],
        animation: .default)
    
    private var fetchedMemoList: FetchedResults<Memo>

    var body: some View {
        NavigationView {
            List {
                ForEach(fetchedMemoList) { memo in
                    NavigationLink(destination: EditMemoView(memo: memo)) {
                        VStack {
                            Text(memo.title ?? "")
                                .font(.title)
                                .frame(maxWidth: .infinity,alignment: .leading)
                                .lineLimit(1)
                            
                            HStack {
                                Text (memo.stringUpdatedAt)
                                    .font(.caption)
                                    .lineLimit(1)
                                
                                Text(memo.content ?? "")
                                    .font(.caption)
                                    .lineLimit(1)
                                
                                Spacer()
                            }
                        }
                    }
                }
                .onDelete(perform: deleteMemo)
            }
            .navigationTitle("Memo")
            .navigationBarTitleDisplayMode(.automatic)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: AddMemoView()) {
                        Text("新規作成")
                    }
                }
            }
        }
    }
    
    // 削除時の処理
    private func deleteMemo(offsets: IndexSet) {
        offsets.forEach { index in
            viewContext.delete(fetchedMemoList[index])
        }
        
        // 保存する
        try? viewContext.save()
        WidgetCenter.shared.reloadAllTimelines()
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
