//
//  University.swift
//  PocketU
//
//  Created by 丁嘉瑞 on 15/12/6.
//  Copyright © 2015年 Edward Ding. All rights reserved.
//

import Foundation

class University {
    // Properties
    var name = ""
    var totalScore = 0
    var country = ""
    var favorite = false
    var wdRanking = ""
    
    // Methods
    init(name: String, wdRanking: String, totalScore: Int, country: String) {
        self.name = name
        self.wdRanking = wdRanking
        self.totalScore = totalScore
        self.country = country
    }
}