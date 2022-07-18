//
//  RecipeViewController.swift
//  MealRight!
//
//  Created by Tommyyu on 4/8/22.
//

import UIKit
import Parse
class RecipeViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var commentField: UITextView!
    
    @IBOutlet weak var titleField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        commentField.text = "Add Recipe Details"
        commentField.textColor = UIColor.lightGray

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func onLogout(_ sender: Any) {
        PFUser.logOut()
        let main = UIStoryboard(name:"Main",bundle: nil)
        let loginviewController = main.instantiateViewController(withIdentifier: "LoginViewController")
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let delegate = windowScene.delegate as? SceneDelegate else {return}
        delegate.window?.rootViewController = loginviewController
        
    }
    
    @IBAction func onSubmit(_ sender: Any) {
        
        let success_alertController = UIAlertController(title: "Upload Success", message: "Success!", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
//            print(action)
        }
        
        success_alertController.addAction(OKAction)
        
        let fail_alertController = UIAlertController(title: "Upload Fail", message: "Failed!", preferredStyle: .alert)
        let failAction = UIAlertAction(title: "OK", style: .default) { (action) in
    //            print(action)
        }
        
        fail_alertController.addAction(failAction)
        
        let post = PFObject(className: "Recipe")
        post["caption"] = commentField.text!
        post["author"] = PFUser.current()!
        post["title"] = titleField.text!
        let imageData = imageView.image!.pngData()
        let file = PFFileObject(name: "image.png",data: imageData!)
        post["image"] = file
        
        post.saveInBackground(){
            (success,error) in
            if success{
                self.present(success_alertController, animated: true) {
                }
            }
            else{
                self.present(fail_alertController, animated: true) {
                }
            }
        }
    }
    
    @IBAction func onImage(_ sender: Any) {
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
        imageView.image = scaledImage
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
