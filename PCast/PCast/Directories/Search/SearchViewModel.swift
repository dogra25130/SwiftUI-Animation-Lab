//
//  SearchViewModel.swift
//  PCast
//
//  Created by Abhishek Dogra on 24/08/24.
//

import Combine
import Dispatch

@MainActor
class SearchViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var searchInProgress = false
    @Published var searchResults: [PodCastModel] = []
    private var searchDebouncer = Debounce()
    
    var cancellables = Set<AnyCancellable>()
    let usecase: SearchUseCase
    init(usecase: SearchUseCase = SearchService()) {
        self.usecase = usecase
        addObservers()
    }
    
    private func addObservers() {
        $searchText
            .sink { [weak self] value in
                self?.searchInProgress = true
                self?.search(for: value)
            }
            .store(in: &cancellables)
    }
    
    func search(for value: String) {
        if value.isEmpty {
            searchResults = []
        }
        let usecase = usecase
        searchDebouncer.dispatch {
            Task {
                let results = await usecase.search(for: value)
                self.searchInProgress = false
                switch results {
                case .success(let model):
                    self.searchResults = model
                case .failure(let failure):
                    print(failure)
                }
            }
        }
    }
}

