//
//  swiftui_coredata_widgetLiveActivity.swift
//  swiftui-coredata-widget
//
//  Created by yuki naniwa on 2025/03/15.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct swiftui_coredata_widgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct swiftui_coredata_widgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: swiftui_coredata_widgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension swiftui_coredata_widgetAttributes {
    fileprivate static var preview: swiftui_coredata_widgetAttributes {
        swiftui_coredata_widgetAttributes(name: "World")
    }
}

extension swiftui_coredata_widgetAttributes.ContentState {
    fileprivate static var smiley: swiftui_coredata_widgetAttributes.ContentState {
        swiftui_coredata_widgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: swiftui_coredata_widgetAttributes.ContentState {
         swiftui_coredata_widgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: swiftui_coredata_widgetAttributes.preview) {
   swiftui_coredata_widgetLiveActivity()
} contentStates: {
    swiftui_coredata_widgetAttributes.ContentState.smiley
    swiftui_coredata_widgetAttributes.ContentState.starEyes
}
