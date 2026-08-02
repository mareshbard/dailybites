//
//  Notifications.swift
//  DailyBites
//
//  Created by Yohane Cavalcante on 15/06/26.
//

import Foundation
import UserNotifications

struct Notifications {
    
    static func requestNotificationAuthorization() {
        let notificationCenter = UNUserNotificationCenter.current()
        
        notificationCenter.getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .authorized:
                return
            case .denied:
                return
            case .notDetermined:
                notificationCenter.requestAuthorization(options: [.alert, .sound]) { _, _ in }
            default:
                return
            }
        }
    }
    
    static func sendNotification(for meal: Meal) {
        let notificationCenter = UNUserNotificationCenter.current()
        let identifiers = notificationIdentifiers(for: meal)
        notificationCenter.removePendingNotificationRequests(withIdentifiers: identifiers)
        
//        let repeatDays = normalizedRepeatDays(from: meal.repeatDays)
//        if meal.isFixed && repeatDays.isEmpty {
//            return
//        }
//        
        let content = UNMutableNotificationContent()
        content.title = "Faça sua refeição"
        content.body = "Ei, não esqueça de fazer a sua refeição \(meal.name)!"
        content.sound = .default
        
        let timeComponents = Calendar.current.dateComponents([.hour, .minute], from: meal.time)
//        let weekdays = meal.isFixed ? repeatDays : []
        
        if meal.isFixed {
            addNotification(
                identifier: dailyNotificationIdentifier(for: meal),
                content: content,
                hour: timeComponents.hour,
                minute: timeComponents.minute,
//                weekday: nil,
                notificationCenter: notificationCenter
            )
            return
        }
        
//        for weekday in weekdays {
//            addNotification(
//                identifier: weekdayNotificationIdentifier(for: meal, weekday: weekday),
//                content: content,
//                hour: timeComponents.hour,
//                minute: timeComponents.minute,
//                weekday: weekday,
//                notificationCenter: notificationCenter
//            )
//        }
    }
    
    static func removeNotifications(for meal: Meal) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: notificationIdentifiers(for: meal))
    }
    
    private static func addNotification(
        identifier: String,
        content: UNNotificationContent,
        hour: Int?,
        minute: Int?,
//        weekday: Int?,
        notificationCenter: UNUserNotificationCenter
    ) {
        var dateComponents = DateComponents(calendar: Calendar.current, timeZone: TimeZone.current)
        dateComponents.hour = hour
        dateComponents.minute = minute
//        dateComponents.weekday = weekday
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        notificationCenter.add(request) { error in
            if let error {
                print("Notification scheduling failed", identifier, error.localizedDescription)
            }
        }
    }
    
//    private static func normalizedRepeatDays(from repeatDays: [Int]) -> [Int] {
//        Array(Set(repeatDays.compactMap { day in
//            guard (0...6).contains(day) else { return nil }
//            return day + 1
//        })).sorted()
//    }
    
    private static func notificationIdentifiers(for meal: Meal) -> [String] {
        [dailyNotificationIdentifier(for: meal)]
    }
    
    private static func dailyNotificationIdentifier(for meal: Meal) -> String {
        "Meal Reminder-\(mealUUID(for: meal).uuidString)"
    }

    /// Garante um identificador estável por refeição. Refeições antigas (migradas) podem ter
    /// `uuid` nulo até o backfill; nesse caso um valor é atribuído e persistido aqui, evitando
    /// que a mesma refeição gere notificações duplicadas.
    private static func mealUUID(for meal: Meal) -> UUID {
        if let uuid = meal.uuid {
            return uuid
        }
        let uuid = UUID()
        meal.uuid = uuid
        return uuid
    }
    
//    private static func weekdayNotificationIdentifier(for meal: Meal, weekday: Int) -> String {
//        "Meal Reminder-\(meal.id)-weekday-\(weekday)"
//    }
}
