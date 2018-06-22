//
//  Connections2VC.swift
//  CIS55Project_NewLink
//
//  Created by Tony King on 6/13/18.
//  Copyright © 2018 DeAnza. All rights reserved.
//

import UIKit
import FirebaseStorage

class Connections2VC: UIViewController, UITableViewDelegate, UITableViewDataSource, FetchData {

     private var connections = [Connection]()
    
    @IBOutlet weak var myTable: UITableView!
    
    @IBAction func logoutToFirstScreen(_ sender: Any) {
        let logoutAlert = UIAlertController(title: "Logging Out", message:"Are you sure?", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) -> Void in })
        let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in if AuthProvider.Instance.logOut() {
            self.performSegue(withIdentifier: "unwindToLoginScreen", sender: self)
            }
        })
        logoutAlert.addAction(okAction)
        logoutAlert.addAction(cancel)
        
        present(logoutAlert, animated: true, completion: nil)
        
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DBProvider.Instance.delegate = self
        DBProvider.Instance.getConnections()
        
        self.myTable.backgroundColor = UIColor.clear
        self.myTable.backgroundView = UIImageView(image: #imageLiteral(resourceName: "newLinkConnectionsBG2"))
        
//        self.myTable.backgroundView?.contentMode = .scaleAspectFit
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        
        
    }
    
    func dataReceived(connections: [Connection]) {
            self.connections = connections;
        
            myTable.reloadData();

        // Do any additional setup after loading the view.
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return connections.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellItem = connections[indexPath.row]
        print(cellItem.getFirstName())
        print(cellItem.getLastName())
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            
            if let indexPath = self.myTable.indexPathForSelectedRow {
                let detailVC = segue.destination as! DetailViewController
                
                detailVC.userDetail = connections[indexPath.row]
                
            }
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PeopleTableViewCell
        cell.cellUserName.text = connections[indexPath.row].getName()
        cell.cellUserJobCompany.text = connections[indexPath.row].getJob() + " at " + connections[indexPath.row].getCompany()
        cell.cellUserLocation.text = connections[indexPath.row].getLocation()
        
        //let imagePath = _id + "profilePic"
        //let imageRef = Storage.storage().reference().child("0nGPOVX5gua0SCRyue1LYBS47A93profilePic")
        
        cell.cellProfilePic.sd_setImage(with: connections[indexPath.row].getImage() as! StorageReference )
        //cell.textLabel?.text = connections[indexPath.row].name
        
        cell.cellProfilePic.clipsToBounds = true
        cell.cellProfilePic?.layer.masksToBounds = true
        cell.cellProfilePic.layer.borderColor = (UIColor.white).cgColor
        cell.backgroundColor = UIColor.clear
        
        //      cell.cellImage.layer.borderWidth = 2
        let lineWidth = CGFloat(7.0)
        let rect = CGRect(x: 0.0, y: 0.0, width: 150, height: 150)
        let sides = 6
        
        var path = roundedPolygonPath(rect: rect, lineWidth: lineWidth, sides: sides, cornerRadius: 15.0, rotationOffset: CGFloat(-M_PI / 2.0))
        
        let borderLayer = CAShapeLayer()
        borderLayer.frame = CGRect(x : 0.0, y : 0.0, width : path.bounds.width + lineWidth, height : path.bounds.height + lineWidth)
        borderLayer.path = path.cgPath
        borderLayer.lineWidth = lineWidth
        borderLayer.lineJoin = kCALineJoinRound
        borderLayer.lineCap = kCALineCapRound
        borderLayer.strokeColor = UIColor.black.cgColor
        borderLayer.fillColor = UIColor.white.cgColor
        
        let hexagon = createImage(layer: borderLayer)
        borderLayer.contents = hexagon
        cell.cellProfilePic.layer.mask = borderLayer
        
        // For fade-in animation, set initial state, duration and final state
        cell.alpha = 0
        UIView.animate(withDuration: 1, animations: { cell.alpha = 1 })
        
        return cell;
    }
    
    @IBAction func logout(_ sender: Any) {
        performSegue(withIdentifier: "unwindToLoginScreen", sender: self)
    }

    public func roundedPolygonPath(rect: CGRect, lineWidth: CGFloat, sides: NSInteger, cornerRadius: CGFloat, rotationOffset: CGFloat = 0) -> UIBezierPath {
        let path = UIBezierPath()
        let theta: CGFloat = CGFloat(2.0 * M_PI) / CGFloat(sides) // How much to turn at every corner
        let offset: CGFloat = cornerRadius * tan(theta / 2.0)     // Offset from which to start rounding corners
        let width = min(rect.size.width, rect.size.height)        // Width of the square
        
        let center = CGPoint(x: rect.origin.x + width / 2.0, y: rect.origin.y + width / 2.0)
        
        // Radius of the circle that encircles the polygon
        // Notice that the radius is adjusted for the corners, that way the largest outer
        // dimension of the resulting shape is always exactly the width - linewidth
        let radius = (width - lineWidth + cornerRadius - (cos(theta) * cornerRadius)) / 2.0
        
        // Start drawing at a point, which by default is at the right hand edge
        // but can be offset
        var angle = CGFloat(rotationOffset)
        
        let corner = CGPoint(x: center.x + (radius - cornerRadius) * cos(angle), y : center.y + (radius - cornerRadius) * sin(angle))
        path.move(to: CGPoint(x: corner.x + cornerRadius * cos(angle + theta), y : corner.y + cornerRadius * sin(angle + theta)))
        
        for _ in 0..<sides {
            angle += theta
            
            let corner = CGPoint(x: center.x + (radius - cornerRadius) * cos(angle), y : center.y + (radius - cornerRadius) * sin(angle))
            let tip = CGPoint(x: center.x + radius * cos(angle), y : center.y + radius * sin(angle))
            let start = CGPoint(x: corner.x + cornerRadius * cos(angle - theta),y : corner.y + cornerRadius * sin(angle - theta))
            let end = CGPoint(x: corner.x + cornerRadius * cos(angle + theta), y : corner.y + cornerRadius * sin(angle + theta))
            
            path.addLine(to: start)
            path.addQuadCurve(to: end, controlPoint: tip)
        }
        
        path.close()
        
        // Move the path to the correct origins
        let bounds = path.bounds
        let transform = CGAffineTransform(translationX: -bounds.origin.x + rect.origin.x + lineWidth / 2.0, y: -bounds.origin.y + rect.origin.y + lineWidth / 2.0)
        path.apply(transform)
        
        return path
    }
    
    public func createImage(layer: CALayer) -> UIImage {
        let size = CGSize(width:  layer.frame.size.width, height: layer.frame.size.height)
        UIGraphicsBeginImageContextWithOptions(size, layer.isOpaque, 0.0)
        let ctx = UIGraphicsGetCurrentContext()
        
        layer.render(in: ctx!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return image!
    }
} // class

















