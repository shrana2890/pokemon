//
//  HomeTableViewController.swift
//  InClassExercisesStarter
//
//  Created by Sukhwinder Rana on 2018-12-02.
//  Copyright © 2018 room1. All rights reserved.
//

import UIKit
import FirebaseFirestore
import CoreLocation
import MapKit

class HomeTableViewController: UITableViewController,CLLocationManagerDelegate{
    var manager:CLLocationManager!
    var username = ""
    var db:Firestore!
    var items = ["Meon", "Pikachu", "Squirtle","Zubur","Jigglypuff"]
    var images = ["meon.png", "pikachu.png", "squirtle.png","zubur.png","jigglypuff.png"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestAlwaysAuthorization()
        manager.startUpdatingLocation()
        pokemonData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        
        // Configure the cell...
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let i = indexPath.row
        
        print("Person clicked in row number: \(i)")
        performSegue(withIdentifier: "pokemonDetail", sender: nil)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let i = self.tableView.indexPathForSelectedRow?.row
        
        
        print("Selected row: \(i!)")
        let n1 = segue.destination as! PokermonDetailViewController
        n1.pokemonName = items[i!]
        n1.rowImage = images[i!]
        n1.username = self.username
        // n1.r = i ?? 0
        
        print("\(i) row selected as pokemon")
        
        
    }
    func pokemonData() {
        let pokemon = db.collection("Pokemon")
        
        pokemon.document("Meon").setData([
            "name": "Meon",
            "Health Point": 140,
            "currentHealth": 140,
            "defence": 10,
            "action": 10,
            "level" : 1
            ])
        pokemon.document("Pikachu").setData([
            "name": "Pikachu",
            "Health Point": 110,
            "currentHealth": 110,
            "defence": 15,
            "action": 5,
            "level" : 2
            ])
        pokemon.document("Squirtle").setData([
            "name": "Squirtle",
            "Health Point": 100,
            "currentHealth": 100,
            "defence": 25,
            "action": 5,
            "level" : 1
            ])
        pokemon.document("Zubur").setData([
            "name": "Zubur",
            "Health Point": 110,
            "currentHealth": 110,
            "defence": 15,
            "action": 4,
            "level" : 3
            ])
        pokemon.document("Jigglypuff").setData([
            "name": "Jigglypuff",
            "Health Point": 80,
            "currentHealth": 80,
            "defence": 35,
            "action": 4,
            "level" : 1
            ])
    }

}
