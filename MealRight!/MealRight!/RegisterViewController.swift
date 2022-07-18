//
//  RegisterViewController.swift
//  MealRight!
//
//  Created by Tommyyu on 4/22/22.
//

import UIKit
import AlamofireImage
import Parse
class RegisterViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    @IBOutlet weak var confirmpasswordField: UITextField!
    @IBOutlet weak var birthDatePicker: UIDatePicker!
    
    @IBOutlet weak var photoImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancel_button(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func onConfirm_button(_ sender: Any) {
        let user = PFUser()
        user.username = usernameField.text
        user.password = passwordField.text
        
        let confirm_password = confirmpasswordField.text
        
        
        user["birth_date"] = birthDatePicker.date
        user["favpostArray"] = []
        let imageData = photoImageView.image!.pngData()
        let file = PFFileObject(name: "image.png",data: imageData!)
        
        user["photo"] = file
        let alertController = UIAlertController(title: "Mismatch Password", message: "mismatch password", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
//            self.dismiss(animated: false, completion: nil)
        }
        
        alertController.addAction(OKAction)
//        print("print password")
//        print(confirm_password)
//        print(user.password)
        if (confirm_password == user.password){
            user.signUpInBackground{ (success,error ) in
                if success{
                    self.performSegue(withIdentifier: "backtologinSegue", sender: nil)
                }
                else{
                    print("Error: \(error?.localizedDescription)")
                }
            }
        }
        else{
            present(alertController, animated: true) {
            }
        }
        
       
    }
    
    @IBAction func uploadphoto_button(_ sender: Any){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .camera
        }
        else{
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af.imageAspectScaled(toFill: size)
        photoImageView.image = scaledImage
        dismiss(animated: true, completion: nil)
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
