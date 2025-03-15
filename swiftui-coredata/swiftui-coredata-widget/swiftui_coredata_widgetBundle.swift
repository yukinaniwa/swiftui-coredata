//
//  swiftui_coredata_widgetBundle.swift
//  swiftui-coredata-widget
//
//  Created by yuki naniwa on 2025/03/15.
//

import WidgetKit
import SwiftUI

@main
struct swiftui_coredata_widgetBundle: WidgetBundle {
    var body: some Widget {
        swiftui_coredata_widget()
        swiftui_coredata_widgetControl()
        swiftui_coredata_widgetLiveActivity()
    }
}
