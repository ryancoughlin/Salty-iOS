//
//  PhraseViewModel.swift
//  Salty
//
//  Created by Ryan Coughlin on 12/30/21.
//

import Foundation
import SwiftUI

class PhraseViewModel: ObservableObject {
    private let tides: [Station.Tide]

    init(tides: [Station.Tide]) {
        self.tides = tides
    }
}
