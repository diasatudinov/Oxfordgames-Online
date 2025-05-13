import SwiftUI

class SettingsViewModelSG: ObservableObject {
    @AppStorage("soundEnabled") var soundEnabled: Bool = true
}
