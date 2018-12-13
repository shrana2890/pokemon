//
//  ScoreBoardTableViewController.swift
//  InClassExercisesStarter
//
//  Created by Sukhwinder Rana on 2018-12-12.
//  Copyright © 2018 room1. All rights reserved.
//

import UIKit
import FirebaseFirestore
import  Firebase

class ScoreBoardTableViewController: UITableViewController {
     var username = ""
    var userEmail:[String] = [String]()
    var userPokemon :[String] = [String]()
    var userDefeatedPokemon:[Int] = [Int]()
    var userdata:[String:[String:Any]] = [:]
    var result : [String] = [String]()
    var count = 0
    
     var db:Firestore!

    override func viewDidLoad() {
        super.viewDidLoad()
         db = Firestore.firestore()
        
        let ref = db.collection("users")
        ref.getDocuments() {
            (querySnapshot, err) in
            if (err == nil){
                 print("$$$$$$$$$$$$$$$$")
                 print("$Welcome to score board")
                 print("$$$$$$$$$$$$$$$$")
                for document in querySnapshot!.documents {
                    self.count = querySnapshot?.count ?? 0
                      print(self.count)
                    
                    print("\(document.documentID) => \(document.data())")
                    self.userdata[document.documentID] =  document.data()
                    self.userEmail.append(document["name"]! as! String)
                    self.userPokemon.append(document["pokemon"]! as! String)
                    self.userDefeatedPokemon.append(document["pokemonsDefeated"]! as! Int)
                    
                }
            }
            else if let err = err {
                print("this user is not in database")
            }
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print("\(self.count)")
        return self.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scoreCell", for: indexPath)
       // let single = self.result[indexPath.row]
        //cell.textLabel?.text = userdata[single]?["pokemon"] as? String
         cell.textLabel?.text = self.userEmail[indexPath.row]
        // Configure the cell...

        return cell
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
