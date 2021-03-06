//
//  LoginViewController.swift
//  jtavassoParstagram
//
//  Created by Josh Tav on 2/18/19.
//  Copyright © 2019 JoshTav. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func signIn(_ sender: Any) {
        let username = usernameField.text!
        let password = passwordField.text!
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
            if user != nil {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {
                // print("Error: \(String(describing: error?.localizedDescription))")
                // Alert user that they inputted an incorrect username or password:
                let alert = UIAlertController(title: "Incorrect Username or Password",
                                              message: "Please Try Again",
                                              preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alert, animated: true)
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        usernameField.text = ""
        passwordField.text = ""
    }
    
    @IBAction func signUp(_ sender: Any) {
        let user = PFUser()
        user.username = usernameField.text
        user.password = passwordField.text
        
        user.signUpInBackground { (success, error) in
            if success {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {
                // print("Error: \(String(describing: error?.localizedDescription))")
                let alert = UIAlertController(title: "Error occured when signing up",
                                              message: "Please make sure you are signing up with a unique username and password",
                                              preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alert, animated: true)
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
