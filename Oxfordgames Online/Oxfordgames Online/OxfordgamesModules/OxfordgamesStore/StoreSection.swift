import SwiftUI

enum StoreSection: Codable, Hashable {
    case backgrounds
    case skin
}

class StoreViewModelSG: ObservableObject {
    @Published var shopTeamItems: [Item] = [
        
        Item(name: "bgName1Oxfordgames", image: "gameBg1SG", icon: "backIcon1Oxfordgames", section: .backgrounds, price: 100),
        Item(name: "bgName2Oxfordgames", image: "gameBg2SG", icon: "backIcon2Oxfordgames", section: .backgrounds, price: 100),
        Item(name: "bgName3Oxfordgames", image: "gameBg3SG", icon: "backIcon3Oxfordgames", section: .backgrounds, price: 100),
        Item(name: "bgName4Oxfordgames", image: "gameBg4SG", icon: "backIcon4Oxfordgames", section: .backgrounds, price: 100),
        
        
        Item(name: "itemName1", image: "imageSkin1SG", icon: "itemIcon1", section: .skin, price: 100),
        Item(name: "itemName2", image: "imageSkin2SG", icon: "itemIcon2", section: .skin, price: 100),
        Item(name: "itemName3", image: "imageSkin3SG", icon: "itemIcon3", section: .skin, price: 100),
        Item(name: "itemName4", image: "imageSkin4SG", icon: "itemIcon4", section: .skin, price: 100),
         
    ]
    
    @Published var boughtItems: [Item] = [
        Item(name: "bgName1Oxfordgames", image: "gameBg1SG", icon: "backIcon1Oxfordgames", section: .backgrounds, price: 100),
        Item(name: "itemName1", image: "imageSkin1SG", icon: "itemIcon1", section: .skin, price: 100),
    ] {
        didSet {
            saveBoughtItem()
        }
    }
    
    @Published var currentBgItem: Item? {
        didSet {
            saveCurrentBg()
        }
    }
    
    @Published var currentPersonItem: Item? {
        didSet {
            saveCurrentPerson()
        }
    }
    
    init() {
        loadCurrentBg()
        loadCurrentPerson()
        loadBoughtItem()
    }
    
    private let userDefaultsBgKey = "bgKeyOxfordgames"
    private let userDefaultsPersonKey = "skinKeyOxfordgames"
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
           let loadedItem = try? JSONDecoder().decode(Item.self, from: savedData) {
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
           let loadedItem = try? JSONDecoder().decode(Item.self, from: savedData) {
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
           let loadedItem = try? JSONDecoder().decode([Item].self, from: savedData) {
            boughtItems = loadedItem
        } else {
            print("No saved data found")
        }
    }
    
}

struct Item: Codable, Hashable {
    var id = UUID()
    var name: String
    var image: String
    var icon: String
    var section: StoreSection
    var price: Int
}
