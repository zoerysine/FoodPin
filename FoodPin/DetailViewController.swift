//
//  DetailViewController.swift
//  FoodPin
//
//  Created by Yimeng Zhou on 7/1/15.
//  Copyright (c) 2015 Yimeng Zhou. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet var restaurantImageView:UIImageView!
    
    @IBOutlet var tableView:UITableView!
    
    @IBAction func close(segue:UIStoryboardSegue) {
    }
    //var restaurantImage:String = "text"
    
    var restaurant:Restaurant!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     //  println(restaurantImage)
        // Do any additional setup after loading the view.
        title = self.restaurant.name
        self.restaurantImageView.image = UIImage(data: restaurant.image)
        self.tableView.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.2)
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        self.tableView.separatorColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.8)
        tableView.estimatedRowHeight = 36.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4 }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->
            UITableViewCell {
                let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
                    as! DetailTableViewCell
                cell.backgroundColor = UIColor.clearColor()
                // Configure the cell...
                cell.mapButton.hidden = true
                switch indexPath.row {
                case 0:
                    cell.fieldLabel.text = "Name"
                cell.valueLabel.text = restaurant.name
                case 1:
                    cell.fieldLabel.text = "Type"
                cell.valueLabel.text = restaurant.type
                case 2:
                    cell.fieldLabel.text = "Location"
                cell.valueLabel.text = restaurant.location
                cell.mapButton.hidden = false
                case 3:
                    cell.fieldLabel.text = "Been here"
                cell.valueLabel.text = (restaurant.isVisited.boolValue) ? "Yes, I've been here before" : "No"
                default:
                    cell.fieldLabel.text = ""
                cell.valueLabel.text = ""
                }
                return cell
    }
    
    override func viewWillAppear(animated: Bool) {
                super.viewWillAppear(animated)
                self.navigationController?.hidesBarsOnSwipe = false
                self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
                        if segue.identifier == "showMap" {
                        let destinationController = segue.destinationViewController as! MapViewController
                        destinationController.restaurant = restaurant
                        }
    }
    
    
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
