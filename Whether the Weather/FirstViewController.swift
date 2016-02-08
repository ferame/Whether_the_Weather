//
//  FirstViewController.swift
//  Whether the Weather
//
//  Created by Justinas Alisauskas on 30/01/2016.
//  Copyright © 2016 JustInCode. All rights reserved.
//

import UIKit

var cityList = [String]()

class FirstViewController: UIViewController {

    @IBOutlet var cityTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ViewDidLoad")
        // Do any additional setup after loading the view, typically from a nib.
        if NSUserDefaults.standardUserDefaults().objectForKey("cityList") != nil{
            cityList = NSUserDefaults.standardUserDefaults().objectForKey("cityList") as! [String]
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(String(cityList.count) + "is the number of rows")
        print("Number of rows is " + String(cityList.count))
        return cityList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")//creating cell that we want to return
        cell.textLabel?.text = cityList[indexPath.row]
        print("Cell populated with " + String(cityList[indexPath.row]))
        return cell
    }
    
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        //method is called whenever user tries to edit item in table
        //checking for swipe to left
        if editingStyle == UITableViewCellEditingStyle.Delete{
            cityList.removeAtIndex(indexPath.row)
            NSUserDefaults.standardUserDefaults().setObject(cityList, forKey: "cityList")
            cityTableView.reloadData()
            print("Item removed")
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        print("ViewDidAppear")
        cityTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

