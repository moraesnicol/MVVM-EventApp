//
//  ViewController.swift
//  MVVM-EventApp
//
//  Created by Gabriel on 18/08/21.
//

import UIKit



final class EventListViewController: UIViewController {
    
   
    let cellEventListReuseIdentifier = "cellEventListReuseIdentifier"
    let apiService = APIService()
    var events =  [EventModel]()
    var safeArea: UILayoutGuide!
    
    lazy var topTitle: UILabel = {
        let label = UILabel()
        label.text = "Event's place  📅"
        label.font = UIFont.italicSystemFont(ofSize: 32)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = UIColor.systemPurple
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
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
    
   func setupViews() {
    safeArea = view.layoutMarginsGuide
    view.backgroundColor = .systemGray6
    view.addSubview(eventTableView)
    view.addSubview(topTitle)
    eventTableView.register(EventListTableViewCell.self, forCellReuseIdentifier: cellEventListReuseIdentifier)
    eventTableView.delegate = self
    eventTableView.dataSource = self
    }

    private  func constrainTopTitle(){
        let constraint = [
            topTitle.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20),
           topTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
           topTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:  -10),
        ]
        constraint.forEach { (item) in
            item.isActive = true
        }
    }
    
    
    private  func constrainTableView(){
        let constraint = [
            eventTableView.topAnchor.constraint(equalTo: topTitle.bottomAnchor, constant: 30),
            eventTableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),
            eventTableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant:  -10),
            eventTableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -30),
        ]
        constraint.forEach { (item) in
            item.isActive = true
        }
    }
    
    
}


extension EventListViewController: UITableViewDelegate {
    
}

extension EventListViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: cellEventListReuseIdentifier, for: indexPath) as! EventListTableViewCell
        let eventObject = events[indexPath.row]
        cell.configure(with: eventObject)
        return cell
    }
}
