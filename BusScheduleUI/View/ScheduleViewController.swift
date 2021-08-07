//
//  ViewController.swift
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
    
//    private var routeTimingCollectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 50)
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collectionView.backgroundColor = .gray
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        return collectionView
//    }()
    
    private let urlString = "https://jsonkeeper.com/b/XVSX"
    
    private var routeInfoViewModel = RouteInfoViewModel()
    private var routeTimingList = [String: [RouteTiming]]()
    private var routeTimingArray = [RouteTiming]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        styleCollectionView()
        
        routeInfoViewModel.fetchRouteInfo {
            DispatchQueue.main.async {
                self.routeInfoCollectionView.reloadData()
            }
        }
        
        NetworkManager<APIResponse>().fetchData(from: urlString) { (result) in
           self.routeTimingList = result.routeTimings
        }
        
    }

}

extension ViewController {
    
    private func setupCollectionView() {
        routeInfoCollectionView.register(RouteInfoCell.self, forCellWithReuseIdentifier: RouteInfoCell.reuseIdentifier)
        
        routeInfoCollectionView.delegate = self
        routeInfoCollectionView.dataSource = self
        
//        routeTimingCollectionView.register(RouteTimingCell.self, forCellWithReuseIdentifier: RouteTimingCell.reuseIdentifier)
//        routeTimingCollectionView.delegate = self
//        routeTimingCollectionView.dataSource = self
        
        routeTimingTableView.register(RouteTimingTableViewCell.self, forCellReuseIdentifier: String(describing: RouteTimingTableViewCell.self))
        routeTimingTableView.delegate = self
        routeTimingTableView.dataSource = self
    }
    
    private func styleCollectionView() {
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
        
//        self.view.addSubview(routeTimingCollectionView)
//        NSLayoutConstraint.activate([
//                                        routeTimingCollectionView.topAnchor.constraint(equalTo: routeInfoCollectionView.bottomAnchor, constant: 8),
//                                        routeTimingCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
//                                        routeTimingCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
//                                        routeTimingCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
//        ])
    }
    
}

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! RouteInfoCell
        cell.isSelected = true
        
        routeTimingArray.removeAll()
        for item in routeTimingList {
            if item.key == cell.routeId {
                for i in item.value {
                    routeTimingArray.append(i)
                }
            }
        }
        
        self.routeTimingTableView.reloadData()
    }
    
//    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//        let cell = collectionView.cellForItem(at: indexPath) as! RouteInfoCell
//        cell.isSelected = false
//        print("is deselected")
//        routeTimingArray.removeAll()
//        self.routeTimingTableView.reloadData()
//    }
    
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.routeTimingCollectionView {
            return routeTimingArray.count
        }
        return routeInfoViewModel.numberOfItemsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.routeInfoCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RouteInfoCell.reuseIdentifier, for: indexPath) as! RouteInfoCell
            
            cell.configure(cellViewModel: routeInfoViewModel.getCellModel(at: indexPath))
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: RouteTimingCell.self), for: indexPath) as! RouteTimingCell
            
            let startTime = routeTimingArray[indexPath.row].tripStartTime
            let availableSeats = routeTimingArray[indexPath.row].avaiable
            let totalSeats = routeTimingArray[indexPath.row].totalSeats
            
            cell.configure(startTime: startTime, availableSeats: availableSeats, totalSeats: totalSeats)
            
            return cell
        }
    }
    
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return routeTimingArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RouteTimingTableViewCell.self), for: indexPath) as! RouteTimingTableViewCell

        let startTime = routeTimingArray[indexPath.row].tripStartTime
        let availableSeats = routeTimingArray[indexPath.row].avaiable
        let totalSeats = routeTimingArray[indexPath.row].totalSeats

        cell.configure(startTime: startTime, availableSeats: availableSeats, totalSeats: totalSeats)

        return cell
    }


}
