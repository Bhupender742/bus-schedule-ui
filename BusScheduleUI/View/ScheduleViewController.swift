//
//  ScheduleViewController.swift
//  BusScheduleUI
//
//  Created by Bhupender Rawat on 06/08/21.
//

import UIKit

class ViewController: UIViewController {
    
    private var routeInfoCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 240, height: 100)
        layout.minimumInteritemSpacing = 16
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private var routeTimingTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var routeInfoViewModel = RouteInfoViewModel()
    private var routeTimingViewModel = RouteTimingViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        styleViews()
        
        routeInfoViewModel.fetchRouteInfo {
            DispatchQueue.main.async {
                self.routeInfoCollectionView.reloadData()
            }
        }
        
        routeTimingViewModel.fetchRouteTiming {
            DispatchQueue.main.async {
                self.routeTimingTableView.reloadData()
            }
        }
        
    }

}

extension ViewController {
    
    private func setupViews() {
        routeInfoCollectionView.register(RouteInfoCell.self, forCellWithReuseIdentifier: RouteInfoCell.reuseIdentifier)
        
        routeInfoCollectionView.delegate = self
        routeInfoCollectionView.dataSource = self
        
        routeTimingTableView.register(RouteTimingCell.self, forCellReuseIdentifier: String(describing: RouteTimingCell.self))
        routeTimingTableView.delegate = self
        routeTimingTableView.dataSource = self
    }
    
    private func styleViews() {
        self.view.addSubview(routeInfoCollectionView)
        NSLayoutConstraint.activate([
                                        routeInfoCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 48),
                                        routeInfoCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                                        routeInfoCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                                        routeInfoCollectionView.heightAnchor.constraint(equalToConstant: 160)
        ])
        
        self.view.addSubview(routeTimingTableView)
        NSLayoutConstraint.activate([
            routeTimingTableView.topAnchor.constraint(equalTo: routeInfoCollectionView.bottomAnchor, constant: 8),
            routeTimingTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            routeTimingTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            routeTimingTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        routeTimingTableView.separatorStyle = .none
        
    }
    
}

// MARK:- CollectionViewDelegates
extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! RouteInfoCell
        cell.isSelected = true
        
        routeTimingViewModel.removeAllPresentRouteTimings()
        routeTimingViewModel.addRouteTimings(routeID: cell.routeID)
        
        self.routeTimingTableView.reloadData()
    }
    
}

// MARK:- CollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return routeInfoViewModel.numberOfItemsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RouteInfoCell.reuseIdentifier, for: indexPath) as! RouteInfoCell
            
        cell.configure(cellViewModel: routeInfoViewModel.getCellModel(at: indexPath))
            
        return cell
    }
    
    
}

// MARK:- TableViewDelegates
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

// MARK:- TableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return routeTimingViewModel.numberOfRowsInSection()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RouteTimingCell.reuseIdentifier, for: indexPath) as! RouteTimingCell

        cell.configure(cellViewModel: routeTimingViewModel.getCellModel(at: indexPath))

        return cell
    }


}
