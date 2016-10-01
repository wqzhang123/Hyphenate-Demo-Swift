//
//  ConversationsTableViewController.swift
//  Hyphenate Messenger
//
//  Created by peng wan on 9/27/16.
//  Copyright © 2016 Hyphenate Inc. All rights reserved.
//

import UIKit
import HyphenateFullSDK

public enum DeleteConvesationType: Int {
    case DeleteConvesationOnly
    case DeleteConvesationWithMessages
}

public protocol ConversationListViewControllerDelegate: class {
    
    func conversationListViewController(conversationListViewController:ConversationsTableViewController, didSelectConversationModel conversationModel: AnyObject)
}

@objc public protocol ConversationListViewControllerDataSource: class {
    
    func conversationListViewController(conversationListViewController: ConversationsTableViewController, modelForConversation conversation: EMConversation) -> AnyObject
    
    optional func conversationListViewController(conversationListViewController:ConversationsTableViewController, latestMessageTitleForConversationModel conversationModel: AnyObject) -> String
    
    optional func conversationListViewController(conversationListViewController: ConversationsTableViewController, latestMessageTimeForConversationModel conversationModel: AnyObject) -> String
}

public class ConversationsTableViewController: UITableViewController, ConversationListViewControllerDelegate, ConversationListViewControllerDataSource, UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate {

    var dataSource = [AnyObject]()
    var searchController : UISearchController!

    override public func viewDidLoad() {
        super.viewDidLoad()
        
        searchController = UISearchController(searchResultsController:  nil)
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        searchController.searchBar.delegate = self
        
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = true
        navigationItem.titleView = searchController.searchBar
        definesPresentationContext = true
        
        let image = UIImage(named: "iconNewConversation")
        let imageFrame = CGRectMake(0, 0, (image?.size.width)!, (image?.size.height)!)
        let newConversationButton = UIButton(frame: imageFrame)
        newConversationButton.setBackgroundImage(image, forState: .Normal)
        newConversationButton.addTarget(self, action: Selector(composeConversationAction()), forControlEvents: .TouchUpInside)
        newConversationButton.showsTouchWhenHighlighted = true
        let rightButtonItem = UIBarButtonItem(customView: newConversationButton)
        navigationItem.rightBarButtonItem = rightButtonItem

    }

    func composeConversationAction() {
        
    }
    
    public func updateSearchResultsForSearchController(searchController: UISearchController) {
        
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    public func conversationListViewController(conversationListViewController:ConversationsTableViewController, didSelectConversationModel conversationModel: AnyObject)
    {
        
    }
    
    public func conversationListViewController(conversationListViewController: ConversationsTableViewController, modelForConversation conversation: EMConversation) -> AnyObject
    {
        return String()
    }
    
    public func conversationListViewController(conversationListViewController:ConversationsTableViewController, latestMessageTitleForConversationModel conversationModel: AnyObject) -> String
    {
        return String()
    }
    
    public func conversationListViewController(conversationListViewController: ConversationsTableViewController, latestMessageTimeForConversationModel conversationModel: AnyObject) -> String
    {
        return String()
    }


    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
