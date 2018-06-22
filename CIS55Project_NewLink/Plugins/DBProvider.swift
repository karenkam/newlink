//
//  DBProvider.swift
//  CIS55Project_NewLink
//
//  Created by Tony King on 6/10/18.
//  Copyright © 2018 DeAnza. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage
import FirebaseDatabase

protocol FetchData: class {
    func dataReceived(connections: [Connection]);
}

class DBProvider {
    
    private static let _instance = DBProvider();
    
    weak var delegate: FetchData?;
    
    private init () {}
    
    static var Instance: DBProvider {
        return _instance
        
    }
    
    var dbRef: DatabaseReference {
        return Database.database().reference();
    }

    var connectionsRef: DatabaseReference {
        return dbRef.child(Constants.CONNECTIONS);
    }

    var messagesRef: DatabaseReference {
        return dbRef.child(Constants.MESSAGES);
    }

    var mediaMessagesRef: DatabaseReference {
        return dbRef.child(Constants.MEDIA_MESSAGES);
    }

    var storageRef: StorageReference {
        return Storage.storage().reference(forURL: "gs://newlinkgroup0618.appspot.com");
    }

    var imageStorageRef: StorageReference {
        return storageRef.child(Constants.IMAGE_STORAGE);
    }

    var videoStorageRef: StorageReference {
        return storageRef.child(Constants.VIDEO_STORAGE);
    }

    func saveUser(withID: String, email: String, password: String, firstName: String, lastName: String, company: String, title: String, location: String, aboutMe: String, photoURL: String) {
        let data: Dictionary<String, Any> = [Constants.EMIAL: email, Constants.PASSWORD: password, Constants.FIRST_NAME: firstName, Constants.LAST_NAME: lastName, Constants.COMPANY: company, Constants.TITLE: title, Constants.LOCATION: location, Constants.ABOUT_ME: aboutMe, Constants.DOWNLOADURL: photoURL];

        connectionsRef.child(withID).setValue(data);
    }
    
    func getConnections() {

        connectionsRef.observeSingleEvent(of: DataEventType.value) {
            (snapshot: DataSnapshot) in
            var connections = [Connection]();

            if let myConnections = snapshot.value as? NSDictionary {
                for (key, value) in myConnections {
                    if let connectionData = value as? NSDictionary {
                        if let firstName = connectionData[Constants.FIRST_NAME] as? String {
                            let id = key as! String
                            let lname = connectionData[Constants.LAST_NAME] as! String
                            let comp = connectionData[Constants.COMPANY] as! String
                            let loc = connectionData[Constants.LOCATION] as! String
                            let job = connectionData[Constants.TITLE] as! String
                            let about_me = connectionData[Constants.ABOUT_ME] as! String
                            let photo_path = connectionData[Constants.DOWNLOADURL] as! String
                            let newConnection = Connection(id: id, firstName: firstName, lastName: lname , company: comp, location: loc, jobTitle: job, aboutMe: about_me, photoURL: photo_path)
                            connections.append(newConnection);
                        }
                    }
                }
            }

            self.delegate?.dataReceived(connections: connections);
        }
    }
    
    
} // class








































