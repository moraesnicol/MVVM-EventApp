//
//  EventListDetailViewController.swift
//  MVVM-EventApp
//
//  Created by Gabriel on 23/08/21.
//

import UIKit
import Kingfisher


final class EventListDetailViewController: UIViewController {
    private let randomImage: String = "https://hatrabbits.com/wp-content/uploads/2017/01/random.jpg"
    
    var titleLbl = ""
    var descriptionEvent = ""
    
    var image = UIImage()
    
    
    var events =  [EventModel]()
    var safeArea: UILayoutGuide!
    
    var eventListViewController = EventListViewController()
    var eventListTableViewCell: EventListTableViewCell?
    
    lazy var imageViewEventDetail: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.backgroundColor = .systemPink
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.image = UIImage()
        return image
    }()
    
    lazy var titleEventLabelDetail: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 25, weight: UIFont.Weight.heavy)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .systemGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    lazy var textViewEventDetail: UITextField = {
        let textView = UITextField()
        textView.center = self.view.center
        textView.textAlignment = .center
        textView.textColor = UIColor.black
        textView.backgroundColor = UIColor.systemPink
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.cornerRadius = 12
        
        return textView
    }()
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        constrainTitleEvent()
        constrainImageEvent()
        constrainTextViewEventDetail()
        textViewEventDetail.text = "\(descriptionEvent)"
        imageViewEventDetail.image = image
        titleEventLabelDetail.text = "\(titleLbl)"
        textViewEventDetail.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func setupViews() {
        safeArea = view.layoutMarginsGuide
        view.backgroundColor = .systemBackground
        view.addSubview(imageViewEventDetail)
        view.addSubview(titleEventLabelDetail)
        view.addSubview(textViewEventDetail)
     
    }
    
    private  func constrainImageEvent(){
        let constraint = [
            imageViewEventDetail.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 0),
            imageViewEventDetail.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            imageViewEventDetail.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            imageViewEventDetail.heightAnchor.constraint(equalToConstant: 280),
        ]
        constraint.forEach { (item) in
            item.isActive = true
        }
    }
    
    
    private  func constrainTitleEvent(){
        let constraint = [
            titleEventLabelDetail.topAnchor.constraint(equalTo: imageViewEventDetail.bottomAnchor, constant: 35),
            titleEventLabelDetail.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            titleEventLabelDetail.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:  -10),
        ]
        constraint.forEach { (item) in
            item.isActive = true
        }
    }
    
    private  func constrainTextViewEventDetail(){
        let constraint = [
            textViewEventDetail.topAnchor.constraint(equalTo: titleEventLabelDetail.bottomAnchor, constant: 30),
            textViewEventDetail.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            textViewEventDetail.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:  -25),
            textViewEventDetail.heightAnchor.constraint(equalToConstant: 280),
        ]
        constraint.forEach { (item) in
            item.isActive = true
        }
    }
    
}


extension EventListDetailViewController: UITextFieldDelegate {
    
}
