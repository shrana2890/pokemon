//
//  PokemonMapViewController.swift
//  InClassExercisesStarter
//
//  Created by Sukhwinder Rana on 2018-12-02.
//  Copyright © 2018 room1. All rights reserved.
//


import UIKit
import Alamofire
import SwiftyJSON
import MapKit
import CoreLocation
import FirebaseFirestore

class PokemonMapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    var db:Firestore!
    let uusername = UserDefaults.standard.string(forKey: "username") ?? ""
    var annotation:MKAnnotation!
    // var images = ["meon.png", "pikachu.png", "squirtle.png","zubur.png","jigglypuff.png"]
    var image = ""
    var status = ""
    var pokemonName = ""
    var row = ""
    var username = ""
    var d = 0
    var pokemonsDefeated = 0
    var currentUserLat = 0.0
    var currentUserLng = 0.0
    var currentUserPokemon = ""
    var currentUserIcon = ""
    var currentUserMoney = 0
    var userdata:[String:[String:Any]] = [:]
    var pokemonData:[String:[String:Any]] = [:]
    
    var annotations = [MKPointAnnotation]()
    // var pin:[MKPointAnnotation] = [MKPointAnnotation()]
    // MARK: Outlets
    @IBOutlet weak var mapView: MKMapView!
    
    // variables for getting lat and
    var lat = 0.0
    var lng = 0.0
    
    var selectedPokemon = Pokemon();
    var playerSelected = Player();
    
    @IBAction func addNewPokemonBtn(_ sender: Any) {
        //self.performSegue(withIdentifier: "segueSignUp", sender: nil)
        let URL = "https://pokeapi.co/api/v2/pokemon/";
        var URL2:String = "";
        Alamofire.request(URL, method: .get, parameters: nil).responseJSON {
            (response) in
            
            if (response.result.isSuccess) {
                print("Response from webiste: " )
                print(response.data)
                
                do {
                    let json = try JSON(data:response.data!)
                    
                    print(json["count"])
                    let x = Int.random(in: 0 ..< json["count"].intValue)
                    
                    print("Random value: \(x)")
                    var arrayP = json["results"].array!
                    print("-------------------")
                    print(arrayP[x]["name"].string!)
                    print(arrayP[x])
                    
                    URL2 = "https://pokeapi.co/api/v2/pokemon/" + arrayP[x]["name"].string! + "/";
                    print(URL2)
                    Alamofire.request(URL2, method: .get, parameters: nil).responseJSON {
                        (response2) in
                        
                        if (response2.result.isSuccess) {
                            print("Response from webiste: " )
                            print(response2.data)
                            do {
                                let json2 = try JSON(data:response2.data!)
                                //print(json2);\
                                var pName = json2["species"]["name"].string!;
                                print(json2["species"]["name"].string!);
                                print(json2["sprites"]["front_default"].string!);
                                print("--------------HP: ");
                                print(json2["stats"][5]["base_stat"]);
                                var pHp = json2["stats"][5]["base_stat"].int!
                                print("--------------Attack: ");
                                print(json2["stats"][4]["base_stat"]);
                                var pAttack = json2["stats"][4]["base_stat"].int!
                                print("--------------Defence: ");
                                print(json2["stats"][3]["base_stat"]);
                                var pDefence = json2["stats"][3]["base_stat"].int!
                                
                                var p = [String:Any]()
                                p["name"] = pName
                                p["Health Point"] = pHp
                                p["defence"] = pDefence
                                p["action"] = pAttack
                                p["level"] = Int.random(in: 1 ..< 4)
                                p["currentHealth"] = pHp
                                p["icon"] = "newPokemon"
                                
                                self.lat = 43.656
                                self.lng = -79.284
                                let x = CLLocationCoordinate2DMake(self.lat , self.lng)
                                self.image = "newPokemon"
                                print(self.image)
                                print(self.lat)
                                print(self.lng)
                                //print(pin.title)
                                print("---------")
                                let pinImageName = "newPokemon"
                                let annotation = MKPointAnnotation()
                                annotation.coordinate = x
                                annotation.title = "newPokemon"
                                self.annotations.append(annotation)
                                
                                self.pokemonData[pName] = p
                                
                                self.mapView.removeAnnotations(self.annotations)
                                self.mapView.addAnnotations(self.annotations)
                                
                            }catch {
                                print ("Error while parsing JSON response")
                            }
                        }
                    }
                }
                catch {
                    print ("Error while parsing JSON response")
                }
                
            }
            
        }
        
        
    }
    
    @IBAction func hospitalButton(_ sender: Any) {
        //to test
        //selectedPokemon.Pokemon_current_hp = selectedPokemon.Pokemon_hp! - 30;
        
        
        if playerSelected.Player_pokemon!.Pokemon_current_hp! < playerSelected.Player_pokemon!.Pokemon_hp! {
            let addHPPopUp = UIAlertController(title: "Do you want to heal you Pokemon?", message: "The hospital will charge you $50.", preferredStyle: .alert)
            addHPPopUp.addAction(UIAlertAction(title: "Heal Pokemon", style: .default, handler: {_ in self.healPokemon()}))
            addHPPopUp.addAction(UIAlertAction(title: "Later", style: .default, handler: nil))
            self.present(addHPPopUp, animated: true, completion: nil)
        }else{
            let message = "Your Pokemon is at full health."
            let infoAlert = UIAlertController(title: "Pokemon is Healthy", message: message, preferredStyle: .alert)
            infoAlert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
            self.present(infoAlert, animated: true, completion: nil)
        }
    }
    
    func healPokemon() {
       
        if playerSelected.Player_money! < 50 {
            let message = "You don't have the necessary money to health your Pokemon. Come back Later."
            let infoAlert = UIAlertController(title: "Insufficient Money!", message: message, preferredStyle: .alert)
            infoAlert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
            self.present(infoAlert, animated: true, completion: nil)
        }else{
            playerSelected.Player_pokemon!.Pokemon_current_hp! = playerSelected.Player_pokemon!.Pokemon_hp!;
            playerSelected.Player_money! = playerSelected.Player_money! - 50;
            print("Pokemon Healed")
        }
    }
    
    func gameHasFinished(){
        //TODO: change from static
        let playerWinned = true;
        let enemyPokemonLevel = 2;
        
        if playerWinned {
            //add exp to pokemon
            let expToAdd = 100*enemyPokemonLevel;
            playerSelected.Player_pokemon?.Pokemon_exp! = (playerSelected.Player_pokemon?.Pokemon_exp!)! + expToAdd;
            
            //add money to the player
            let moneyToAdd = 50*enemyPokemonLevel;
            playerSelected.Player_money! = playerSelected.Player_money! + moneyToAdd;
            
            
            //the current pokemon hp will be updated every time that he is hit
        }else{
            //subtract player's money
            let moneyToRemove = Int(Double(playerSelected.Player_pokemon?.Pokemon_exp! ?? Int(0.0))*0.6);
            playerSelected.Player_money! = playerSelected.Player_money! + moneyToRemove;
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("loaded the map screen")
        let addButton = UIBarButtonItem(title: "Logout", style: .done , target: self, action: #selector(logoutButton))
        self.navigationItem.rightBarButtonItem = addButton
        db = Firestore.firestore()
        self.image = self.row
        self.mapView.delegate = self

        let location = [
            CLLocationCoordinate2D(latitude: 43.653, longitude: -79.283),
            CLLocationCoordinate2D(latitude: 43.613, longitude: -79.483),
            CLLocationCoordinate2D(latitude: 43.663, longitude: -79.383),
            CLLocationCoordinate2D(latitude: 43.563, longitude: -79.333),
            CLLocationCoordinate2D(latitude: 43.733, longitude: -79.403)
        ]
        
        let pins = ["meon.png", "pikachu.png", "squirtle.png","zubur.png","jigglypuff.png"
        ]
        
        //var annotations = [MKPointAnnotation]()
        for (index, eachLocation) in location.enumerated() {
            let pinImageName = pins[index]
            let annotation = MKPointAnnotation()
            annotation.coordinate = eachLocation
            annotation.title = "\(pinImageName)"
            self.annotations.append(annotation)
        }
       // mapView.addAnnotations(self.annotations)

        
        let x = CLLocationCoordinate2DMake(43.6751, -79.4052)
        let y = MKCoordinateSpanMake(0.01, 0.01)
        let z = MKCoordinateRegionMake(x, y)
        self.mapView.setRegion(z, animated: true)
        db.collection("Pokemon").getDocuments() {
            (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                self.d = querySnapshot!.documents.count
                for document in querySnapshot!.documents {
                    //print("\(document.documentID) = \(document.data())")
                    self.pokemonData[document.documentID] =  document.data()
                    print(self.pokemonData[document.documentID] ?? "unknown")
                }
            }
        }
        db.collection("users").getDocuments() {
            (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                self.d = querySnapshot!.documents.count
                for document in querySnapshot!.documents {
                    //print("\(document.documentID) = \(document.data())")
                    self.userdata[document.documentID] =  document.data()
                    print(self.userdata[document.documentID] ?? "unknown")
                }
           // var annotations = [MKPointAnnotation]()
            for i in self.userdata.values {
                print(i["name"]!)
                self.status = i["status"]! as! String
                if (self.status == "online"){
                    //let pin = MKPointAnnotation()
                    self.lat = i["latitude"]! as! Double
                    self.lng = i["longitude"]! as! Double
                    let x = CLLocationCoordinate2DMake(self.lat , self.lng)
                    
    //                pin.coordinate = x
    //                pin.title = i["pokemon"]! as? String
                    self.image = self.row
                    print(self.image)
                    print(self.lat)
                    print(self.lng)
                    //print(pin.title)
                    print("---------")
                    let pinImageName = i["icon"]! as? String
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = x
                    annotation.title = i["icon"]! as? String
                    self.annotations.append(annotation)
                }
                self.mapView.addAnnotations(self.annotations)
                    //self.mapView.addAnnotation(pin)
                
                }
            }
        }
        
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        // YOUTUBE LINK: https://www.youtube.com/watch?v=FSHz5CnYSOY
        
        if !(annotation is MKPointAnnotation) {
            print("I found a pin, but it's not of type MKPointAnnotation!")
            return nil  // exit this function!
        }
        
        var annotationView = self.mapView.dequeueReusableAnnotationView(withIdentifier: "pokemonIdentifier")
        
        if (annotationView == nil) {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "pokemonIdentifier")
            annotationView!.canShowCallout = false
        }
        else {
            annotationView!.annotation = annotation
        }
        
        // pick the image for the pin
//        annotationView!.image = UIImage(named:self.row)
        if let image = annotation.title{
            annotationView!.image = UIImage(named: image ?? "pikachu.png")
        }
        // set the size of the pin - in the example below, it sets: height = 64, width = 65
        annotationView!.bounds.size.height = CGFloat(40)
        annotationView!.bounds.size.width = CGFloat(40)
        
        
        return annotationView
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func logoutButton() {
        self.status = "offline";
        userData();
        let vcontrol = storyboard?.instantiateViewController(withIdentifier: "VC")
        self.navigationController?.pushViewController(vcontrol!, animated: true)
        
        
    }
    func userData() {
        
        let query = db.collection("userPokemon")
        query.getDocuments() {
            (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    if(document.documentID == self.username){
                        self.selectedPokemon = Pokemon(pokemon_id: self.username, pokemon_name: self.currentUserPokemon, pokemon_attack: document["action"]! as! Int, pokemon_defence: document["defence"]! as! Int, pokemon_hp: document["Health Point"]! as! Int, pokemon_current_hp: document["currentHealth"]! as! Int, pokemon_level: document["level"]! as! Int, pokemon_exp: document["exp"]! as! Int, pokemon_image: self.currentUserIcon, pokemon_attacks: [])
                    }
                    
                }
            }
        }
        
        
        let ref = db.collection("users")
        ref.getDocuments() {
            (querySnapshot, err) in
            if (err == nil){
                for document in querySnapshot!.documents {
                    if(document.documentID == self.username){
//                    print("\(document.documentID) => \(document.data())")
//                    // self.pokemonData[document.documentID] =  document.data()
//                    self.currentUserLat = document["latitude"]! as! Double
//                    self.currentUserLng = document["longitude"]! as! Double
//                    self.currentUserPokemon = document["pokemon"]! as! String
//                    self.currentUserIcon = document["icon"]! as! String
//                    self.currentUserMoney = document["money"]! as! Int
//                    self.pokemonsDefeated = document["pokemonsDefeated"] as! Int
                        //let data = db.collection("users")
                        ref.document(self.username).setData([
                            "name": self.username,
                            "latitude": document["latitude"]! as! Double,
                            "longitude": document["longitude"]! as! Double,
                            "pokemon": self.pokemonName,
                            "icon": self.row,
                            "status": "offline",
                            "money" : document["money"]! as! Int,
                            "pokemonsDefeated" : document["pokemonsDefeated"]! as! Int
                            ])
                    
                    
                    self.playerSelected = Player(player_id: document.documentID, player_name: self.username, player_email: document.documentID, player_pokemon: self.selectedPokemon, player_money: document["money"]! as! Int)
                    }
                }
            }
            else if let err = err {
                print("this User is not in database")
            }
        }
        
        
    }
    // MARK: Actions
    @IBAction func zoomInPressed(_ sender: Any) {
        
        print("zoom in!")
        
        var r = mapView.region
        
        print("Current zoom: \(r.span.latitudeDelta)")
        
        r.span.latitudeDelta = r.span.latitudeDelta / 4
        r.span.longitudeDelta = r.span.longitudeDelta / 4
        print("New zoom: \(r.span.latitudeDelta)")
        print("-------")
        self.mapView.setRegion(r, animated: true)
        
        // HINT: Check MapExamples/ViewController.swift
    }
    
    @IBAction func zoomOutPressed(_ sender: Any) {
        // zoom out
        print("zoom out!")
        
        var r = mapView.region
        r.span.latitudeDelta = r.span.latitudeDelta * 2
        r.span.longitudeDelta = r.span.longitudeDelta * 2
        self.mapView.setRegion(r, animated: true)
        
        // HINT: Check MapExamples/ViewController.swift
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView)
    {
           print("User tapped on annotation with title")
        var player = Player()
        player.Player_name = uusername
        player.Player_email = uusername
        
           self.performSegue(withIdentifier: "startGameSegue", sender: nil)

        
        if let annotationTitle = view.annotation?.title
        {
            print("User tapped on annotation with title: \(annotationTitle!)")
        }
    }
    
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let n1 = segue.destination as! ScoreBoardTableViewController
        n1.userdata = userdata
    }
    
    
}

