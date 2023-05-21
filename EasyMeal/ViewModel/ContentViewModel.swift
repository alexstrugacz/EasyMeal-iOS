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
    @Published var displayedPage = 0
    
    init(triggerNextPage: @escaping () -> Void ) {
        self.triggerNextPage = triggerNextPage
    }
    
    func nextPage() {

        let nextPage = (currentPage + 1) % (PAGES.count)
        print("next page", nextPage, currentPage)
        displayedPage = nextPage;
        currentPage = nextPage
        if nextPage == 0 {
            triggerNextPage()
        }
    }
    
    func prevPage() {
        let nextPage = (currentPage - 1) % (PAGES.count)
        print("next page", nextPage, currentPage)
        if nextPage>=0 {
            displayedPage = nextPage
            currentPage = nextPage
        }
    }
}
