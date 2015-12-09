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
    var totalScore = 0.0
    var country = ""
    var favorite = false
    var wdRanking = ""
    
    //Need to have an array of differentScores, or rather a dictionary of scores
    var scores = [String:Double]()
    
    
    // Methods
    init(name: String, scores: [String:Double], country: String) {
        self.name = name
        self.scores = scores
        self.country = country
    }
}