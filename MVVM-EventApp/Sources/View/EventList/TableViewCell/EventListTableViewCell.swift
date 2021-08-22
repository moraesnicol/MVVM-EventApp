//
//  EventListTableViewCell.swift
//  MVVM-EventApp
//
//  Created by Gabriel on 21/08/21.
//

import UIKit

class EventListTableViewCell: UITableViewCell {
  
    var events =  [EventModel]()
  //  var eventsPerson =  [Person]()
    
    lazy var titleLabel: UILabel = {
       let label = UILabel()
       label.font = UIFont.boldSystemFont(ofSize: 12)
       label.textColor = UIColor.systemPurple
       label.translatesAutoresizingMaskIntoConstraints = false
       label.textAlignment = .center
       return label
   }()

   override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
       super.init(style: style, reuseIdentifier: reuseIdentifier)
       selectionStyle = .none
       addSubViews()
       constrainQuestionLabel()
   }
   
   required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
   
   private func addSubViews() {
       contentView.addSubview(titleLabel)
   }
   
    //
    func configure(with questionObject: EventModel) {
        titleLabel.text = questionObject.image
   }
   
   private  func constrainQuestionLabel(){
       let constraint = [
          titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
           titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
           titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
           titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
       ]
       
       constraint.forEach { (item) in
           item.isActive = true
       }
   }
   
}
