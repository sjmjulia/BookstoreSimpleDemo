//
//  User.swift
//  BookstoreSimpleDemo
//
//  Created by ShenJiamei on 5/22/17.
//  Copyright © 2017 REINS. All rights reserved.
//

import Foundation
import HandyJSON

class Book: HandyJSON {
    var id:Int?
    var title:String?
    var author:String?
    var price: Double?
    var publisher: String?
//    var date: Date?
    
    required init(){}
    
    init(id: Int, title: String, author: String, publisher: String, price: Double = 0.0) {
        self.id = id
        self.title = title
        self.author = author
        self.publisher = publisher
        self.price = price
    }
}

struct BookList: HandyJSON {
    var books:[Book] = []
}
