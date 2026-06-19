//
//  StreakWidget_Extesion.swift
//  StreakWidget-Extesion
//
//  Created by Yohane Cavalcante on 16/06/26.
//

import WidgetKit
import SwiftUI

private enum StreakWidgetStyle {
    static let appGroup = "group.DailyBites"
    static let streakKey = "currentStreak"
    static let roxoAcao = Color(red: 0x76 / 255, green: 0x41 / 255, blue: 0xE3 / 255)
    static let roxoBackground = Color(red: 0xD9 / 255, green: 0xD4 / 255, blue: 0xFD / 255)
}

struct StreakEntry: TimelineEntry {
    let date: Date
    let streak: Int
}

struct StreakCardWidget: TimelineProvider {
    func placeholder(in context: Context) -> StreakEntry {
        StreakEntry(date: Date(), streak: 3)
    }

    func getSnapshot(in context: Context, completion: @escaping (StreakEntry) -> Void) {
        completion(StreakEntry(date: Date(), streak: currentStreak))
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<StreakEntry>) -> Void) {
        let entry = StreakEntry(date: Date(), streak: currentStreak)
        let nextUpdate = Calendar.current.nextDate(
            after: Date(),
            matching: DateComponents(hour: 0, minute: 5),
            matchingPolicy: .nextTime
        ) ?? Date().addingTimeInterval(60 * 60)
        
        completion(Timeline(entries: [entry], policy: .after(nextUpdate)))
    }
    
    private var currentStreak: Int {
        UserDefaults(suiteName: StreakWidgetStyle.appGroup)?.integer(forKey: StreakWidgetStyle.streakKey) ?? 0
    }
}

struct StreakWidget_ExtesionEntryView: View {
    @Environment(\.widgetFamily) private var widgetFamily

    var entry: StreakEntry

    var body: some View {
        Group {
            switch widgetFamily {
            case .systemMedium:
                mediumLayout
            default:
                smallLayout
            }
        }
        .accessibilityElement(children: .contain)
        .padding(10)
        .containerBackground(for: .widget) {
            StreakWidgetStyle.roxoBackground
        }
    }

    private var smallLayout: some View {
        VStack(alignment: .leading) {
            
            header
                .padding(.bottom, 6)
            HStack {
                streakText
                    
                mascotImage
                    .frame(width: 70, height: 70)
            }
            
            
            
            
        }
    }

    private var mediumLayout: some View {
        HStack(alignment: .center, spacing: 16) {
            VStack(alignment: .leading, spacing: 8) {
                header

                streakTextMedium
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            mascotImage
                .frame(width: 130, height: 130)
        }
    }

    private var header: some View {
        HStack(spacing: 10) {
            Image(systemName: "bolt.fill")
                .accessibilityHidden(true)
            Text("STREAK")
                .bold()
        }
        .font(.caption)
        .foregroundColor(StreakWidgetStyle.roxoAcao)
    }

    private var mascotImage: some View {
        Image("Uva")
            .resizable()
            .scaledToFit()
            .accessibilityLabel("Mascote Uva de olho na sua sequencia")
    }

    private var streakText: some View {
        VStack {
            Text("você registrou")
                .font(Font.custom("PlusJakartaSans-bold", size: 16))
                .bold(true)
                .foregroundStyle(Color.black)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("\(entry.streak)")
                .font(Font.custom("PlusJakartaSans-Bold", size: 60))
                .foregroundStyle(StreakWidgetStyle.roxoAcao)
                .minimumScaleFactor(0.6)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(entry.streak == 1 ? "dia" : "dias")
                .font(Font.custom("PlusJakartaSans-Bold", size: 16))
                .foregroundStyle(Color.black)
                .bold()
            
                .frame(maxWidth: .infinity, alignment: .leading)
                
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .accessibilityElement(children: .combine)
    }
    private var streakTextMedium: some View {
            VStack(alignment: .leading, spacing: 0) {
                Text("você registrou")
                    .font(Font.custom("PlusJakartaSans-Semibold", size: 20))
                    .foregroundStyle(Color.black)
                HStack(alignment: .bottom, spacing: 4) {
                    Text("\(entry.streak)")
                        .font(Font.custom("PlusJakartaSans-Semibold", size: 80))
                        .bold(true)
                        .foregroundStyle(StreakWidgetStyle.roxoAcao)
                        .minimumScaleFactor(0.6)
                    
                    Text(entry.streak == 1 ? "dia" : "dias")
                        .font(Font.custom("PlusJakartaSans-Semibold", size: 20))
                        .foregroundStyle(Color.black)
                        .padding(.bottom, 10)
                }
                .frame(maxWidth: .infinity)
            }
            .accessibilityElement(children: .combine)
        }
}

struct WidgetStreakCard_Extesion: Widget {
    let kind: String = "StreakWidget_Extesion"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: StreakCardWidget()) { entry in
            StreakWidget_ExtesionEntryView(entry: entry)
        }
        .configurationDisplayName("Streak")
        .description("Acompanhe sua sequência de registros.")
        .supportedFamilies([.systemSmall, .systemMedium])
        .contentMarginsDisabled()
    }
}

#Preview(as: .systemSmall) {
    WidgetStreakCard_Extesion()
} timeline: {
    StreakEntry(date: .now, streak: 3)
    StreakEntry(date: .now, streak: 12)
}
