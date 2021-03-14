//
//  MainViewController.swift
//  SwiftCombineExample
//
//  Created by Patrick Pahl on 3/14/21.
//

import UIKit

class MainViewController: UIViewController, MainViewControllerProtocol {
    
    var viewModel: MainViewModelProtocol?

    lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "Swift Combine"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        return label
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.delegate = self
        searchBar.placeholder = "Search..."
        searchBar.searchBarStyle = .minimal
        return searchBar
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MainViewTableViewCell.self, forCellReuseIdentifier: MainViewTableViewCell.identifier)
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isHidden = true
        setUpView()
        viewModel?.viewDidLoad()
    }
    
    private func setUpView() {
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(searchBar)
        view.addSubview(tableView)
        
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        
        searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        searchBar.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

}

extension MainViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("textDidChange = \(searchText)")
        viewModel?.searchTextDidChange(text: searchText)
    }
    
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.numberOfSections() ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRows(section: section) ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainViewTableViewCell.identifier) as? MainViewTableViewCell,
              let cellModel = viewModel?.cellModel(indexPath: indexPath) else { return UITableViewCell() }
        
        cell.configure(with: cellModel)
        return cell
    }

}
