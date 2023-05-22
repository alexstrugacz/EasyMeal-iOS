//
//  ContentViewModel.swift
//  EasyMeal
//
//  Created by Miguel Aenlle on 5/21/23.
//

import SwiftUI

class ContentViewModel: ObservableObject {
    var triggerNextPage: () -> Void;
    @Published var currentPage = 0
    @Published var moved = false
    
    init(triggerNextPage: @escaping () -> Void ) {
        self.triggerNextPage = triggerNextPage
    }
    
    func nextPage() {
        moved = true
        let nextPage = (currentPage + 1) % (PAGES.count)
        print("next page", nextPage, currentPage)
        currentPage = nextPage
        if nextPage == 0 {
            triggerNextPage()
        }
    }
    
    func prevPage() {
        moved = true
        let nextPage = (currentPage - 1) % (PAGES.count)
        print("next page", nextPage, currentPage)
        if nextPage>=0 {
            currentPage = nextPage
        }
    }
}
