//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by Yimeng Zhou on 6/30/15.
//  Copyright (c) 2015 Yimeng Zhou. All rights reserved.
//

import UIKit
import CoreData

class RestaurantTableViewController: UITableViewController,NSFetchedResultsControllerDelegate {
    
    var fetchResultController:NSFetchedResultsController!
    
    @IBAction func unwindToHomeScreen(segue:UIStoryboardSegue){
        
    }
    var restaurants:[Restaurant] = []
    
    /*var restaurants:[Restaurant] = [
        Restaurant(name: "Cafe Deadend", type: "Coffee & Tea Shop", location: "G/F, 72 Po Hing Fong, Sheung Wan, Hong Kong", image: "cafedeadend.jpg", isVisited: true),
        Restaurant(name: "Homei", type: "Cafe", location: "Shop B, G/F, 22-24A Tai Ping San Street SOHO, Sheung Wan, Hong Kong", image: "homei.jpg", isVisited: false),
        Restaurant(name: "Teakha", type: "Tea House", location: "Shop B, 18 Tai Ping Shan Road SOHO, Sheung Wan, Hong Kong", image: "teakha.jpg", isVisited: false),
        Restaurant(name: "Cafe loisl", type: "Austrian / Causual Drink", location: "Shop B, 20 Tai Ping Shan Road SOHO, Sheung Wan, Hong Kong", image: "cafeloisl.jpg", isVisited: false),
        Restaurant(name: "Petite Oyster", type: "French", location: "24 Tai Ping Shan Road SOHO, Sheung Wan, Hong Kong", image: "petiteoyster.jpg", isVisited: false),
        Restaurant(name: "For Kee Restaurant", type: "Bakery", location: "Shop J-K., 200 Hollywood Road, SOHO, Sheung Wan, Hong Kong", image: "forkeerestaurant.jpg", isVisited: false),
        Restaurant(name: "Po's Atelier", type: "Bakery", location: "G/F, 62 Po Hing Fong, Sheung Wan, Hong Kong", image: "posatelier.jpg", isVisited: false),
        Restaurant(name: "Bourke Street Backery", type: "Chocolate", location: "633 Bourke St Sydney New South Wales 2010 Surry Hills", image: "bourkestreetbakery.jpg", isVisited: false),
        Restaurant(name: "Haigh's Chocolate", type: "Cafe", location: "412-414 George St Sydney New South Wales", image: "haighschocolate.jpg", isVisited: false),
        Restaurant(name: "Palomino Espresso", type: "American / Seafood", location: "Shop 1 61 York St Sydney New South Wales", image: "palominoespresso.jpg", isVisited: false),
        Restaurant(name: "Upstate", type: "American", location: "95 1st Ave New York, NY 10003", image: "upstate.jpg", isVisited: false),
        Restaurant(name: "Traif", type: "American", location: "229 S 4th St Brooklyn, NY 11211", image: "traif.jpg", isVisited: false),
        Restaurant(name: "Graham Avenue Meats", type: "Breakfast & Brunch", location: "445 Graham Ave Brooklyn, NY 11211", image: "grahamavenuemeats.jpg", isVisited: false),
        Restaurant(name: "Waffle & Wolf", type: "Coffee & Tea", location: "413 Graham Ave Brooklyn, NY 11211", image: "wafflewolf.jpg", isVisited: false),
        Restaurant(name: "Five Leaves", type: "Coffee & Tea", location: "18 Bedford Ave Brooklyn, NY 11222", image: "fiveleaves.jpg", isVisited: false),
        Restaurant(name: "Cafe Lore", type: "Latin American", location: "Sunset Park 4601 4th Ave Brooklyn, NY 11220", image: "cafelore.jpg", isVisited: false),
        Restaurant(name: "Confessional", type: "Spanish", location: "308 E 6th St New York, NY 10003", image: "confessional.jpg", isVisited: false),
        Restaurant(name: "Barrafina", type: "Spanish", location: "54 Frith Street London W1D 4SL United Kingdom", image: "barrafina.jpg", isVisited: false),
        Restaurant(name: "Donostia", type: "Spanish", location: "10 Seymour Place London W1H 7ND United Kingdom", image: "donostia.jpg", isVisited: false),
        Restaurant(name: "Royal Oak", type: "British", location: "2 Regency Street London SW1P 4BZ United Kingdom", image: "royaloak.jpg", isVisited: false),
        Restaurant(name: "Thai Cafe", type: "Thai", location: "22 Charlwood Street London SW1V 2DY Pimlico", image: "thaicafe.jpg", isVisited: false)
        ]*/
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain,
            target: nil, action: nil)
        
        
            var fetchRequest = NSFetchRequest(entityName: "Restaurant")
            let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
            fetchRequest.sortDescriptors = [sortDescriptor]
            if let managedObjectContext = (UIApplication.sharedApplication().delegate as!
            AppDelegate).managedObjectContext {
            fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest,
            managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultController.delegate = self
            var e: NSError?
            var result = fetchResultController.performFetch(&e)
            restaurants = fetchResultController.fetchedObjects as! [Restaurant]
            if result != true {
            println(e?.localizedDescription)
            } }
           

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
    
        switch type {
    case .Insert:
            tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
    case .Delete:
                tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
    case .Update:
            tableView.reloadRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
    default:
            tableView.reloadData()
        }
        
    restaurants = controller.fetchedObjects as! [Restaurant]
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
    tableView.endUpdates()
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.restaurants.count
        
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! CustomTableViewCell

        // Configure the cell...
        let restaurant = restaurants[indexPath.row]
        cell.nameLabel.text = restaurant.name
        cell.thumbnailImageView.image = UIImage(data: restaurant.image)
        cell.locationLabel.text = restaurant.location
        cell.typeLabel.text = restaurant.type
        //cell.favorIconImageView.hidden = !restaurant.isVisited
        // Circular image
        cell.thumbnailImageView.layer.cornerRadius = cell.thumbnailImageView.frame.size.width / 2
        cell.thumbnailImageView.clipsToBounds = true
        cell.thumbnailImageView.layer.cornerRadius = 10.0
        /*cell.nameLabel!.text = restaurantNames[indexPath.row]
        cell.thumbnailImageView!.image = UIImage(named: restaurantImages[indexPath.row])
        cell.typeLabel.text = restaurantTypes[indexPath.row]
        cell.locationLabel.text = restaurantLocations[indexPath.row]*/
        
       // cell.thumbnailImageView.layer.cornerRadius = cell.thumbnailImageView.frame.size.width / 2
            // 圆形
        //cell.thumbnailImageView.clipsToBounds = true
        //cell.thumbnailImageView.layer.cornerRadius = 10.0 // 圆角
        //cell.accessoryType = restaurants[indexPath.row].isVisited ? .Checkmark : .None
        return cell
    }
    
    /*override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath:
            NSIndexPath) {
            // Create an option menu as an action sheet
            let optionMenu = UIAlertController(title: nil, message: "What do you want to do?",
            preferredStyle: .ActionSheet)
            // Add actions to the menu
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            optionMenu.addAction(cancelAction)
            // Display the menu
            self.presentViewController(optionMenu, animated: true, completion: nil)
                                        // parameter and return type
            let callActionHandler = { (action:UIAlertAction!) -> Void in // closure body
            let alertMessage = UIAlertController(title: "Service Unavailable", message: "Sorry, the call feature is not available yet. Please retry later.", preferredStyle: .Alert)
            alertMessage.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(alertMessage, animated: true, completion: nil)
            }
            let callAction = UIAlertAction(title: "Call " + "123-000-\(indexPath.row)", style:
            UIAlertActionStyle.Default, handler: callActionHandler)
            optionMenu.addAction(callAction)
            
            let isVisitedAction = UIAlertAction(title: "I've been here", style: .Default, handler: {
            (action:UIAlertAction!) -> Void in
            let cell = tableView.cellForRowAtIndexPath(indexPath)
            cell?.accessoryType = .Checkmark
            self.restaurantIsVisited[indexPath.row] = true
            })
            optionMenu.addAction(isVisitedAction)
    }*/
    

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle:
        UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
            if editingStyle == .Delete {
            // Delete the row from the data source
           /* self.restaurantNames.removeAtIndex(indexPath.row)
            self.restaurantLocations.removeAtIndex(indexPath.row)
            self.restaurantTypes.removeAtIndex(indexPath.row)
            self.restaurantIsVisited.removeAtIndex(indexPath.row)
            self.restaurantImages.removeAtIndex(indexPath.row)*/
                  //  self.tableView.reloadData()self.restaurants.removeAtIndex(indexPath.row)
          self.restaurants.removeAtIndex(indexPath.row)
          self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade) // 动画效果
        }    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath:
            NSIndexPath) -> [AnyObject] {
            var shareAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title:
            "Share", handler: { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in

            let shareMenu = UIAlertController(title: nil, message: "Share using",
            preferredStyle: .ActionSheet)
            let twitterAction = UIAlertAction(title: "Twitter", style:
            UIAlertActionStyle.Default, handler: nil)
            let facebookAction = UIAlertAction(title: "Facebook", style:
            UIAlertActionStyle.Default, handler: nil)
            let emailAction = UIAlertAction(title: "Email", style: UIAlertActionStyle.Default,
            handler: nil)
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel,
            handler: nil)
            shareMenu.addAction(twitterAction)
            shareMenu.addAction(facebookAction)
            shareMenu.addAction(emailAction)
            shareMenu.addAction(cancelAction)
            self.presentViewController(shareMenu, animated: true, completion: nil)
            } )
            /*var deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default,
            title: "Delete",handler: { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
            // Delete the row from the data source
                
                self.restaurants.removeAtIndex(indexPath.row)

            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            } )*/
                var deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title:
                "Delete",handler: {
                (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
                // Delete the row from the data source
                if let managedObjectContext = (UIApplication.sharedApplication().delegate as!
                AppDelegate).managedObjectContext {
                let restaurantToDelete = self.fetchResultController.objectAtIndexPath(indexPath) as!
                Restaurant
                managedObjectContext.deleteObject(restaurantToDelete)
                var e: NSError?
                if managedObjectContext.save(&e) != true {
                println("delete error: \(e!.localizedDescription)")
                } }
                })
            shareAction.backgroundColor = UIColor(red: 255.0/255.0, green: 166.0/255.0, blue: 51.0/255.0, alpha: 1.0)
            deleteAction.backgroundColor = UIColor(red: 51.0/255.0, green: 51.0/255.0, blue: 51.0/255.0, alpha: 1.0)
            return [deleteAction, shareAction]
}
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
           // if segue.identifier == "showRestaurantDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
            let destinationController = segue.destinationViewController as! DetailViewController
            destinationController.restaurant = self.restaurants[indexPath.row]
           // destinationController.restaurantImage = self.restaurantImages[indexPath.row]
            } //}
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.hidesBarsOnSwipe = true
    }
}
    
    
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */


