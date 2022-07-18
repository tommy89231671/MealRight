//
//  ProfileViewController.swift
//  MealRight!
//
//  Created by Tommyyu on 4/8/22.
//

import UIKit
import Parse
class ProfileViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var headphotoImageView: UIImageView!
    @IBOutlet weak var numberofpostsLabel: UILabel!
    
    @IBOutlet weak var numberoflikesLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    var posts = [PFObject]()
    let myRefreshControl = UIRefreshControl()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        load_posts()
//        print("post count: \(self.posts.count)")

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        self.myRefreshControl.addTarget(self, action: #selector(load_posts), for: .valueChanged)
//        collectionView.refreshControl = myRefreshControl
        
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        let width = (view.frame.size.width-layout.minimumInteritemSpacing*2) / 3
        layout.itemSize = CGSize(width: width, height: width * 3 / 2)
//        load_posts()
        
        
        
        let user = PFUser.current() as! PFObject
        
        let imageFile = user["photo"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string:urlString)!
        headphotoImageView.af.setImage(withURL: url)
        usernameLabel.text = user["username"] as! String
        
        
        
    }
    
    
    @objc func load_posts(){
        let query = PFQuery(className:"Recipe")
        query.whereKey("author", equalTo: PFUser.current())
        query.includeKeys(["author","caption","createdAt","title"])
        query.limit = 20
        query.findObjectsInBackground(){
            (posts,error) in
            if posts != nil{
                self.posts = posts!
                self.collectionView.reloadData()
            }
        }
        
        self.myRefreshControl.endRefreshing()
        
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipeCollectionViewCell", for: indexPath ) as! RecipeCollectionViewCell
        let post = posts[indexPath.item]
        let imageFile = post["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string:urlString)!
        cell.recipeImageView.af.setImage(withURL: url)
        
        
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int)  -> Int   {
        print("collect view count: \(self.posts.count)")
        numberofpostsLabel.text = String(self.posts.count)
        
        var numberoflikes = 0
        for a in self.posts{
            numberoflikes+=a["Likes"] as! Int
        }
        numberoflikesLabel.text = String(numberoflikes)
        
        return self.posts.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        //find the selected movie
        let cell = sender as! UICollectionViewCell
        let indexPath = collectionView.indexPath(for: cell)!
        let post = posts[indexPath.item]
        // pass the selected movie to the details view controller
        let detailsViewController = segue.destination as! DetailsViewController
        detailsViewController.post = post
//        CollectionView.deselectRow(at: indexPath, animated: true)
    }
    @IBAction func onLogout(_ sender: Any) {
        PFUser.logOut()
        let main = UIStoryboard(name:"Main",bundle: nil)
        let loginviewController = main.instantiateViewController(withIdentifier: "LoginViewController")
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let delegate = windowScene.delegate as? SceneDelegate else {return}
        delegate.window?.rootViewController = loginviewController
        
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
