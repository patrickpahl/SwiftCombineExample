//
//  MainViewModel.swift
//  SwiftCombineExample
//
//  Created by Patrick Pahl on 3/14/21.
//

import Foundation

import Foundation

class MainViewModel: MainViewModelProtocol {

    let service = MovieService()
    var movies: [MovieSearch] = []
    var cellModels: [MainViewTableViewCellModel] = []

    enum Section: Int {
        case nice = 0
        case vice
    }
    
    var view: MainViewControllerProtocol?
    var coordinator: MainViewCoordinatorProtocol?
    
    var niceCellModels: [MainViewTableViewCellModel] = []
    var viceCellModels: [MainViewTableViewCellModel] = []
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows(section: Int) -> Int {
        return cellModels.count
    }
    
    func cellModel(indexPath: IndexPath) -> MainViewTableViewCellModel? {
        return cellModels[indexPath.row]
    }
    
    func viewDidLoad() {
        //loadMovies()
    }
    
    private func createExampleData() {
        let nice1 = MainViewTableViewCellModel(titleText: "Eat Vegetables", descriptionText: "3")
        let nice2 = MainViewTableViewCellModel(titleText: "Meditate", descriptionText: "1")
        let nice3 = MainViewTableViewCellModel(titleText: "Workout", descriptionText: "0")
        niceCellModels = [nice1, nice2, nice3]
        
        let vice1 = MainViewTableViewCellModel(titleText: "Beer", descriptionText: "0")
        let vice2 = MainViewTableViewCellModel(titleText: "Chocolate", descriptionText: "0")
        let vice3 = MainViewTableViewCellModel(titleText: "Workout", descriptionText: "0")
        viceCellModels = [vice1, vice2, vice3]
        view?.reloadData()
    }
    
//    private func loadMovies() {
//        let group = DispatchGroup()
//        let queue = DispatchQueue(label: "movieQueue")
//        var serviceError: ServiceError?
//
//        group.enter()
//        service.fetchTop250Movies { result in
//            switch result {
//            case .success(let movies):
//                self.movies = movies
//            case .failure(let error):
//                print("could not load movies!")
//                serviceError = error
//            }
//            group.leave()
//        }
//
//        group.notify(queue: queue) {
//            DispatchQueue.main.async {
//                self.createData()
//            }
//        }
//    }
    
    func createData() {
        cellModels = movies.map({ MainViewTableViewCellModel(titleText: $0.title, descriptionText: $0.resultType) })
        view?.reloadData()
    }
    
    /// pyp
    func searchTextDidChange(text: String) {
        guard text.count > 2 else { return }
        
        service.searchMovies(searchText: text) { result in
            switch result {
            case .success(let movies):
                self.movies = movies
                self.createData()
            case .failure(let error):
                print("ERROR: \(error.localizedDescription)")
            }
        }
    }

}
