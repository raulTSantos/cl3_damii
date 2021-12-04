//
//  HomeViewController.swift
//  ToledoSantosRaul_CL3_T6FT
//
//  Created by RaulMacOS on 11/25/21.
//  Copyright © 2021 RaulMacOS. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
//import FacebookLogin
class HomeViewController: UIViewController {

    
    @IBOutlet weak var txtIdPersona: UITextField!
    @IBOutlet weak var txtNombrePersona: UITextField!
    @IBOutlet weak var lblUser: UILabel!
    
    
    private let  db = Firestore.firestore()
     var email = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setHidesBackButton(true, animated: false)
        lblUser.text = email
        let defaults = UserDefaults.standard
        defaults.set(email, forKey: "email")
        defaults.synchronize()
    }
    
    
    @IBAction func addPersonAction(_ sender: Any) {
        let  ids = txtIdPersona.text
        if ids?.isEmpty == true{
            let alert = UIAlertController ( title: "Informacion", message: "Ingrese un ID", preferredStyle: .alert)
            alert.addAction(UIAlertAction (title: "Aceptar", style: .default))
            self.present(alert, animated: true, completion: nil)
        }else{
            db.collection("users").document(ids ?? "").setData([
                "idPersona":txtIdPersona.text ?? "",
                "nombrePersona":txtNombrePersona.text ?? ""
                ])
            let alert = UIAlertController ( title: "Informacion", message: "Registro Exitoso", preferredStyle: .alert)
            alert.addAction(UIAlertAction (title: "Aceptar", style: .default))
            self.present(alert, animated: true, completion: nil)
            self.txtIdPersona.text = ""
            self.txtNombrePersona.text = ""
        }
        
    }
    
    
    @IBAction func retrievePersonAction(_ sender: Any) {
        let  ids = txtIdPersona.text
        if ids?.isEmpty == true{
            let alert = UIAlertController ( title: "Informacion", message: "Ingrese un ID", preferredStyle: .alert)
            alert.addAction(UIAlertAction (title: "Aceptar", style: .default))
            self.present(alert, animated: true, completion: nil)
        }else{
            db.collection("users").document(ids ?? "").getDocument { (documentSnapshot, error) in
                if let document = documentSnapshot, error == nil{
                    if let idPerson = document.get("idPersona") as? String{
                        self.txtIdPersona.text = idPerson
                    }
                    if let nombrePerson = document.get("nombrePersona") as? String{
                        self.txtNombrePersona.text = nombrePerson
                    }
                }else{
                    self.txtIdPersona.text = ""
                    self.txtNombrePersona.text = ""
                }
            }
        }
    }
    
    @IBAction func updatePersonAction(_ sender: Any) {
        let  ids = txtIdPersona.text
        if ids?.isEmpty == true{
            let alert = UIAlertController ( title: "Informacion", message: "Ingrese un ID", preferredStyle: .alert)
            alert.addAction(UIAlertAction (title: "Aceptar", style: .default))
            self.present(alert, animated: true, completion: nil)
        }else{
            db.collection("users").document(ids ?? "").setData([
                "idPersona":txtIdPersona.text ?? "",
                "nombrePersona":txtNombrePersona.text ?? ""
                ])
            let alert = UIAlertController ( title: "Informacion", message: "Registro Exitoso", preferredStyle: .alert)
            alert.addAction(UIAlertAction (title: "Aceptar", style: .default))
            self.present(alert, animated: true, completion: nil)
            self.txtIdPersona.text = ""
            self.txtNombrePersona.text = ""
        }
    }
    
    @IBAction func deletePersonAction(_ sender: Any) {
        let  ids = txtIdPersona.text
        if ids?.isEmpty == true{
            let alert = UIAlertController ( title: "Informacion", message: "Ingrese un ID", preferredStyle: .alert)
            alert.addAction(UIAlertAction (title: "Aceptar", style: .default))
            self.present(alert, animated: true, completion: nil)
        }else{
            db.collection("users").document(ids ?? "").delete()
            let alert = UIAlertController ( title: "Informacion", message: "Eliminado Exitosamente", preferredStyle: .alert)
            alert.addAction(UIAlertAction (title: "Aceptar", style: .default))
            self.present(alert, animated: true, completion: nil)
            self.txtIdPersona.text = ""
            self.txtNombrePersona.text = ""
        }
    }
    
    
    
    
    
    @IBAction func btnLogOutAction(_ sender: Any) {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "email")
        defaults.synchronize()
        do {
            try Auth.auth().signOut()
            navigationController?.popViewController(animated: true)
        } catch  {
            
        }
    }
    
}
