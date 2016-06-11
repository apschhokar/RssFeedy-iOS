//
//  RssFeedTableViewController.swift
//  RssFeedy
//
//  Created by ajay singh on 6/9/16.
//  Copyright © 2016 Ajay. All rights reserved.
//

import UIKit

class RssFeedTableViewController: UITableViewController, MWFeedParserDelegate , SideBarDelegate {
    
    var feeds = [MWFeedItem]()
    var sidebar = SideBar()
    
    func request(){
        let myURL = NSURL(string :"http://rss.nytimes.com/services/xml/rss/nyt/Sports.xml")
        let myFeedParser = MWFeedParser(feedURL: myURL!)
        myFeedParser.delegate = self
        myFeedParser.parse()
    
    }

    
    /*************************************************************************************/
    // Feed parse delegates - callbacks
    /*************************************************************************************/

    
    func feedParserDidStart(parser: MWFeedParser!) {
        print("parse started")
        feeds = [MWFeedItem]()
    }
    
    func feedParserDidFinish(parser: MWFeedParser!) {
        print("parse finifhsedh")
        self.tableView.reloadData()
    }
    
    
    func feedParser(parser: MWFeedParser!, didParseFeedInfo info: MWFeedInfo!) {
        print(info)
        self.title = info.title
        
    }
    
    func feedParser(parser: MWFeedParser!, didParseFeedItem item: MWFeedItem!) {
        if item == nil{
           print("whatttt" + item.title)
        }
        
        
        if item.title != nil {
          print("i was finally parsed %@" , item.title)
          feeds.append(item)
        }
    }
    
    /*************************************************************************************/
    /*************************************************************************************/

    
    /*************************************************************************************/
    // Side Bar delegates - callbacks
    /*************************************************************************************/

    
    func sideBarDidSelectMenuButtonAtIndex(index: Int) {
        if index == 0 {
           //add new feed
            let alertView = UIAlertController(title: "Add New Feed", message: "Enter Name and URL!", preferredStyle: UIAlertControllerStyle.Alert);
            alertView.addTextFieldWithConfigurationHandler({ (textField:UITextField!) -> Void in
                textField.placeholder = "Feed name"
            })
            
            alertView.addTextFieldWithConfigurationHandler({ (textField:UITextField!) -> Void in
                textField.placeholder = "Feed URL"
            })

            
        }
    }
    
    
    /*************************************************************************************/
    /*************************************************************************************/
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self

        sidebar = SideBar(sourceView: (self.navigationController?.view)!, menuItems: ["Add Feed"])
        sidebar.delegate = self
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(animated: Bool) {
        request()
    }
    
    /*************************************************************************************/
    // Table View Delegates
    /*************************************************************************************/
    

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return feeds.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        print("height is called")
        return 100.00
    }
    

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        // Configure the cell...
        let item = feeds[indexPath.row] as MWFeedItem
         print("i am called")
        cell.textLabel?.text = item.title
    
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let val = feeds[indexPath.row] as MWFeedItem
        
        let webbrowser = KINWebBrowserViewController()
        let url = NSURL(string: val.link)
        
        webbrowser.loadURL(url)
        
        self.navigationController?.pushViewController(webbrowser, animated: true)
        
    }
    
    
    
    /*************************************************************************************/
    /*************************************************************************************/


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
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
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
