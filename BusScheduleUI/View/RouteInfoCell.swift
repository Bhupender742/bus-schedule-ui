//
//  RouteInfoCell.swift
//  BusScheduleUI
//
//  Created by Bhupender Rawat on 06/08/21.
//

import UIKit

class RouteInfoCell: UICollectionViewCell {
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var sourceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var tripDurationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var destinationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var sourceDestinationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension RouteInfoCell {
    
    private func setupViews() {
        
        addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
        
        addSubview(sourceDestinationLabel)
        NSLayoutConstraint.activate([
            sourceDestinationLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            sourceDestinationLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
        
        addSubview(tripDurationLabel)
        NSLayoutConstraint.activate([
            tripDurationLabel.topAnchor.constraint(equalTo: sourceDestinationLabel.bottomAnchor, constant: 8),
            tripDurationLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    public func configure(name: String, source: String, destination: String, tripDuration: String) {
        nameLabel.text = name
        sourceDestinationLabel.text = "\(source)-\(destination)"
        tripDurationLabel.text = tripDuration
    }
    
}

extension RouteInfoCell: Reusable {}
