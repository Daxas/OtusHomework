//
//  HomeworkWidget.swift
//  HomeworkWidget
//
//  Created by Daria.S on 12.12.2021.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SuffixResultsEntry {
        SuffixResultsEntry(date: Date(), topResults: "Top suffix results")
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SuffixResultsEntry) -> ()) {
        let entry = SuffixResultsEntry(date: Date(), topResults: "Top suffix results")
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let suffixes = UserDefaults(suiteName: "group.serber.homework")?.object(forKey:"SavedArray") as? [String] ?? ["NO data"]
        
        let nextUpdate = Date().addingTimeInterval(120)
        var resultStr: String = ""
        suffixes.forEach { resultStr.append($0)}
        let entry = SuffixResultsEntry(date: nextUpdate, topResults: resultStr)
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
}

struct SuffixResultsEntry: TimelineEntry {
    let date: Date
    let topResults: String
}

struct HomeworkWidgetEntryView : View {
    var entry: Provider.Entry
    
    @Environment(\.widgetFamily) var family
    
    var body: some View {
        VStack {
            Text(entry.topResults)
            switch family {
            case .systemSmall:
                Text("Text")
                    .bold()
                    .font(.title)
                    .foregroundColor(Color.white)
                    .padding()
                    .background(ContainerRelativeShape().fill(Color.green.opacity(0.6)))
            default:
                HStack{
                    Link(destination: URL(string: "homework:///results")!, label: {
                        Text("Results")
                            .bold()
                            .font(.title)
                            .foregroundColor(Color.white)
                            .padding()
                            .background(ContainerRelativeShape().fill(Color.green.opacity(0.6)))
                    })
                    Spacer()
                    Link(destination: URL(string: "homework:///text")!, label: {
                        Text("Text")
                            .bold()
                            .font(.title)
                            .foregroundColor(Color.white)
                            .padding()
                            .background(ContainerRelativeShape().fill(Color.green.opacity(0.6)))
                    })
                }
                .padding()
            }
        }
    }
}

@main
struct HomeworkWidget: Widget {
    let kind: String = "HomeworkWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            HomeworkWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("HomeworkWidget")
        .description("Top suffix results")
    }
}

struct HomeworkWidget_Previews: PreviewProvider {
    static var previews: some View {
        HomeworkWidgetEntryView(entry: SuffixResultsEntry(date: Date(), topResults: "Top suffix results"))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
