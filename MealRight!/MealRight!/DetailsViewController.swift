//
//  DetailsViewController.swift
//  MealRight!
//
//  Created by Tommyyu on 4/22/22.
//

import UIKit
import Parse
import AlamofireImage
class DetailsViewController: UIViewController {
    var post = PFObject(className:"Recipe")
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var fav_button: UIButton!
    @IBOutlet weak var numberoflikeLabel: UILabel!
    var favorited:Bool = false
    var user = PFUser()
    var me = PFObject(className: "User")
    var fav_set = Set<String>()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
            tap.numberOfTapsRequired = 2
            view.addGestureRecognizer(tap)
        
        user = post["author"] as! PFUser
        usernameLabel.text = user.username
        titleLabel.text = post["title"] as? String
        captionLabel.text = post["caption"] as? String
//        print("#oflikes:\(post["Likes"])")
        
        numberoflikeLabel.text = ": \(String(post["Likes"] as! Int))"
        
        
        me = PFUser.current() as! PFObject
//        print("favposarray:\(me["favpostArray"])")
        if me["favpostArray"] != nil{
            fav_set = Set(me["favpostArray"] as! [String])
            favorited = fav_set.contains(post.objectId as! String)
            setFavorite(favorited)
        }
        
        
        
//        print("favorited: \(favorited)")
        
//        print(fav_set)
        let imageFile = post["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string:urlString)!
        imageView.af.setImage(withURL: url)
        
        // Do any additional setup after loading the view.
    }
    @objc func doubleTapped() {
//        setFavorite(true)
//        fav_set.insert(post["objectId"] as! String)
//        print(post.objectId)
        if favorited == false{
            post["Likes"] = post["Likes"] as! Int32+1
            post.saveEventually()
            numberoflikeLabel.text = ": \(String(post["Likes"] as! Int))"
        }
        setFavorite(true)
        me.addUniqueObjects(from: [post.objectId as! String], forKey:"favpostArray")
        me.saveInBackground()
    }
    
    func setFavorite(_ isFavorited:Bool){
        favorited = isFavorited
        if (favorited){
            fav_button.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
        }
        else{
            fav_button.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
        }
    }
    
    @IBAction func onLikeDislike(_ sender: Any) {
        if favorited == true{
            fav_set.remove(post.objectId as! String)
            post["Likes"] = post["Likes"] as! Int32-1
            post.saveEventually()
            numberoflikeLabel.text = ": \(String(post["Likes"] as! Int))"
            setFavorite(false)
            me.removeObjects(in: [post.objectId as! String], forKey:"favpostArray")
            me.saveInBackground()
        }
        else{
            doubleTapped()
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
