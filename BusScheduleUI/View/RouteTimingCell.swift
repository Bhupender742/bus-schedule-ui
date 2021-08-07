//
//  RouteTimingCell.swift
//  BusScheduleUI
//
//  Created by Bhupender Rawat on 07/08/21.
//

import UIKit

class RouteTimingCell: UICollectionViewCell {
    
    private lazy var startTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var availableSeatLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension RouteTimingCell {
    
    private func setupViews() {
        
        styleContentView()
        
        addSubview(startTimeLabel)
        NSLayoutConstraint.activate([
            startTimeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            startTimeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            startTimeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 8)
        ])
        
        addSubview(availableSeatLabel)
        NSLayoutConstraint.activate([
            availableSeatLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            availableSeatLabel.leadingAnchor.constraint(equalTo: startTimeLabel.trailingAnchor, constant: 24),
            availableSeatLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            availableSeatLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    private func styleContentView() {
        contentView.backgroundColor = .cyan
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = contentView.frame.height / 2
    }
    
    public func configure(startTime: String, availableSeats: Int, totalSeats: Int) {
        startTimeLabel.text = "Start time: \(startTime)"
        availableSeatLabel.text = "Available Seat: \(availableSeats)/\(totalSeats)"
    }
    
}

extension RouteTimingCell: Reusable {}
