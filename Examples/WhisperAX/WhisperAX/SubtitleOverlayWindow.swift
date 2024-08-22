//
//  Untitled.swift
//  WhisperAX
//
//  Created by Chris Vasselli on 8/21/24.
//
import SwiftUI

struct SubtitleOverlayWindow: View {
    var liveTranslationModel: LiveTranslationViewModel
    
    var body: some View {
        if #available(macOS 15.0, *) {
            contents
                .onChange(of: liveTranslationModel.englishText) { oldValue, newValue in
                    liveTranslationModel.triggerTranslation()
                }
                .translationTask(liveTranslationModel.translationConfiguration) { session in
                    await liveTranslationModel.translate(text: liveTranslationModel.englishText ?? "", using: session)
                }
        }
        else {
            contents
        }
    }
    
    @ViewBuilder
    var contents: some View {
        VStack {
            Text(liveTranslationModel.japaneseText ?? "")
                .font(.largeTitle)
                .foregroundStyle(.white)
                .shadow(radius: 2)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
    }
    
}
