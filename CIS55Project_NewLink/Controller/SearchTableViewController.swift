//
//  SearchTableViewController.swift
//  CIS55Project_NewLink
//
//  Created by Karen Jin on 6/18/18.
//  Copyright © 2018 DeAnza. All rights reserved.
//

import UIKit
import Firebase

class SearchTableViewController: UITableViewController, FetchData, UISearchResultsUpdating {
    
    
    private var searchDatabase = [Connection]()
    
    var searchResults : [Connection] = []
    var searchController: UISearchController!
    
    @IBOutlet var resultFullName: UILabel!
    @IBOutlet var resultImage: UIImageView!
    @IBOutlet var resultJobtitle: UILabel!
    @IBOutlet var resultCompany: UILabel!
    @IBOutlet var resultLocation: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DBProvider.Instance.delegate = self
        DBProvider.Instance.getConnections()
        
        //self.tableView.backgroundColor = UIColor.clear
        self.tableView.backgroundView = UIImageView(image: #imageLiteral(resourceName: "newLinkConnectionsBG2"))
        
        self.searchController = UISearchController(searchResultsController: nil)
        self.searchController.searchBar.sizeToFit()
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchResultsUpdater = self
        self.searchController.dimsBackgroundDuringPresentation = false
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.placeholder = "Search Names"
        definesPresentationContext = true
        self.tableView.tableHeaderView = self.searchController.searchBar

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

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
        return searchResults.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Search Result"
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchItem", for: indexPath) as! SearchTableViewCell

        // Configure the cell...
        cell.backgroundColor = UIColor.clear
        var cellItem : Connection
        if searchController.isActive {
            
            cellItem = searchResults[indexPath.row]
            cell.resultFullName?.text = searchResults[indexPath.row].getName()
            cell.resultCompany?.text = searchResults[indexPath.row].getCompany()
            cell.resultJobTitle?.text = searchResults[indexPath.row].getJob()
            cell.resultLocation?.text = searchResults[indexPath.row].getLocation()
            cell.resultImage.sd_setImage(with: searchResults[indexPath.row].getImage() as! StorageReference )
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellItem = searchResults[indexPath.row]
    }

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowResultDetail" {
            
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let searchDetailVC = segue.destination as! SearchResultDetailViewController

               
                searchDetailVC.searchDetail =  searchResults[indexPath.row]
            }
        }
    }
    
    func dataReceived(connections: [Connection]) {
        self.searchDatabase = connections;
        tableView.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let textToSearch = searchController.searchBar.text {
            filterContentForSearchText(searchText: textToSearch)
            tableView.reloadData()
        }
    }
    
    
    func filterContentForSearchText(searchText: String){
        searchResults = searchDatabase.filter({ (Individual: Connection) -> Bool in
            let nameMatch = Individual.getName().range(of: searchText, options: String.CompareOptions.caseInsensitive)
            return nameMatch != nil
        })
    }

}
