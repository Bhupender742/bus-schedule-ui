//
//  ViewController.swift
//  BusScheduleUI
//
//  Created by Bhupender Rawat on 06/08/21.
//

import UIKit

class ViewController: UIViewController {
    
    private var myCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 240, height: 100)
        layout.minimumInteritemSpacing = 16
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private var routeInfoList = [RouteInfo]()
    
    let urlString = "https://jsonkeeper.com/b/XVSX"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        styleCollectionView()
        
        NetworkManager<APIResponse>().fetchData(from: urlString) { (result) in
            self.routeInfoList = result.routeInfo
            self.myCollectionView.reloadData()
        }
        
    }


}

extension ViewController {
    
    private func setupCollectionView() {
        myCollectionView.register(RouteInfoCell.self, forCellWithReuseIdentifier: RouteInfoCell.reuseIdentifier)
        
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
    }
    
    private func styleCollectionView() {
        self.view.addSubview(myCollectionView)
        NSLayoutConstraint.activate([
                                        myCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 48),
                                        myCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                                        myCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                                        myCollectionView.heightAnchor.constraint(equalToConstant: 160)
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
        return routeInfoList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RouteInfoCell.reuseIdentifier, for: indexPath) as! RouteInfoCell

        let routeName = routeInfoList[indexPath.row].name
        let routeSource = routeInfoList[indexPath.row].source
        let routeDestination = routeInfoList[indexPath.row].destination
        let routeTripDuration = routeInfoList[indexPath.row].tripDuration

        cell.configure(name: routeName, source: routeSource, destination: routeDestination, tripDuration: routeTripDuration)
        
        return cell
    }
    
    
}
