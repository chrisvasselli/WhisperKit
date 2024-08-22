//
//  ContentView.swift
//  LiveTranslation
//
//  Created by Chris Vasselli on 6/18/24.
//

import SwiftUI
import Translation

@available(macOS 15.0, *)
struct LiveTranslationView: View {
    var englishText: String
    @State var model: LiveTranslationViewModel = LiveTranslationViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
                    Text("English")
                        .font(.title.bold())
                    ScrollViewReader { proxy in
                        ScrollView {
                            Text(englishText)
                                .font(.title)
                                .truncationMode(.head)
                                .id("englishText")
                        }
                        .onChange(of: englishText) { _ in
                            withAnimation {
                                proxy.scrollTo("englishText", anchor: .bottom)
                            }
                        }
                    }
                    Spacer()
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray)
                }
                .padding()
                Spacer()
            }
            .containerRelativeFrame(.vertical, count: 2, spacing: 0)
            HStack {
                VStack(alignment: .leading) {
                    Text("日本語")
                        .font(.title.bold())
                    ScrollViewReader { proxy in
                        ScrollView {
                            Text(model.japaneseText ?? "")
                                .font(.title)
                                .truncationMode(.head)
                                .id("japaneseText")
                        }
                        .onChange(of: model.japaneseText) { _ in
                            withAnimation {
                                proxy.scrollTo("japaneseText", anchor: .bottom)
                            }
                        }
                    }
                    Spacer()
                }
                .padding()
                Spacer()
            }
            .containerRelativeFrame(.vertical, count: 2, spacing: 0)
            
        }
        .padding()
        .onChange(of: englishText) { oldValue, newValue in
            model.triggerTranslation()
        }
        .translationTask(model.translationConfiguration) { session in
            await model.translate(text: englishText, using: session)
        }
    }
}
