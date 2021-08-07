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
    
    private var routeInfoViewModel = RouteInfoViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        styleCollectionView()
        
        routeInfoViewModel.fetchRouteInfo {
            DispatchQueue.main.async {
                self.routeInfoCollectionView.reloadData()
            }
        }
        
    }

}

extension ViewController {
    
    private func setupCollectionView() {
        routeInfoCollectionView.register(RouteInfoCell.self, forCellWithReuseIdentifier: RouteInfoCell.reuseIdentifier)
        
        routeInfoCollectionView.delegate = self
        routeInfoCollectionView.dataSource = self
    }
    
    private func styleCollectionView() {
        self.view.addSubview(routeInfoCollectionView)
        NSLayoutConstraint.activate([
                                        routeInfoCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 48),
                                        routeInfoCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                                        routeInfoCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                                        routeInfoCollectionView.heightAnchor.constraint(equalToConstant: 160)
        ])
    }
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width: CGFloat = 320
//        let height: CGFloat = 320
//        return CGSize(width: width, height: height)
//    }
    
}

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
