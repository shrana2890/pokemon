//
//  PokermonDetailViewController.swift
//  InClassExercisesStarter
//
//  Created by Sukhwinder Rana on 2018-12-02.
//  Copyright © 2018 room1. All rights reserved.
//

import UIKit
import FirebaseFirestore
import  Firebase
import Alamofire
import SwiftyJSON
import CoreLocation
import  MapKit


class PokermonDetailViewController:UIViewController,CLLocationManagerDelegate  {
    var manager:CLLocationManager!
    var status = Auth.auth().currentUser
    var userStatus = ""
    var username = ""
    var latitude = 43.6532
    var longitude = -79.3832
    var l = 0.001
    var latlng:[String:[String:Any]] = [:]
    var pokemonData:[String:[String:Any]] = [:]
    var userdata:[String:[String:Any]] = [:]
    var pokemonHealth = 0;
    var pokemonAction = 0;
    var pokemonDefence = 0;
    var pokemonCurrentHealth = 0;
    var pokemonlvl = 0;
    var pokemonExp = 0;
    //set value of l into user defaults
    var db:Firestore!
    var pokemonName = ""
    var rowImage = ""
    var r = 0
    @IBOutlet weak var labelSucessMessage: UILabel!
    @IBOutlet weak var pokemonDetailLabel: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    var bc = ""
    @IBAction func buttonSelectPokemon(_ sender: Any) {
        db = Firestore.firestore()
        self.latitude = self.latitude + l
        self.longitude = self.longitude - l
        
        
        let location = db.collection("latlng")
        
        location.document("latlng").setData([
            "latitude": self.latitude,
            "longitude": self.longitude,
            ])
        
           UserData()
          performSegue(withIdentifier: "mapSegue", sender: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        if (self.status != nil){
            self.userStatus = "online"
        }
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestAlwaysAuthorization()
        manager.startUpdatingLocation()
        let ref = db.collection("Pokemon").whereField("name", isEqualTo: self.pokemonName)
        ref.getDocuments() {
            (querySnapshot, err) in
            if (err == nil){
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                   // self.pokemonData[document.documentID] =  document.data()
                    self.pokemonHealth = document["Health Point"]! as! Int
                    self.pokemonAction = document["action"]! as! Int
                    self.pokemonDefence = document["defence"]! as! Int
                    self.labelSucessMessage.text! =
                        "Name:\(document["name"]! )" +
                        "   Health Points:\(document["Health Point"]!)" +
                        "\n Actions:\(document["action"]!)" +
                    "   Defence: \(document["defence"]!)"
                    print(self.rowImage)
                    self.pokemonImage.image = UIImage(named: self.rowImage)
                }
            }
            else if let err = err {
                print("this Pokemon is not in database")
                self.labelSucessMessage.text! = "Error getting documents: \(err)"
            }
        }
        db.collection("latlng").getDocuments() {
            (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    //print("\(document.documentID) = \(document.data())")
                    self.latlng[document.documentID] =  document.data()
                    print(self.latlng[document.documentID] ?? "unknown")
                }
                for i in self.latlng.values {
                    self.latitude = i["latitude"]! as! Double
                    self.longitude = i["longitude"]! as! Double
                    
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("got a new location")
        
        if (locations.count == 0) {
            print("Error getting your location!")
            return
        }
        else {
            print(locations[0])
            let searchRequest = MKLocalSearchRequest()
            latitude = locations[0].coordinate.latitude
            longitude = locations[0].coordinate.longitude
            
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func  UserData() {
        
        
        let user = db.collection("users").whereField("name", isEqualTo: self.username)
        user.getDocuments() {
            (querySnapshot, err) in
            if (querySnapshot?.count ?? 0 > 0) {
            print("old:\( querySnapshot?.count)")
            
                for document in querySnapshot!.documents {
                    //if(document.documentID == self.username){
                        print("oldoldold old old old old1111111111111111")
                        let use = self.db.collection("users")
                        var n = self.username
                        use.document(n).setData([
                            "name": self.username,
                            "latitude": document["latitude"]! as! Double,
                            "longitude": document["longitude"]! as! Double,
                            "pokemon": self.pokemonName,
                            "icon": self.rowImage,
                            "status": "online",
                            "money" : document["money"]! as! Int,
                            "pokemonsDefeated" : document["pokemonsDefeated"]! as! Int
                            ])
                   }
                }
               else{
                print("new")
                let use = self.db.collection("users")
                var n = self.username
                use.document(n).setData([
                    "name": self.username,
                    "latitude": self.latitude,
                    "longitude": self.longitude,
                    "pokemon": self.pokemonName,
                    "icon": self.rowImage,
                    "status": "online",
                    "money" : 200,
                    "pokemonsDefeated" : 0
                    ])
            }
        }

        let userPokemon = self.db.collection("userPokemon")
        var s = self.username
        userPokemon.document(s).setData([
            "name": self.pokemonName ?? "Meon",
            "Health Point": self.pokemonHealth,
            "defence": self.pokemonDefence,
            "action": self.pokemonAction,
            "level": 1,
            "exp": 0,
            "currentHealth": self.pokemonHealth
            ])
    
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        print("segue prepared")
        let n1 = segue.destination as! PokemonMapViewController
        n1.pokemonName = self.pokemonName
        n1.username = self.username
        n1.row = self.rowImage
        n1.status = self.userStatus
    }
    
    
}
