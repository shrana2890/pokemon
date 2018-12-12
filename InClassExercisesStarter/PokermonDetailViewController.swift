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
    //var items = ["Mew", "Pikachu", "Squirtle","Zubar"]
    
    @IBOutlet weak var labelSucessMessage: UILabel!
    @IBOutlet weak var pokemonDetailLabel: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    //@IBOutlet weak var lblResult: UILabel!
    // Mark: Firestore variables
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
    }
    // MARK: Default Functions
    override func viewDidLoad() {
        super.viewDidLoad()
       
        //let name = self.name
        db = Firestore.firestore()
        if (self.status != nil){
            self.userStatus = "online"
        }
        //        if UserDefaults.standard.object(forKey: "lat") != nil
        //        {
        //            latitude =  Double(UserDefaults.standard.string(forKey: "lat")!) ?? 43.6532
        //            longitude =  Double(UserDefaults.standard.string(forKey: "lng")!) ?? -79.3832
        //        }
        manager = CLLocationManager()
        manager.delegate = self
        
        // how accurate do you want the lkocation to be?
        manager.desiredAccuracy = kCLLocationAccuracyBest
        
        // ask for permission to get the location
        manager.requestAlwaysAuthorization()
        
        // tell the manager to get the person's location
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
        
        
        //set lat and long for new user
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
        
        
        let user = db.collection("users")
        user.getDocuments() {
            (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
               for document in querySnapshot!.documents {
              if(document.documentID != self.username){
              var n = self.username
             user.document(n).setData([
            "name": self.username,
            "latitude": self.latitude,
            "longitude": self.longitude,
            "pokemon": self.pokemonName,
            "icon": self.rowImage,
            "status": self.userStatus,
            "money" : 200,
            "pokemonsDefeated" : 0
            ])
              }else{
                var n = self.username
                user.document(n).setData([
                    "name": self.username,
                    "latitude": document["latitude"]! as! Double,
                    "longitude": document["longitude"]! as! Double,
                    "pokemon": self.pokemonName,
                    "icon": self.rowImage,
                    "status": self.userStatus,
                    "money" : document["money"]! as! Int,
                    "pokemonsDefeated" : document["pokemonsDefeated"]! as! Int
                    ])
                //self.userdata[document.documentID] =  document.data()
                }
                }
            }
        }
        let userPokemon = db.collection("userPokemon")
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
        let n1 = segue.destination as! PokemonMapViewController
        n1.pokemonName = self.pokemonName
        n1.username = self.username
        n1.row = self.rowImage
        n1.status = self.userStatus
    }
    
    
}
