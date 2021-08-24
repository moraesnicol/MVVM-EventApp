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
    
    lazy var imageViewEvent: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.backgroundColor = .systemBlue
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    lazy var titleEventLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 25, weight: UIFont.Weight.heavy)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .systemGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            selectionStyle = .none
            addSubViews()
            constrainImageView()
            constrainTitleEventLabel()
            backgroundColor = .clear
           
       
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
            contentView.addSubview(imageViewEvent)
            contentView.addSubview(titleEventLabel)
        
        }
        
        
        func configure(with eventObject: EventModel) {
            
            guard let url = URL(string: eventObject.image ?? "" ) else { return  }
            let resource = ImageResource(downloadURL: url, cacheKey: eventObject.image)
            let placeholder = UIImage(named: "2")
            self.imageViewEvent.kf.setImage(with: resource, placeholder: placeholder)

            if let titleOptional = eventObject.title {
                let titleEvent = titleOptional
                titleEventLabel.text  = "\(titleEvent)"
            }
            
        }
        
        private  func constrainImageView(){
            let constraint = [
                imageViewEvent.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
                imageViewEvent.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
                imageViewEvent.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
                imageViewEvent.heightAnchor.constraint(equalToConstant: 280),
            ]
            
            constraint.forEach { (item) in
                item.isActive = true
            }
        }
        
        private  func constrainTitleEventLabel(){
            let constraint = [
                titleEventLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
                titleEventLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
                titleEventLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -70),
            ]
            
            constraint.forEach { (item) in
                item.isActive = true
            }
        }
        
}
