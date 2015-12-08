//
//  DetailViewController.swift
//  PocketU
//
//  Created by 丁嘉瑞 on 15/12/7.
//  Copyright © 2015年 Edward Ding. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    // MAKR: Property
    // university
    var university : University!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Customize title of Navigation bar
        let titleLabel = UILabel(frame: CGRectMake(0,0,200,40))
        titleLabel.text = university.name
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.textAlignment = .Center
        if let barFont = UIFont(name: "Avenir-Light", size: 20.0) {
            titleLabel.font = barFont
        }
        titleLabel.adjustsFontSizeToFitWidth = true
        navigationItem.titleView = titleLabel
    }
}
