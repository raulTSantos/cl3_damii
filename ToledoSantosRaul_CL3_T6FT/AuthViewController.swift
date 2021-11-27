//
//  ViewController.swift
//  ToledoSantosRaul_CL3_T6FT
//
//  Created by RaulMacOS on 11/25/21.
//  Copyright © 2021 RaulMacOS. All rights reserved.
//

import UIKit
import Firebase
//import FacebookLogin
class AuthViewController: UIViewController {

    
    @IBOutlet weak var txtFullName: UITextField!
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var txtConfirmPassword: UITextField!
    
    @IBOutlet weak var facebookBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // Analytics.logEvent("InitScreen", parameters: ["mensaje": "Integracion de firebase completa"])
    }

    
    @IBAction func btnLoginAction(_ sender: Any) {
        if txtEmail.text?.isEmpty == true {
            print("Ingrese email")
            let alert = UIAlertController ( title: "Error", message: "Ingrese un correo valido", preferredStyle: .alert)
            alert.addAction(UIAlertAction (title: "Aceptar", style: .default))
            self.present(alert, animated: true, completion: nil)
            return
        }
        if txtPassword.text?.isEmpty == true {
            print("Ingrese un password ")
            let alert = UIAlertController ( title: "Error", message: "Ingrese un password", preferredStyle: .alert)
            alert.addAction(UIAlertAction (title: "Aceptar", style: .default))
            self.present(alert, animated: true, completion: nil)
            return
        }
        login();
    }
    
    @IBAction func facebookAuthAction(_ sender: Any) {
        /*let loginManager = LoginManager()
        loginManager.logOut()
        loginManager.logIn(permissions: [.email], viewController: self) { (result) in
            switch result {
                
                
            case .success(let granted, let declined, let token):
                
                let credential = FacebookAuthProvider.credential(withAccessToken: token.tokenString)
                
                Auth.auth().signIn(with: credential) { (result, error) in
                    self.showHome(result: result, error: error, provider: .facebook)
                }
                
                
            case .cancelled:
                break
            case .failed(_):
                break
            }
        }*/
    }
    
    
    @IBAction func btnSingUpAction(_ sender: Any) {
        if txtFullName.text?.isEmpty == true {
            print("Ingrese un su nombre")
            let alert = UIAlertController ( title: "Campo Vacio", message: "Ingrese un nombre", preferredStyle: .alert)
            alert.addAction(UIAlertAction (title: "Aceptar", style: .default))
            self.present(alert, animated: true, completion: nil)
            return
        }
        if txtEmail.text?.isEmpty == true {
            print("Ingrese email")
            let alert = UIAlertController ( title: "Error", message: "Ingrese un correo valido", preferredStyle: .alert)
            alert.addAction(UIAlertAction (title: "Aceptar", style: .default))
            self.present(alert, animated: true, completion: nil)
            return
        }
        if txtPassword.text?.isEmpty == true || (txtPassword.text?.characters.count)! <= 8{
            let alert = UIAlertController ( title: "Error", message: "Ingrese un password de minimo 8 caracteres", preferredStyle: .alert)
            alert.addAction(UIAlertAction (title: "Aceptar", style: .default))
            self.present(alert, animated: true, completion: nil)
            return
        }
        if (txtConfirmPassword.text != txtPassword.text ) {
            let alert = UIAlertController ( title: "Error", message: "Contraseña no coincide", preferredStyle: .alert)
            alert.addAction(UIAlertAction (title: "Aceptar", style: .default))
            self.present(alert, animated: true, completion: nil)
            return
        }
        signUp();
    }
    
    
    
    /* metodos */
    func signUp(){
        
        Auth.auth().createUser(withEmail: txtEmail.text!, password: txtPassword.text!) {(authResult ,error) in
            if let result = authResult  , error == nil {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let viewc = storyboard.instantiateViewController(withIdentifier: "homeController")
                viewc.modalPresentationStyle = .overFullScreen
                self.present(viewc, animated: true)
            }else{
                let alert = UIAlertController ( title: "Error", message: "Se ha producido un Error", preferredStyle: .alert)
                alert.addAction(UIAlertAction (title: "Aceptar", style: .default))
            }
        }
        
    }
    
    
    func login(){
        Auth.auth().signIn(withEmail: txtEmail.text!, password: txtPassword.text!){
            (result ,error) in
            if let result = result , error == nil {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let viewc = storyboard.instantiateViewController(withIdentifier: "homeController")
                viewc.modalPresentationStyle = .overFullScreen
                self.present(viewc, animated: true)
            }else{
                let alert = UIAlertController ( title: "Error", message: "Se ha producido un Error", preferredStyle: .alert)
                alert.addAction(UIAlertAction (title: "Aceptar", style: .default))
                self.present(alert, animated: true, completion: nil)
                }

            }
        
    /*if txtEmail.text=="raul" && txtPassword.text=="123"{
     let storyboard = UIStoryboard(name: "Main", bundle: nil)
     let viewc = storyboard.instantiateViewController(withIdentifier: "homeController")
     navigationController?.pushViewController(viewc, animated: true)
        }*/
    }
    
}

