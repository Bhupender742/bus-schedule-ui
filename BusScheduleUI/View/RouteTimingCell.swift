//
//  RouteTimingCell.swift
//  BusScheduleUI
//
//  Created by Bhupender Rawat on 07/08/21.
//

import UIKit

class RouteTimingCell: UITableViewCell {
    
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

extension RouteTimingCell {
    
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
            availableSeatLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            availableSeatLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
    }
    
    private func styleContainerView() {
        containerView.backgroundColor = .cyan
        containerView.clipsToBounds = true
        containerView.layer.cornerRadius = contentView.frame.height / 2
    }
    
    public func configure(cellViewModel: RouteTimingCellViewModel) {
        startTimeLabel.text = "Start time: \(cellViewModel.tripStartTime)"
        availableSeatLabel.text = "Available Seat: \(cellViewModel.availabelSeats)/\(cellViewModel.totalSeats)"
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

extension RouteTimingCell: Reusable {}
