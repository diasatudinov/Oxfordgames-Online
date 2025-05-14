import SwiftUI

class OxfordgamesAchievementsViewModel: ObservableObject {
    
    @Published var achievements: [OxfordgamesAchievement] = [
        OxfordgamesAchievement(image: "achi1IconOxfordgames", title: "achiTitle1", subtitle: "achiSubtitle1", isAchieved: false),
        OxfordgamesAchievement(image: "achi2IconOxfordgames", title: "achiTitle2", subtitle: "achiSubtitle2", isAchieved: false),
        OxfordgamesAchievement(image: "achi3IconOxfordgames", title: "achiTitle3", subtitle: "achiSubtitle3", isAchieved: false),
        OxfordgamesAchievement(image: "achi4IconOxfordgames", title: "achiTitle4", subtitle: "achiSubtitle4", isAchieved: false),
        OxfordgamesAchievement(image: "achi5IconOxfordgames", title: "achiTitle5", subtitle: "achiSubtitle5", isAchieved: false),

    ] {
        didSet {
            saveAchievementsItem()
        }
    }
    
    init() {
        loadAchievementsItem()
        
    }
    
    private let userDefaultsAchievementsKey = "achievementsKeySG"
    
    func achieveToggle(_ achive: OxfordgamesAchievement) {
        guard let index = achievements.firstIndex(where: { $0.id == achive.id })
        else {
            return
        }
        achievements[index].isAchieved.toggle()
        
    }

    
    func saveAchievementsItem() {
        if let encodedData = try? JSONEncoder().encode(achievements) {
            UserDefaults.standard.set(encodedData, forKey: userDefaultsAchievementsKey)
        }
        
    }
    
    func loadAchievementsItem() {
        if let savedData = UserDefaults.standard.data(forKey: userDefaultsAchievementsKey),
           let loadedItem = try? JSONDecoder().decode([OxfordgamesAchievement].self, from: savedData) {
            achievements = loadedItem
        } else {
            print("No saved data found")
        }
    }
}

struct OxfordgamesAchievement: Codable, Hashable, Identifiable {
    var id = UUID()
    var image: String
    var title: String
    var subtitle: String
    var isAchieved: Bool
}
