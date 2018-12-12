//
//  LoginViewController.swift
//  InClassExercisesStarter
//
//  Created by admin on 11/27/18.
//  Copyright © 2018 room1. All rights reserved.
//

import UIKit
import FirebaseFirestore
import Firebase

class LoginViewController: UIViewController {
    var name = ""
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButton(_ sender: Any) {
        print("Pressed login button")
        let email = emailTextField.text!
        let password = passwordTextField.text!
        Auth.auth().signIn(withEmail: email, password: password) {
            
            (user, error) in
            
            if (user != nil) {
                print("User signed in! ")
                print("User id: \(user?.user.uid)")
                self.name = user?.user.email ?? "unknown"
                print("Email: \(user?.user.email)")
                UserDefaults.standard.set((user?.user.email), forKey: "username")
                self.performSegue(withIdentifier: "segueHome", sender: nil)
                
                
            }
            else {
                print("ERROR!")
                print(error?.localizedDescription)
                self.errorLabel.text = error?.localizedDescription
            }
        }
    }
    @IBAction func signUpButton(_ sender: Any) {
        self.performSegue(withIdentifier: "segueSignUp", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueHome" {
            let n1 = segue.destination as! HomeTableViewController
            n1.username = name
            print("name has ben sent to next screen")
        }
    }
  

}
