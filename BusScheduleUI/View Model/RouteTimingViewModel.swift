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
    
    public func isEmpty() -> Bool {
        return routeTimingArray.count == 0
    }
    
    public func removeAllPresentRouteTimings() {
        if routeTimingArray.count > 0 {
            routeTimingArray.removeAll()
        }
        return
    }
    
    public func addRouteTimings(routeID: String) {
//        let routes = routeTimingList.filter{ $0.key == routeID }.map{ $0.value }
//        for routeTimingArray in routes.map({$0}) {
//            print(routeTimingArray)
//            self.routeTimingArray = routeTimingArray
//        }
        for routesDict in routeTimingList {
            if routesDict.key == routeID {
                for route in routesDict.value {
                    routeTimingArray.append(route)
                }
            }
        }
        
    }
}
