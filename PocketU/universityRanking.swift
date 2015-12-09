//
//  universityRanking.swift
//  PocketU
//
//  Created by 罗致沛 on 12/7/15.
//  Copyright © 2015 Edward Ding. All rights reserved.
//

import Foundation

func ranking(universities: [University], weights: [String : Double]) -> [University]
{
//    var maxValues = [String : Double]()
//    var minValues = [String : Double]()
//    
//    /*for (key, _) in weights {
//        maxValues[key] = universities.map{$0.scores[key]!}.maxElement()
//        minValues[key] = universities.map{$0.scores[key]!}.minElement()
//    }*/
    
    for university in universities {
        var totalScore = 0.0
        for (key, weight) in weights {
            totalScore += weight * university.scores[key]!
        }
        university.totalScore = totalScore
    }
    
    var rankingResult = universities.sort({(u1: University, u2: University) -> Bool in
        return u1.totalScore > u2.totalScore
    })
    
    for ind in 0...(rankingResult.count - 1) {
        rankingResult[ind].wdRanking = "\(ind)"
    }
    
    return rankingResult
}