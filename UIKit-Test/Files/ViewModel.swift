//
//  ViewModel.swift
//  UIKit-Test
//
//  Created by Kim Insub on 2022/11/28.
//

import Combine
import Foundation

final class ViewModel: ObservableObject {
    @Published var people: [Person] = []

    init() {
        fetchStarwarsPeople()
    }

    func viewDidLoad() {
        fetchStarwarsPeople()
    }

    @objc func handleRefreshControl() {
        fetchStarwarsPeople()
    }
}

private extension ViewModel {
    func fetchStarwarsPeople() {
        Task {
            do {
                people = try await APIClient().getPeople()
            } catch NetworkError.invalidURL {
                print("Invalid URL ERROR!")
            }
        }
    }
}

