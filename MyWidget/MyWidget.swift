//
//  MyWidget.swift
//  MyWidget
//
//  Created by Александр Вяткин on 31.10.2021.
//

import WidgetKit
import SwiftUI
import Intents
import Foundation

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }
    
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }
    
    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}
struct WidgetInfoView: View {
    var body: some View {
        HStack {
            Link(destination: URL(string: "widget://link1")!) {
                VStack(spacing: 20) {
                    Image(systemName: "newspaper")
                    Text("Go to 1st tab")
                }.padding()
            }
            Link(destination: URL(string: "widget://link2")!) {
                VStack(spacing: 20) {
                    Image(systemName: "film")
                    Text("Go to 2nd tab")
                }
                .padding()
            }
        }
    }
}
struct suffixItem: Equatable, Hashable, Comparable, Codable {
    static func < (lhs: suffixItem, rhs: suffixItem) -> Bool {
        return lhs.name < rhs.name
    }
    
    var id: UUID = UUID()
    var name: String
    var count: Int = 1
}
class widgetVM: ObservableObject {
    @Published var test = [suffixItem]()
    
    init() {
        getWidgetData()
    }
    
    func getWidgetData() {
        
    }
}
struct SuffixTopInfo: View {
    var suffixArray: [suffixItem] {
        let encodedData  = UserDefaults(suiteName: "group.trying.SuiApp3")!.object(forKey: "widgetData") as? Data
        var returnedData: [suffixItem] = .init()
        if let arrayEncoded = encodedData {
            let arrayDecoded = try? JSONDecoder().decode([suffixItem].self, from: arrayEncoded)
            if let suffix = arrayDecoded{
                returnedData = suffix
            }
        }
        return returnedData
    }
    
    var body: some View {
        VStack {
            Text("TOP10")
            ForEach(suffixArray, id: \.self) { suffix in
                HStack {
                    Text(suffix.name)
                    Spacer()
                    Text("\(suffix.count)")
                }
            }
            
        }.padding()
    }
}

struct MyWidgetEntryView : View {
    var entry: Provider.Entry
    
    @Environment(\.widgetFamily) var family
    
    var body: some View {
        switch family {
        case .systemSmall:
            Text(entry.date, style: .time)
        case .systemMedium:
            WidgetInfoView()
        case .systemLarge:
            SuffixTopInfo()
        default:
            WidgetInfoView()
            //ProfileView(profile: entry.profile)
        }
    }
}

@main
struct MyWidget: Widget {
    let kind: String = "MyWidget"
    
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            MyWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct MyWidget_Previews: PreviewProvider {
    static var previews: some View {
        MyWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
