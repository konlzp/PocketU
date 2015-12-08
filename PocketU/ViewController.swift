//
//  ViewController.swift
//  PocketU
//
//  Created by 丁嘉瑞 on 15/12/6.
//  Copyright © 2015年 Edward Ding. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    // Table view
    @IBOutlet weak var mainTableView: UITableView!
    
    // MARK: Property
    // Array of Universities
    var universities = [University]()
    
    // MARK: Maintainence
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load Database
        let dbPath = NSBundle.mainBundle().pathForResource("pocketu", ofType: "db")
        let db = FMDatabase(path: dbPath);
        
        if !db.open() {
            print("Unable to open database")
            return
        }
        
        // Execute query and push results into universities array
        let query = "SELECT " +
            "\(Constants.DB_COLUMS.UNIV_NAME)," +
            "\(Constants.DB_COLUMS.OV_SCORE)," +
            "\(Constants.DB_COLUMS.COUNTRY)," +
            "\(Constants.DB_COLUMS.WD_RANKING)" +
            " FROM SJ_RANKING"
        do {
            let rs = try db.executeQuery(query, values: nil)
            
            // Push query result into array
            while rs.next() {
                let name = rs.objectForColumnName(Constants.DB_COLUMS.UNIV_NAME) as! String
                let score = rs.objectForColumnName(Constants.DB_COLUMS.OV_SCORE) as! Int
                let country = rs.objectForColumnName(Constants.DB_COLUMS.COUNTRY) as! String
                let wdRanking = rs.objectForColumnName(Constants.DB_COLUMS.WD_RANKING) as! String
                
                universities.append(University(name: name, wdRanking: wdRanking, totalScore: score, country: country))
            }
        }
        catch let error as NSError{
            print("Query Failed. \(error.localizedDescription)")
        }
        
        db.close()
        
        // Self sizing cell
        mainTableView.estimatedRowHeight = 80.0
        mainTableView.rowHeight = UITableViewAutomaticDimension
        
        // Set Navigation Bar
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
    }
    
    // MARK: Table View
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return universities.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! RankCell
        
        // Cell configuration
        cell.nameLabel.text = universities[indexPath.row].name
        cell.countryLabel.text = universities[indexPath.row].country
        let wdRanking = universities[indexPath.row].wdRanking
        
        if let wdRankingInt = Int(wdRanking) {
            cell.rankBtn.setTitle(wdRanking, forState: .Normal)
            // Set color for top three
            var btnColor = UIColor(red: 0.0, green: 130.0/255.0, blue: 15.0/255.0, alpha: 1.0)
            if wdRankingInt == 1 {
                btnColor = UIColor(red: 200.0/255.0, green: 0.0, blue: 0.0, alpha: 1.0)
            }
            else if wdRankingInt == 2 {
                btnColor = UIColor(red: 1.0, green: 100.0/255.0, blue: 0.0, alpha: 1.0)
            }
            else if wdRankingInt == 3 {
                btnColor = UIColor(red: 1.0, green: 190.0/255.0, blue: 0.0, alpha: 1.0)
            }
            cell.rankBtn.backgroundColor = btnColor
        } else {
            cell.rankBtn.setTitle("N/A", forState: .Normal)
            cell.rankBtn.backgroundColor = UIColor(red: 128.0/255.0, green: 128.0/255.0, blue: 128.0/255.0, alpha: 1.0)
        }
        
        cell.scoreLabel.text = "\(universities[indexPath.row].totalScore)/100"
        cell.thumbnailImgView.image = UIImage(named: "test")
        cell.favoriteImgView.image = cell.favoriteImgView.image?.imageWithRenderingMode(.AlwaysTemplate)
        
        cell.favoriteImgView.hidden = !universities[indexPath.row].favorite
        
        return cell
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        // Social Sharing Button
        let shareAction = UITableViewRowAction(style: .Default, title: "Share") {
            (action, indexPath) -> Void in
            let defaultText = "Checkout \(self.universities[indexPath.row].name), it's awsome!"
            // TODO: Add image to share
            let acController = UIActivityViewController(activityItems: [defaultText], applicationActivities: nil)
            self.presentViewController(acController, animated: true, completion: nil)
        }
        shareAction.backgroundColor = UIColor(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0)

        // Favorite Button
        let favorite = universities[indexPath.row].favorite
        let favoriteTitle = favorite ? "Unlike" : "Like"
        let favoriteAction = UITableViewRowAction(style: .Default, title: favoriteTitle) {
            (action, indexPath) -> Void in
            self.universities[indexPath.row].favorite = !favorite
            self.mainTableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Right)
        }
        favoriteAction.backgroundColor = UIColor(red: 1.0, green: 149/255.0, blue: 0.0, alpha: 1.0)
        
        return [favoriteAction, shareAction]
    }
    
    // MARK: Segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetailSegue" {
            if let indexPath = mainTableView.indexPathForSelectedRow {
                mainTableView.deselectRowAtIndexPath(indexPath, animated: true)
                let dvc = segue.destinationViewController as! DetailViewController
                dvc.university = universities[indexPath.row]
            }
        }
    }
}

