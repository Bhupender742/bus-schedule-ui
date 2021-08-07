//
//  RouteTimingViewModel.swift
//  BusScheduleUI
//
//  Created by Bhupender Rawat on 07/08/21.
//

import UIKit

class RouteTimingViewModel: NSObject {
    
    private let urlString = "https://jsonkeeper.com/b/XVSX"
    
    private var routeTimingList = [String: [RouteTiming]]()
    private var routeTimingCellViewModels = [RouteTimingCellViewModel]()
    private var routeTimingArray = [RouteTiming]()
    
    public func fetchRouteTiming(completion: @escaping () -> Void) {
        NetworkManager<APIResponse>().fetchData(from: urlString) { (result) in
            self.routeTimingList = result.routeTimings
            completion()
        }
    }
    
}

extension RouteTimingViewModel {
    
    public func getCellModel(at indexPath: IndexPath) -> RouteTimingCellViewModel {
        return routeTimingCellViewModels[indexPath.row]
    }
    
    public func numberOfRowsInSection() -> Int {
        routeTimingCellViewModels = routeTimingArray.map{ RouteTimingCellViewModel(with: $0)}
        return routeTimingArray.count
    }
    
    public func removeAllPresentRouteTimings() {
        routeTimingArray.removeAll()
    }
    
    public func addRouteTimings(routeID: String) {
        for item in routeTimingList {
            if item.key == routeID {
                for i in item.value {
                    routeTimingArray.append(i)
                }
            }
        }
    }
}
