import SwiftUI

@main
struct Oxfordgames_OnlineApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            OxfordgamesRoot()
                .preferredColorScheme(.light)
        }
    }
}
