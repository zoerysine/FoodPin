//
//  AddTableViewController.swift
//  FoodPin
//
//  Created by Yimeng Zhou on 7/8/15.
//  Copyright (c) 2015 Yimeng Zhou. All rights reserved.
//

import UIKit
import CoreData

class AddTableViewController: UITableViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    @IBOutlet weak var imageView:UIImageView!
    
    @IBOutlet weak var textName: UITextField!
    
    @IBOutlet weak var textType: UITextField!
    
    @IBOutlet weak var textLocation: UITextField!
    
    @IBOutlet weak var buttonYes: UIButton!
    
    @IBOutlet weak var buttonNo: UIButton!
    
    var isVisited = true
    
    var restaurant:Restaurant!


    override func viewDidLoad() {
        super.viewDidLoad()

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

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath:
        NSIndexPath) {
        
        if indexPath.row == 0 {
        if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
            imagePicker.delegate = self
            
        self.presentViewController(imagePicker, animated: true, completion: nil)
            
        }
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo
            info: [NSObject : AnyObject]) {
            imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
            
            imageView.contentMode = UIViewContentMode.ScaleAspectFill
            imageView.clipsToBounds = true
            dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func save(sender: AnyObject) {
                
                // Form validation
        
        var errorField = ""
        
        if textName.text == "" {
            errorField = "Name"
        }   else if textType.text == "" {
            errorField = "Type"
        } else if textLocation.text == "" {
            errorField = "Location"
        }
        
        if errorField != "" {
            
            let alertController = UIAlertController(title: NSLocalizedString("alert", comment: "Warn"), message: NSLocalizedString("We can't proceed as you forget to fill in the restaurant field", comment: "empty message"), preferredStyle: .Alert)
            let doneAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertController.addAction(doneAction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
            
            return
        }
        
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext{
            restaurant = NSEntityDescription.insertNewObjectForEntityForName("Restaurant", inManagedObjectContext: managedObjectContext) as! Restaurant
            restaurant.name = textName.text
            restaurant.type = textType.text
            restaurant.location = textLocation.text
            restaurant.image = UIImagePNGRepresentation(imageView.image)
            restaurant.isVisited = isVisited
            
            var e:NSError?
            if managedObjectContext.save(&e) != true{
                println("insert error:\(e!.localizedDescription)")
                return
            }else{
                let alertView = UIAlertController(title: nil, message: "Save scuessfully",
                    preferredStyle: UIAlertControllerStyle.Alert)
                let defaultAction = UIAlertAction(title: "ok", style: UIAlertActionStyle.Default) { (alertView:UIAlertAction!) -> Void in
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
                let cancelAction = UIAlertAction(title: "cancel", style: UIAlertActionStyle.Cancel, handler: nil)
                alertView.addAction(defaultAction)
                alertView.addAction(cancelAction)
                self.presentViewController(alertView, animated: true, completion: nil)
            }
        }
        
                /*if let managedObjectContext = (UIApplication.sharedApplication().delegate as!
                        AppDelegate).managedObjectContext {
                restaurant = NSEntityDescription.insertNewObjectForEntityForName("Restaurant", inManagedObjectContext: managedObjectContext) as! Restaurant
                restaurant.name = textName.text
                restaurant.type = textType.text
                restaurant.location = textLocation.text
                restaurant.image = UIImagePNGRepresentation(imageView.image)
                restaurant.isVisited = isVisited
                
                var e:NSError?
                if managedObjectContext.save(&e) != true{
                    println("insert error:\(e!.localizedDescription)")
                    return
                }
                }*/
                
                

        
                // If all fields are correctly filled in, extract the field value
                println("Name: " + textName.text)
                println("Type: " + textType.text)
                println("Location: " + textLocation.text)
                println("Have you been here: " + (isVisited ? "yes" : "no"))
                
                // Execute the unwind segue and go back to the home screen
              //  performSegueWithIdentifier("unwindToHomeScreen", sender: self)
                
    
    }
    
    @IBAction func btnClicked(sender: AnyObject) {
                
                let buttonClicked = sender as! UIButton
                if buttonClicked == buttonYes {
                isVisited = true
                buttonYes.backgroundColor = UIColor(red: 235.0/255.0, green: 73.0/255.0, blue: 27.0/255.0, alpha: 1.0)
                buttonNo.backgroundColor = UIColor.grayColor()
            } else if buttonClicked == buttonNo {
                isVisited = false
                buttonYes.backgroundColor = UIColor.grayColor()
                buttonNo.backgroundColor = UIColor(red: 235.0/255.0, green: 73.0/255.0, blue: 27.0/255.0, alpha: 1.0)
                }
                
    }

       /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...

        return cell
    }
    */

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

}
