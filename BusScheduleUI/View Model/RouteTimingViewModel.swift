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
    
    public func fetchRouteTiming(completion: @escaping () -> Void) {
        NetworkManager<APIResponse>().fetchData(from: urlString) { (result) in
            self.routeTimingList = result.routeTimings
            completion()
        }
    }
    
}

extension RouteTimingViewModel {
    
    public func numberOfItemsInSection(routeID: String) -> Int {
        return routeTimingList.count
    }
}
