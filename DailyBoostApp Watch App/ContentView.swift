//
//  ContentView.swift
//  DailyBoostApp Watch App
//
//  Created by malva on 14/01/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var quoteManager = QuoteManager()
    @State private var isShowingQuestion = false
    
    var body: some View {
        TabView {
            // Quote View
            VStack {
                Text("Daily Quote")
                    .font(.system(.headline))
                    .padding(.top, 10)
                
                Text(quoteManager.currentQuote)
                    .font(.system(.body))
                    .multilineTextAlignment(.center)
                    .padding()
                
                Button(action: {
                    withAnimation {
                        quoteManager.refreshQuote()
                    }
                }) {
                    Image(systemName: "arrow.clockwise")
                        .font(.system(.title2))
                }
            }
            
            // Question View
            VStack {
                Text("Reflection")
                    .font(.system(.headline))
                    .padding(.top, 10)
                
                Text(quoteManager.currentQuestion)
                    .font(.system(.body))
                    .multilineTextAlignment(.center)
                    .padding()
                
                Button(action: {
                    withAnimation {
                        quoteManager.refreshQuestion()
                    }
                }) {
                    Image(systemName: "arrow.clockwise")
                        .font(.system(.title2))
                }
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .onAppear {
            quoteManager.loadDailyContent()
        }
    }
}

