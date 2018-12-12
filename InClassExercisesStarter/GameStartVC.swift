//
//  GameStartVC.swift
//  InClassExercisesStarter
//
//  Copyright © 2018 room1. All rights reserved.
//

import UIKit

class GameStartVC: UIViewController {
    var attack1Count = 0
    var attack2Count = 0
    var attack3Count = 0
    var attack4Count = 0
    


    @IBAction func attack1(_ sender: Any) {
        
        if(attack1Count>=1)
        {
        let message = "You already used this attack."
        let infoAlert = UIAlertController(title: "Attack Failed!", message: message, preferredStyle: .alert)
        infoAlert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
        self.present(infoAlert, animated: true, completion: nil)
        }
        
        else{
            print("attack1")
            attack1Count = attack1Count+1;
        }

    }
    @IBAction func attack2(_ sender: Any) {
        
        if(attack2Count>=1)
        {
            let message = "You already used this attack."
            let infoAlert = UIAlertController(title: "Attack Failed!", message: message, preferredStyle: .alert)
            infoAlert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
            self.present(infoAlert, animated: true, completion: nil)
        }
            
        else{
            print("attack2")
            attack2Count = attack2Count+1;
        }

    }
    @IBAction func attack3(_ sender: Any) {
        print("attack 3")
        if(attack3Count>=1)
        {
            let message = "You already used this attack."
            let infoAlert = UIAlertController(title: "Attack Failed!", message: message, preferredStyle: .alert)
            infoAlert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
            self.present(infoAlert, animated: true, completion: nil)
        }
            
        else{
            print("attack3")
            attack3Count = attack3Count+1;
        }

    }
    @IBAction func attack4(_ sender: Any) {
        print("attack 4")
        if(attack4Count>=1)
        {
            let message = "You already used this attack."
            let infoAlert = UIAlertController(title: "Attack Failed!", message: message, preferredStyle: .alert)
            infoAlert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
            self.present(infoAlert, animated: true, completion: nil)
        }
            
        else{
            print("attack4")
            attack4Count = attack4Count+1;
        }

    }
    
    @IBOutlet weak var usernameLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let addButton = UIBarButtonItem(title: "Score Board", style: .done , target: self, action: #selector(scoreButton))
        self.navigationItem.rightBarButtonItem = addButton
        let uusername = UserDefaults.standard.string(forKey: "username") ?? ""
        
        usernameLbl.text = uusername

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @objc func scoreButton()  {
        let vcontrol = storyboard?.instantiateViewController(withIdentifier: "TVC")
        self.navigationController?.pushViewController(vcontrol!, animated: true)
        
        
    }

}
