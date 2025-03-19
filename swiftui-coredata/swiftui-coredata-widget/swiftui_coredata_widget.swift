//
//  swiftui_coredata_widget.swift
//  swiftui-coredata-widget
//
//  Created by yuki naniwa on 2025/03/15.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent())
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }

//    func relevances() async -> WidgetRelevances<ConfigurationAppIntent> {
//        // Generate a list containing the contexts this widget is relevant in.
//    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
}

struct swiftui_coredata_widgetEntryView : View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Memo.updatedAt, ascending: false)],
        animation: .default)
    
    private var fetchedMemoList: FetchedResults<Memo>
    
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text("Memo:")
            ForEach(fetchedMemoList.prefix(2)) { memo in
                VStack {
                    Text(memo.title ?? "")
                        .font(.title)
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .lineLimit(1)
                    
                    HStack {
                        Text (memo.stringUpdatedAt)
                            .font(.caption)
                            .lineLimit(1)
                        
                        Spacer()
                    }
                }
            }
            
            Spacer()
        }
    }
}

struct swiftui_coredata_widget: Widget {
    let kind: String = "swiftui_coredata_widget"
    let persistenceController = PersistenceController.shared

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            swiftui_coredata_widgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
                .environment(\.managedObjectContext,
                                              persistenceController.container.viewContext) // coredata
        }
    }
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

#Preview(as: .systemSmall) {
    swiftui_coredata_widget()
} timeline: {
    SimpleEntry(date: .now, configuration: .smiley)
    SimpleEntry(date: .now, configuration: .starEyes)
}
