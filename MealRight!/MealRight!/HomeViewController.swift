//
//  HomeViewController.swift
//  MealRight!
//
//  Created by Tommyyu on 4/8/22.
//

import UIKit
import Parse
class HomeViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var posts = [PFObject]()
    
   
    let myRefreshControl = UIRefreshControl()
    
    @IBOutlet weak var HomeTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        HomeTableView.delegate = self
        HomeTableView.dataSource = self
        self.myRefreshControl.addTarget(self, action: #selector(load_posts), for: .valueChanged)
        HomeTableView.refreshControl = myRefreshControl
        // Do any additional setup after loading the view.
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        load_posts()
        print("post count: \(self.posts.count)")

    }
    @IBAction func onLogout(_ sender: Any) {
        PFUser.logOut()
        let main = UIStoryboard(name:"Main",bundle: nil)
        let loginviewController = main.instantiateViewController(withIdentifier: "LoginViewController")
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let delegate = windowScene.delegate as? SceneDelegate else {return}
        delegate.window?.rootViewController = loginviewController
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeFeedCell", for: indexPath) as! HomeFeedCell

        
        let user = post["author"] as! PFUser
        cell.UsernameLabel.text = user.username
        cell.TitleLabel.text = post["title"] as? String
        
        let imageFile = post["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string:urlString)!
        cell.feedimage.af.setImage(withURL: url)
        return cell
        

    }
    @objc func load_posts(){
        let query = PFQuery(className:"Recipe")
        query.whereKey("author", notEqualTo: PFUser.current())
        query.includeKeys(["author","caption","createdAt","title","Likes"])
        query.limit = 20
        query.findObjectsInBackground(){
            (posts,error) in
            if posts != nil{
                self.posts = posts!
                self.HomeTableView.reloadData()
            }
        }
        
        self.myRefreshControl.endRefreshing()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let post = posts[indexPath.row]
////        let comments = (post["comments"] as? [PFObject]) ?? []
//
//        if indexPath.row == comments.count+1{
//            showsCommentBar = true
//            becomeFirstResponder()
//            commentBar.inputTextView.becomeFirstResponder()
//            selectedPost = post
//        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        //find the selected movie
        let cell = sender as! UITableViewCell
        let indexPath = HomeTableView.indexPath(for: cell)!
        let post = posts[indexPath.row]
        // pass the selected movie to the details view controller
        let detailsViewController = segue.destination as! DetailsViewController
        detailsViewController.post = post
        HomeTableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 320.0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        let post = posts[section]
//        print("at count\(posts.count)")
        return posts.count
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
