//
//  RouteInfoCell.swift
//  BusScheduleUI
//
//  Created by Bhupender Rawat on 06/08/21.
//

import UIKit

class RouteInfoCell: UICollectionViewCell {
    
    public var routeId: String = ""
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var sourceDestinationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var tripDurationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override var isSelected: Bool {
        didSet{
            if isSelected == false {
                self.contentView.backgroundColor = .cyan
            } else {
                self.contentView.backgroundColor = .green
            }
        }
    }
    
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
        
        styleContentView()
        
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
    
    private func styleContentView() {
        contentView.backgroundColor = .cyan
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = contentView.frame.height / 2
    }
    
    public func configure(cellViewModel: RouteInfoCellViewModel) {
        routeId = cellViewModel.routeId
        nameLabel.text = cellViewModel.routeName
        sourceDestinationLabel.text = "\(cellViewModel.routeSource)-\(cellViewModel.routeDestination)"
        tripDurationLabel.text = cellViewModel.routeTripDuration
    }
    
}

extension RouteInfoCell: Reusable {}
