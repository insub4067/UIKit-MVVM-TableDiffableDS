//
//  ViewController.swift
//  UIKit-Test
//
//  Created by Kim Insub on 2022/11/28.
//

import Combine
import UIKit

class ViewController: UIViewController {

    enum Section { case main }

    var tableView: UITableView!
    var dataSource: UITableViewDiffableDataSource<Section, Person>!

    private let viewModel = ViewModel()
    private var cancelBag = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        setViewModel()
        configureTableView()
        configureDataSource()
        viewModel.viewDidLoad()
    }

    func configureTableView() {
        tableView = UITableView(frame: view.bounds)
        view.addSubview(tableView)
        tableView.register(PersonCell.self, forCellReuseIdentifier: PersonCell.reuseID)
    }

    func updateData(on people: [Person]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Person>()
        snapshot.appendSections([.main])
        snapshot.appendItems(people)
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }

    func configureDataSource() {
        dataSource = UITableViewDiffableDataSource<Section, Person>(tableView: tableView, cellProvider: { tableView, indexPath, person in
            let cell = tableView.dequeueReusableCell(withIdentifier: PersonCell.reuseID) as! PersonCell
            cell.set(person: person)
            return cell
        })
    }
}

private extension ViewController {
    func setViewModel() {
        viewModel.$people
            .receive(on: DispatchQueue.main)
            .sink { [weak self] people in
                guard let self = self else { return }
                self.updateData(on: people)
            }
            .store(in: &cancelBag)
    }
}
