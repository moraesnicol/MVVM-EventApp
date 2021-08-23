//
//  EventListDetailTableViewCell.swift
//  MVVM-EventApp
//
//  Created by Gabriel on 23/08/21.
//

import UIKit
import Kingfisher

class EventListDetailTableViewCell: UITableViewCell {

     
        var events =  [EventModel]()
        private let randomImage: String = "https://hatrabbits.com/wp-content/uploads/2017/01/random.jpg"
    
        lazy var titleLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.boldSystemFont(ofSize: 14)
            label.textColor = UIColor.white
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .left
            label.numberOfLines = 1
            label.adjustsFontSizeToFitWidth = true
            return label
        }()
        
        lazy var dateLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.boldSystemFont(ofSize: 12)
            label.textColor = UIColor.white
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .right
            return label
        }()
        
        lazy var priceLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.boldSystemFont(ofSize: 12)
            label.textColor = UIColor.white
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .right
            return label
        }()
        
        lazy var imageViewEvent: UIImageView = {
            let image = UIImageView()
            image.clipsToBounds = true
            image.translatesAutoresizingMaskIntoConstraints = false
            image.contentMode = .scaleAspectFit
            return image
        }()
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            selectionStyle = .none
            addSubViews()
            constrainTitleLabel()
            constrainDateLabel()
            constrainPriceLabel()
            constrainImageView()
            // add shadow on cell
            backgroundColor = .clear
            layer.masksToBounds = true
            layer.cornerRadius = 8
            layer.shadowOpacity = 0.23
            layer.shadowRadius = 1
            layer.shadowOffset = CGSize(width: 0, height: 1)
            layer.shadowColor = UIColor.clear.cgColor
            // add corner radius on `contentView`
            contentView.backgroundColor = .secondarySystemGroupedBackground
            contentView.layer.cornerRadius = 12
            layer.shadowPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 8, height: 8)).cgPath
            layer.shouldRasterize = true
            layer.rasterizationScale = UIScreen.main.scale
        }
        
        override func prepareForReuse() {
            super.prepareForReuse()
            imageViewEvent.image = UIImage(named: "2")
            imageViewEvent.kf.cancelDownloadTask()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func addSubViews() {
            contentView.addSubview(titleLabel)
            contentView.addSubview(dateLabel)
            contentView.addSubview(priceLabel)
            contentView.addSubview(imageViewEvent)
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
            setGradientBackground()
        }
        
        
        func setGradientBackground() {
            let colorTop =  UIColor(red: 0.49, green: 0.30, blue: 1.00, alpha: 1.00).cgColor
            let colorBottom = UIColor(red: 0.86, green: 0.25, blue: 0.80, alpha: 1.00).cgColor
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [colorTop, colorBottom]
            gradientLayer.locations = [0.0, 1.0]
            gradientLayer.frame = self.contentView.bounds
            self.contentView.layer.insertSublayer(gradientLayer, at:0)
        }
        
        func configure(with eventObject: EventModel) {
            
            if let dateOptional = eventObject.date {
                let dateEvent = String(dateOptional)
                dateLabel.text = "\(dateEvent)  ⏰"
            }
            
            guard let url = URL(string: eventObject.image ?? "" ) else { return  }
            let resource = ImageResource(downloadURL: url, cacheKey: eventObject.image)
            let placeholder = UIImage(named: "2")
            self.imageViewEvent.kf.setImage(with: resource, placeholder: placeholder)

            if let titleOptional = eventObject.title {
                let titleEvent = titleOptional
                titleLabel.text = titleEvent
            }
            
            if let priceOptional = eventObject.price {
                let  priceEvent = priceOptional
                priceLabel.text = "💲\(priceEvent) "
            }
            
        }
        
        private  func constrainDateLabel(){
            let constraint = [
                dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
                dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 80),
                dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            ]
            
            constraint.forEach { (item) in
                item.isActive = true
            }
        }
        
        private  func constrainImageView(){
            let constraint = [
                
                imageViewEvent.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
                imageViewEvent.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
                imageViewEvent.heightAnchor.constraint(equalToConstant: 120),
                imageViewEvent.widthAnchor.constraint(equalTo: imageViewEvent.heightAnchor, multiplier: 6/4)
            ]
            
            constraint.forEach { (item) in
                item.isActive = true
            }
        }
        
        private  func constrainTitleLabel(){
            let constraint = [
                titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
                titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
                titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -70),
            ]
            
            constraint.forEach { (item) in
                item.isActive = true
            }
        }
        
        private  func constrainPriceLabel(){
            let constraint = [
                priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
                priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
                priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            ]
            
            constraint.forEach { (item) in
                item.isActive = true
            }
        }
}
