//
//  MainViewProtocols.swift
//  SwiftCombineExample
//
//  Created by Patrick Pahl on 3/14/21.
//

import Foundation

protocol MainViewControllerProtocol: class {
    var viewModel: MainViewModelProtocol? { get set }
    
    func reloadData()
}

protocol MainViewModelProtocol: class {
    var view: MainViewControllerProtocol? { get set }
    var coordinator: MainViewCoordinatorProtocol? { get set }
    
    func numberOfSections() -> Int
    func numberOfRows(section: Int) -> Int
    func cellModel(indexPath: IndexPath) -> MainViewTableViewCellModel?
    func viewDidLoad()
}

protocol MainViewCoordinatorProtocol: class {
    
}
