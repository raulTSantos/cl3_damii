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
class HomeViewController: UIViewController {

    
    @IBOutlet weak var txtIdPersona: UITextField!
    
    @IBOutlet weak var txtNombrePersona: UITextField!
    
    private let  db = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func addPersonAction(_ sender: Any) {
        let  ids = txtIdPersona.text
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
    
    
    @IBAction func retrievePersonAction(_ sender: Any) {
         let  ids = txtIdPersona.text
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
    
    @IBAction func updatePersonAction(_ sender: Any) {
        let  ids = txtIdPersona.text
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
    
    @IBAction func deletePersonAction(_ sender: Any) {
        let  ids = txtIdPersona.text
        db.collection("users").document(ids ?? "").delete()
        let alert = UIAlertController ( title: "Informacion", message: "Eliminado Exitosamente", preferredStyle: .alert)
        alert.addAction(UIAlertAction (title: "Aceptar", style: .default))
        self.present(alert, animated: true, completion: nil)
        self.txtIdPersona.text = ""
        self.txtNombrePersona.text = ""
    }
    
    
    
    
    
    @IBAction func btnLogOutAction(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewc = storyboard.instantiateViewController(withIdentifier: "login")
            viewc.modalPresentationStyle = .overFullScreen
            self.present(viewc, animated: true)
            //navigationController?.popViewController(animated: true)
        } catch  {
            
        }
    }
    
}
