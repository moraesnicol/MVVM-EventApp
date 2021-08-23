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
    
    
    var eventListTableViewCell: EventListTableViewCell?
    let cellEventListReuseIdentifier = "cellEventListReuseIdentifier"
    let apiService = APIService()
    var events =  [EventModel]()
    var safeArea: UILayoutGuide!
    
    
    lazy var imageViewEvent: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 12
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    lazy var titleEvent: UILabel = {
        let label = UILabel()
        label.text = "Título do evento"
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 30, weight: UIFont.Weight.heavy)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    lazy var eventDetailTableView: UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        return tableview
    }()
    
    
    fileprivate func fecthData() {
        apiService.fetchAllData {
            data in
            self.events = data ?? []
            DispatchQueue.main.async {
                self.eventDetailTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        setupViews()
        fecthData()
        constrainTitleEvent()
        constrainTableView()
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
        view.backgroundColor = .red
        eventDetailTableView.backgroundColor = .clear
        view.addSubview(imageViewEvent)
        view.addSubview(titleEvent)
        view.addSubview(eventDetailTableView)
        eventDetailTableView.register(EventListTableViewCell.self, forCellReuseIdentifier: cellEventListReuseIdentifier)
        eventDetailTableView.delegate = self
        eventDetailTableView.dataSource = self
    }
    
    private  func constrainTitleEvent(){
        let constraint = [
            titleEvent.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20),
            titleEvent.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            titleEvent.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:  -10),
        ]
        constraint.forEach { (item) in
            item.isActive = true
        }
    }
    
    
    private  func constrainTableView(){
        let constraint = [
            eventDetailTableView.topAnchor.constraint(equalTo: titleEvent.bottomAnchor, constant: 30),
            eventDetailTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            eventDetailTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:  -20),
            eventDetailTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
        ]
        constraint.forEach { (item) in
            item.isActive = true
        }
    }
}


extension EventListDetailViewController: UITableViewDelegate {
    
}

extension EventListDetailViewController: UITableViewDataSource{
    
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
