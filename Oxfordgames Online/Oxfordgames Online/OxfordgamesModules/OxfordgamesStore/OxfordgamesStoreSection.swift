import SwiftUI

enum OxfordgamesStoreSection: Codable, Hashable {
    case backgrounds
    case skin
}

class OxfordgamesStoreViewModel: ObservableObject {
    @Published var shopTeamItems: [OxfordgamesItem] = [
        
        OxfordgamesItem(name: "bgName1Oxfordgames", image: "gameBg1Oxfordgames", icon: "backIcon1Oxfordgames", section: .backgrounds, price: 100),
        OxfordgamesItem(name: "bgName2Oxfordgames", image: "gameBg2Oxfordgames", icon: "backIcon2Oxfordgames", section: .backgrounds, price: 100),
        OxfordgamesItem(name: "bgName3Oxfordgames", image: "gameBg3Oxfordgames", icon: "backIcon3Oxfordgames", section: .backgrounds, price: 100),
        OxfordgamesItem(name: "bgName4Oxfordgames", image: "gameBg4Oxfordgames", icon: "backIcon4Oxfordgames", section: .backgrounds, price: 100),
        
        
        OxfordgamesItem(name: "itemName1", image: "imageSkin1Oxfordgames", icon: "itemIcon1", section: .skin, price: 100),
        OxfordgamesItem(name: "itemName2", image: "imageSkin2Oxfordgames", icon: "itemIcon2", section: .skin, price: 100),
        OxfordgamesItem(name: "itemName3", image: "imageSkin3Oxfordgames", icon: "itemIcon3", section: .skin, price: 100),
        OxfordgamesItem(name: "itemName4", image: "imageSkin4Oxfordgames", icon: "itemIcon4", section: .skin, price: 100),
         
    ]
    
    @Published var boughtItems: [OxfordgamesItem] = [
        OxfordgamesItem(name: "bgName1Oxfordgames", image: "gameBg1SG", icon: "backIcon1Oxfordgames", section: .backgrounds, price: 100),
        OxfordgamesItem(name: "itemName1", image: "imageSkin1SG", icon: "itemIcon1", section: .skin, price: 100),
    ] {
        didSet {
            saveBoughtItem()
        }
    }
    
    @Published var currentBgItem: OxfordgamesItem? {
        didSet {
            saveCurrentBg()
        }
    }
    
    @Published var currentPersonItem: OxfordgamesItem? {
        didSet {
            saveCurrentPerson()
        }
    }
    
    init() {
        loadCurrentBg()
        loadCurrentPerson()
        loadBoughtItem()
    }
    
    private let userDefaultsBgKey = "bgKeyOxfordgamess"
    private let userDefaultsPersonKey = "skinKeyOxfordgamess"
    private let userDefaultsBoughtKey = "boughtItemsOxfordgames"

    
    func saveCurrentBg() {
        if let currentItem = currentBgItem {
            if let encodedData = try? JSONEncoder().encode(currentItem) {
                UserDefaults.standard.set(encodedData, forKey: userDefaultsBgKey)
            }
        }
    }
    
    func loadCurrentBg() {
        if let savedData = UserDefaults.standard.data(forKey: userDefaultsBgKey),
           let loadedItem = try? JSONDecoder().decode(OxfordgamesItem.self, from: savedData) {
            currentBgItem = loadedItem
        } else {
            currentBgItem = shopTeamItems[0]
            print("No saved data found")
        }
    }
    
    func saveCurrentPerson() {
        if let currentItem = currentPersonItem {
            if let encodedData = try? JSONEncoder().encode(currentItem) {
                UserDefaults.standard.set(encodedData, forKey: userDefaultsPersonKey)
            }
        }
    }
    
    func loadCurrentPerson() {
        if let savedData = UserDefaults.standard.data(forKey: userDefaultsPersonKey),
           let loadedItem = try? JSONDecoder().decode(OxfordgamesItem.self, from: savedData) {
            currentPersonItem = loadedItem
        } else {
            currentPersonItem = shopTeamItems[4]
            print("No saved data found")
        }
    }
    
    func saveBoughtItem() {
        if let encodedData = try? JSONEncoder().encode(boughtItems) {
            UserDefaults.standard.set(encodedData, forKey: userDefaultsBoughtKey)
        }
        
    }
    
    func loadBoughtItem() {
        if let savedData = UserDefaults.standard.data(forKey: userDefaultsBoughtKey),
           let loadedItem = try? JSONDecoder().decode([OxfordgamesItem].self, from: savedData) {
            boughtItems = loadedItem
        } else {
            print("No saved data found")
        }
    }
    
}

struct OxfordgamesItem: Codable, Hashable {
    var id = UUID()
    var name: String
    var image: String
    var icon: String
    var section: OxfordgamesStoreSection
    var price: Int
}
