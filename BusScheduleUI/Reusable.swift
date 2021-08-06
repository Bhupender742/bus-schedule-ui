//
//  Reusable.swift
//  BusScheduleUI
//
//  Created by Bhupender Rawat on 06/08/21.
//

import Foundation

protocol Reusable {
    static var reuseIdentifier: String  { get }
}

extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
