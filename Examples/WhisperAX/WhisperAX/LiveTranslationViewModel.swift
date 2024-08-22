import Foundation
import Speech
import Translation
import WhisperKit

@available(macOS 15.0, *) 
@Observable
class LiveTranslationViewModel {
    var previousEnglishText: String?
    var previousJapaneseText: String?
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
    
    func translate(text: String, using session: TranslationSession) async {
        do {
            let response = try await session.translate(text)
            japaneseText = response.targetText
        } catch {
            print(error)
        }
    }
}
