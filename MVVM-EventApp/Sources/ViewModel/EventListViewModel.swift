//
//  EventViewModel.swift
//  MVVM-EventApp
//
//  Created by Gabriel on 19/08/21.
//

import Foundation

class EventListViewModel {
    var eventListViewController: EventListViewController?
    var eventListEvent = [EventModel]()
    let eventListService: APIService

    
    init() {
        eventListService = APIService()
    }
    
     func fecthData() {
        eventListService.fetchAllData {
            data in
            self.eventListEvent = data ?? []
            DispatchQueue.main.async {
                self.eventListViewController?.eventTableView.reloadData()
            }
        }
    }
    }

