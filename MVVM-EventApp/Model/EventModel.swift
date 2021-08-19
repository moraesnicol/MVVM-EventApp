//
//  EventModel.swift
//  MVVM-EventApp
//
//  Created by Gabriel on 18/08/21.



import Foundation

// MARK: - EventElement
struct EventElement {
    let people: [Person]?
    let date: Int?
    let welcomeDescription: String?
    let image: String?
    let longitude, latitude, price: Double?
    let title, id: String?
    let cupons: [Any?]?
}

// MARK: - Person
struct Person {
    let id, eventID, name, picture: String?
}

//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)
