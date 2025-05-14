import UIKit

class OxfordgamesDeviceManager {
    static let shared = OxfordgamesDeviceManager()
    
    var deviceType: UIUserInterfaceIdiom
    
    private init() {
        self.deviceType = UIDevice.current.userInterfaceIdiom
    }
}
