//
//  ViewController.swift
//  MVVM-EventApp
//
//  Created by Gabriel on 18/08/21.
//

import UIKit
import Kingfisher


final class EventListViewController: UIViewController, UITextFieldDelegate {
    
    var eventListTableViewCell: EventListTableViewCell?
    let cellEventListReuseIdentifier = "cellEventListReuseIdentifier"
    private let randomImage: String = "https://hatrabbits.com/wp-content/uploads/2017/01/random.jpg"
    let apiService = APIService()
    var events =  [EventModel]()
    var safeArea: UILayoutGuide!
    
    lazy var topTitle: UILabel = {
        let label = UILabel()
        label.text = "Events  📅"
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 40, weight: UIFont.Weight.heavy)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    lazy var eventTableView: UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        
        return tableview
    }()
    
    
    fileprivate func fecthData() {
        apiService.fetchAllData {
            data in
            self.events = data ?? []
            DispatchQueue.main.async {
                self.eventTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        fecthData()
        constrainTopTitle()
        constrainTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    
    func setupViews() {
        safeArea = view.layoutMarginsGuide
        view.backgroundColor = UIColor(red: 0.09, green: 0.05, blue: 0.35, alpha: 1.00)
        eventTableView.backgroundColor = .clear
        view.addSubview(eventTableView)
        view.addSubview(topTitle)
        eventTableView.register(EventListTableViewCell.self, forCellReuseIdentifier: cellEventListReuseIdentifier)
        eventTableView.delegate = self
        eventTableView.dataSource = self
    }
    
    private  func constrainTopTitle(){
        let constraint = [
            topTitle.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20),
            topTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            topTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:  -10),
        ]
        constraint.forEach { (item) in
            item.isActive = true
        }
    }
    
    
    private  func constrainTableView(){
        let constraint = [
            eventTableView.topAnchor.constraint(equalTo: topTitle.bottomAnchor, constant: 30),
            eventTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            eventTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:  -20),
            eventTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
        ]
        constraint.forEach { (item) in
            item.isActive = true
        }
    }
    
    
}


extension EventListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var anyImage = UIImage(named: "2")
        let rootVc = EventListDetailViewController()
        rootVc.titleLbl = events[indexPath.row].title ?? ""
        rootVc.descriptionEvent = events[indexPath.row].eventModelDescription ?? "any description"
       // guard let image = events[indexPath.row].image  else { return }
        rootVc.image = events[indexPath.row].image as? UIImage ?? anyImage as! UIImage
        
        let navVC = UINavigationController(rootViewController: rootVc)
        navVC.modalTransitionStyle =  .flipHorizontal
        present(navVC, animated: true)
    }
}

extension EventListViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: cellEventListReuseIdentifier, for: indexPath) as! EventListTableViewCell
        let eventObject = events[indexPath.row]
        cell.configure(with: eventObject)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.backgroundColor = .white
        let radius = cell.contentView.layer.cornerRadius
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: radius).cgPath
        cell.contentView.layer.masksToBounds = true
    }
}
