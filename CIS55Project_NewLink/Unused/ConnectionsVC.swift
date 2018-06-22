//
//  ConnectionsVC.swift
//  CIS55Project_NewLink
//
//  Created by Tony King on 6/10/18.
//  Copyright © 2018 DeAnza. All rights reserved.
//

import UIKit

class ConnectionsVC: UITableViewController {

    private var connections = [Connection]();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        DBProvider.Instance.delegate = self;
//        DBProvider.Instance.getConnections();

//        func dataReceived(connections: [Connection]) {
//            self.connections = connections;
            
    //        myTable.reloadData();
        }
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    // }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return connections.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
     cell.textLabel?.text = "THIS WORKS"
        return cell;
    }

    @IBAction func logout(_ sender: Any) {
        if AuthProvider.Instance.logOut() {
            dismiss(animated: true, completion: nil)
            
            
            
        }
        
    }
    

} //class








































