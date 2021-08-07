//
//  RouteInfoViewModel.swift
//  BusScheduleUI
//
//  Created by Bhupender Rawat on 07/08/21.
//

import UIKit

class RouteInfoViewModel: NSObject {
    
    private let urlString = "https://jsonkeeper.com/b/XVSX"
    
    private var routeInfoList = [RouteInfo]()
    private var routeInfoCellViewModels = [RouteInfoCellViewModel]()
    
    public func fetchRouteInfo(completion: @escaping () -> Void) {
        NetworkManager<APIResponse>().fetchData(from: urlString) { (result) in
            self.routeInfoList = result.routeInfo
            completion()
        }
    }
    
}

extension RouteInfoViewModel {
    
    public func getCellModel(at indexPath: IndexPath) -> RouteInfoCellViewModel {
        return routeInfoCellViewModels[indexPath.row]
    }
    
    public func numberOfItemsInSection() -> Int {
        routeInfoCellViewModels = routeInfoList.map { RouteInfoCellViewModel(with: $0) }
        return routeInfoList.count
    }
    
}