//
//  SimpleUser.swift
//  Sveta's task by Ivan
//
//  Created by mac on 07.05.2022.
//

import Foundation


struct SimpleUser {
    let name: String
    let avatarImage: String
    let id: UUID = UUID()
    let photos: [SimplePhoto]
}



let testUsers: [SimpleUser] = [
    
    SimpleUser(name: "Ivan", avatarImage: "user1", photos: [SimplePhoto(name: "cat1"),SimplePhoto(name: "cat2"),SimplePhoto(name: "cat3"),SimplePhoto(name: "cat4"),SimplePhoto(name: "cat5")]),
    SimpleUser(name: "James", avatarImage: "user2", photos: [SimplePhoto(name: "bird1"),SimplePhoto(name: "bird2"),SimplePhoto(name: "bird3"),SimplePhoto(name: "bird4"),SimplePhoto(name: "bird5"),SimplePhoto(name: "bird6"),SimplePhoto(name: "bird7")]),
    SimpleUser(name: "Robert", avatarImage: "user3", photos: [SimplePhoto(name: "car1"),SimplePhoto(name: "car2"),SimplePhoto(name: "car3"),SimplePhoto(name: "car4"),SimplePhoto(name: "car5")]),
    SimpleUser(name: "Ivan", avatarImage: "user4", photos: [SimplePhoto(name: "dog1"),SimplePhoto(name: "dog2"),SimplePhoto(name: "dog3"),SimplePhoto(name: "dog4"),SimplePhoto(name: "dog5"),SimplePhoto(name: "dog6"),SimplePhoto(name: "dog7")]),
    SimpleUser(name: "John", avatarImage: "user5", photos: [SimplePhoto(name: "fish1"),SimplePhoto(name: "fish2"),SimplePhoto(name: "fish3")]),
    SimpleUser(name: "Michael", avatarImage: "user6", photos: [SimplePhoto(name: "house1"),SimplePhoto(name: "house2"),SimplePhoto(name: "house3")]),
    SimpleUser(name: "David", avatarImage: "user7", photos: [SimplePhoto(name: "mountain1"),SimplePhoto(name: "mountain2"),SimplePhoto(name: "mountain3")]),
    SimpleUser(name: "Thomas", avatarImage: "user8", photos: [SimplePhoto(name: "phone1"),SimplePhoto(name: "phone2"),SimplePhoto(name: "phone3")]),
    SimpleUser(name: "Charles", avatarImage: "user9", photos: [SimplePhoto(name: "table1"),SimplePhoto(name: "table2"),SimplePhoto(name: "table3")]),
    SimpleUser(name: "Christopher", avatarImage: "user10", photos: [SimplePhoto(name: "tree1"),SimplePhoto(name: "tree2"),SimplePhoto(name: "tree3")]),
    SimpleUser(name: "Daniel", avatarImage: "user11", photos: [SimplePhoto(name: "cat1"),SimplePhoto(name: "bird1")]),
    SimpleUser(name: "Matthew", avatarImage: "user12", photos: [SimplePhoto(name: "bird4"),SimplePhoto(name: "car1")]),
    SimpleUser(name: "Anthony", avatarImage: "user13", photos: [SimplePhoto(name: "car4"),SimplePhoto(name: "dog5")]),
    SimpleUser(name: "Steven", avatarImage: "user14", photos: [SimplePhoto(name: "dog4"),SimplePhoto(name: "fish1")]),
    SimpleUser(name: "Andrew", avatarImage: "user15", photos: [SimplePhoto(name: "fish3"),SimplePhoto(name: "house1")]),
    SimpleUser(name: "Joshua", avatarImage: "user16", photos: [SimplePhoto(name: "house3"),SimplePhoto(name: "mountain3")]),
    SimpleUser(name: "Kenneth", avatarImage: "user17", photos: [SimplePhoto(name: "phone3"),SimplePhoto(name: "table3")]),
    SimpleUser(name: "Kevin", avatarImage: "user18", photos: [SimplePhoto(name: "tree1"),]),
    SimpleUser(name: "Gary", avatarImage: "user19", photos: [SimplePhoto(name: "cat")])
    
]
