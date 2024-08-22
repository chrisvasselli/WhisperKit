import Foundation
import Speech
import Translation
import WhisperKit

@Observable
class LiveTranslationViewModel {
    var previousEnglishText: String?
    var previousJapaneseText: String?
    var englishText: String?
    var japaneseText: String?
    var errorMessage: String?
        
    private var readyForBumpToPreviousText: Bool = false
    
    var translationConfiguration: TranslationSession.Configuration?
    
    convenience init(english: String, japanese: String) {
        self.init()
        
        self.japaneseText = japanese
    }
    
    init() {
        
    }
    
    @available(macOS 15.0, *)
    func triggerTranslation() {
        if translationConfiguration == nil {
            // Set the language pairing.
            translationConfiguration = .init(source: Locale.Language(identifier: "en-US"),
                                  target: Locale.Language(identifier: "ja-JP"))
        } else {
            // Invalidate the previous configuration.
            translationConfiguration?.invalidate()
        }
    }
    
    @available(macOS 15.0, *)
    func translate(text: String, using session: TranslationSession) async {
        do {
            let response = try await session.translate(text)
            japaneseText = response.targetText
        } catch {
            print(error)
        }
    }
}
