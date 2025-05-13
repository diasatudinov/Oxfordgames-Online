//
//  SettingsViewModelSG.swift
//  Oxfordgames Online
//
//  Created by Dias Atudinov on 13.05.2025.
//


import SwiftUI

class SettingsViewModelSG: ObservableObject {
    @AppStorage("soundEnabled") var soundEnabled: Bool = true
}
