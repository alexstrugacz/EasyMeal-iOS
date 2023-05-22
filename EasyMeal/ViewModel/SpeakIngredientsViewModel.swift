//
//  SpeakIngredientsViewModel.swift
//  EasyMeal
//
//  Created by Miguel Aenlle on 5/17/23.
//

import SwiftUI

class SpeakIngredientsViewModel : ObservableObject {
    var exit: () -> Void
    @Published var recording: Bool = false
    @Published var recorded: Bool = false
    @Published var resultsDisplayed: Bool = false
    @Published var results: [String] = []
    @Published var loading: Bool = false
    @Published var text: String = ""
    @Published var error: LocalizedError?
    @Published var errorDisplayed: Bool = false
    
    init(exit: @escaping () -> Void) {
        self.exit = exit
    }
    
    func startRecording() {
        recording = true
    }
    func stopRecording() {
        // add a delay
        let seconds = 2.0
        loading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            // Put your code which should be executed with a delay heres
            self.recording = false
            self.recorded = true
            self.loading = false
        }
    }
    func resetRecording() {
        recorded = false
    }
    func submitRecording() {
        // TODO: API call
        
        loading = true
        let apiUrl = "https://easymeal-backend.herokuapp.com/speech-parser?query=\(text.lowercased())"
        
        guard let apiUrlFormatted = apiUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: apiUrlFormatted) else {
            loading = false
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                self.loading = false
                return
            }
            
            do {
                guard let dataSecure = data else {
                    self.loading = false
                    return
                }
                if let json = try JSONSerialization.jsonObject(with: dataSecure, options: .allowFragments) as? [String: [String]] {
                    guard let ingredientsFound = json["ingredients"] else {
                        self.loading = false
                        return
                    }
                    self.results = ingredientsFound
                } else {
                    self.results = []
                }
            } catch {
                self.loading = false
            }
        }
        task.resume()
        resultsDisplayed = true
    }
    func exitSubmission() {
        resultsDisplayed = false
        results = []
        loading = false
    }
    func addResults() {
        var selectedItems = UserDefaults.standard.array(forKey: "pantryItems") as? [String] ?? []
        for result in results {
            if !selectedItems.contains(result) {
                selectedItems.append(result)
            }
        }
        UserDefaults.standard.set(selectedItems, forKey: "pantryItems")
        exit()
    }
    
    
}
