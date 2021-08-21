//
//  ViewController.swift
//  Zendo
//
//  Created by Martine Habib on 12/1/17.
//  Copyright © 2017 NagTime. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {
    
    let notifCenter = NotificationCenter.default
    var sessionList: [Session] = []
    
    var selectedSession: Session?
    
    var selectedRow = -1
    
    
    @IBOutlet weak var helpView: UITextView!
    @IBOutlet var listView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.listView.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.listView.rowHeight = 80.0
        self.listView.backgroundColor = UIColor(netHex: 0xCBCAB7)
     
         notifCenter.addObserver(self, selector: #selector(self.refreshList), name: Notification.Name(rawValue: "listShouldRefresh"), object: nil)
        
        sessionList = SessionEngine.sharedInstance.allItems()
        var labels:[String] = []
        if (sessionList.count > 0) {
            for session in sessionList {
                labels.append(session.title)
            }
            
            for i in 0...SessionEngine.sharedInstance.allItems().count {
                sessionList.append(sessionList[i])
            }
        }
    }

    // Reload upon return to the list without reload
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        refreshList()
        
    }

    @objc func refreshList() {
        sessionList = SessionEngine.sharedInstance.allItems()
        listView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
          return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sessionList.count
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listView.dequeueReusableCell(withIdentifier: "sessionCell") as! SessionListViewCell
    
        let text = sessionList[indexPath.row].title
        
        cell.sessionLabel.text = text
        
        return cell
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.backgroundColor = UIColor.clear
    }
    
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedRow = (indexPath as NSIndexPath).row
        selectedSession = sessionList[(indexPath as NSIndexPath).row] as Session
        
        return indexPath
    }
    
    // Delete from everywhere, everything about this particular task (action for "confirmAction" below)
    func deleteForever (_ index: IndexPath) {
        // Delete the row from the data source
        let sessionToDelete = sessionList.remove(at: (index as NSIndexPath).row) // remove task from notifications array, assign removed item to 'item'
        listView.deleteRows(at: [index], with: .fade)
        SessionEngine.sharedInstance.removeItem(sessionToDelete, alertType: UserAlertType.delete) // delete backing property list entry and unschedule local notification if still exists
        self.navigationItem.rightBarButtonItem!.isEnabled = true // Make sure add button is enabled.
    }
    
    // Handle the swipe right on a row
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let possibleDelete = sessionList[(indexPath as NSIndexPath).row]
        
        if editingStyle == .delete { // The only editing style we'll support here
            
            let cancelAction = UIAlertAction(title: AlertMessages.noPrompt, style: UIAlertAction.Style.cancel, handler: {(a) -> Void in
                // User tapped "Cancel", so do nothing
            })
            let confirmAction = UIAlertAction(title: AlertMessages.yesPrompt, style: UIAlertAction.Style.destructive, handler: { (a) -> Void in
                // User said "Yes", go ahead and delete.
                self.deleteForever(indexPath)
            })
            
            Utility.userReallyWantsThis("Deleting \"\(possibleDelete.title)\" ", msg: AlertMessages.deletePrompt, view: self, actionNO: cancelAction, actionOK: confirmAction)
        }
    }
    
 
    
    // We are changing page, let's set our current task
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if sessionList.count > 0 {
            if segue.identifier == "StartSessionSegue" {
                let destViewController: SessionViewController = segue.destination as! SessionViewController
                if selectedRow >= 0 { // We could have come from a notification, and there is no selected row
                    selectedSession = sessionList[selectedRow] as Session
                    destViewController.currentSession = selectedSession
                }
            } else {
                // TODO: Go instead to the create new session.
                selectedSession = nil
            }
        }
    }

}

extension Notification.Name {
    static let refreshList = Notification.Name(rawValue: "listShouldRefresh")
}


