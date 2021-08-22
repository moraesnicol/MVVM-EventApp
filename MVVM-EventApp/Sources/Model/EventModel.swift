//
//  EventModel.swift
//  MVVM-EventApp
//
//  Created by Gabriel on 18/08/21.

import Foundation

// MARK: - EventModel
struct EventModel: Decodable {
    let people: [Person]?
    let date: Int?
    let eventModelDescription: String?
    let image: String?
    let longitude, latitude, price: Double?
    let title, id: String?
    let cupons: [String]?
}
// MARK: - Person
struct Person: Decodable {
    let id, eventID, name, picture: String?
}
