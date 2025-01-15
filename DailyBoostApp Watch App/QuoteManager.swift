//
//  QuoteManager.swift
//  DailyBoostApp
//
//  Created by malva on 14/01/25.
//

import Foundation
import UserNotifications
import WatchKit

class QuoteManager: ObservableObject {
    @Published var currentQuote: String = ""
    @Published var currentQuestion: String = ""
    
    private let quotes = [
        "The only way to do great work is to love what you do.",
        "Success is not final, failure is not fatal: it is the courage to continue that counts.",
        "Believe you can and you're halfway there.",
        "Don't watch the clock; do what it does. Keep going.",
        "The future belongs to those who believe in the beauty of their dreams."
    ]
    
    private let questions = [
        "What's one small step you can take today towards your goals?",
        "What are you grateful for this morning?",
        "How can you make someone else's day better today?",
        "What's one thing you learned yesterday that you can apply today?",
        "What would make today great for you?"
    ]
    
    init() {
        loadDailyContent()
    }
    
    func loadDailyContent() {
        refreshQuote()
        refreshQuestion()
        scheduleNextUpdate()
    }
    
    func refreshQuote() {
        currentQuote = quotes.randomElement() ?? quotes[0]
    }
    
    func refreshQuestion() {
        currentQuestion = questions.randomElement() ?? questions[0]
    }
    
    private func scheduleNextUpdate() {
        // Schedule next update for midnight
        let calendar = Calendar.current
        guard let tomorrow = calendar.date(byAdding: .day, value: 1, to: Date()) else { return }
        let midnight = calendar.startOfDay(for: tomorrow)
        
        // Create notification content
        let content = UNMutableNotificationContent()
        content.title = "New Daily Boost"
        content.body = "Your new quote and question are ready!"
        content.sound = .default
        
        // Create trigger
        let triggerComponents = Calendar.current.dateComponents([.hour, .minute], from: midnight)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerComponents, repeats: true)
        
        // Create request
        let request = UNNotificationRequest(
            identifier: "dailyUpdate",
            content: content,
            trigger: trigger
        )
        
        // Schedule notification
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            }
        }
    }
    
    func registerForNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
            if granted {
                print("Notification permission granted")
            } else if let error = error {
                print("Error requesting notification permission: \(error.localizedDescription)")
            }
        }
    }
}
