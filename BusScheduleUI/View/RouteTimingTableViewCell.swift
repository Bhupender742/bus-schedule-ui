//
//  RouteTimingTableViewCell.swift
//  BusScheduleUI
//
//  Created by Bhupender Rawat on 07/08/21.
//

import UIKit

class RouteTimingTableViewCell: UITableViewCell {
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension RouteTimingTableViewCell {
    
    private func setupViews() {
        
        contentView.addSubview(containerView)
        NSLayoutConstraint.activate([
                                        containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
                                        containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
                                        containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
                                        containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
        
        styleContainerView()
        
        addSubview(startTimeLabel)
        NSLayoutConstraint.activate([
            startTimeLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            startTimeLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
        
        addSubview(availableSeatLabel)
        NSLayoutConstraint.activate([
            availableSeatLabel.leadingAnchor.constraint(equalTo: startTimeLabel.trailingAnchor, constant: 24),
            availableSeatLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
    }
    
    public func configure(startTime: String, availableSeats: Int, totalSeats: Int) {
        startTimeLabel.text = "Start time: \(startTime)"
        availableSeatLabel.text = "Available Seat: \(availableSeats)/\(totalSeats)"
    }
    
    private func styleContainerView() {
        containerView.backgroundColor = .cyan
        containerView.clipsToBounds = true
        containerView.layer.cornerRadius = contentView.frame.height / 2
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
