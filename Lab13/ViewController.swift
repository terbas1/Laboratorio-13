//
//  ViewController.swift
//  Lab13
//
//  Created by Diego Martinez Rayme on 11/14/19.
//  Copyright © 2019 Tecsup. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseDatabase
import SDWebImage

class ViewController: UIViewController, UICollectionViewDataSource {


    @IBOutlet weak var loginbutton: UIBarButtonItem!
    
    @IBOutlet weak var logoutbutton: UIBarButtonItem!
    
    @IBOutlet weak var logininfolabel: UILabel!
    
    
    @IBOutlet weak var imagencolecction: UICollectionView!
    
    var images = [CatInsta]()
    
    var customImageFlowLayout: CustomImageFlowLayout!
    
    var dbRef: DatabaseReference!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dbRef = Database.database().reference().child("images")
        loadDB()
        
        customImageFlowLayout = CustomImageFlowLayout()
        imagencolecction.collectionViewLayout = customImageFlowLayout
        imagencolecction.backgroundColor = .white
    }

    func loadDB(){
        dbRef.observe( DataEventType.value, with: { (snapshot) in
            var newImages = [CatInsta]()
            for catInstaSnapshot in snapshot.children {
                let catInstaObject = CatInsta(snapshot: catInstaSnapshot as! DataSnapshot)
                newImages.append(catInstaObject)
            }
            self.images = newImages
            self.imagencolecction.reloadData()
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if  Auth.auth().currentUser != nil {
            self.loginbutton.isEnabled = false
            self.logoutbutton.isEnabled = true
            self.logininfolabel.text = "Hello " + (Auth.auth().currentUser?.email)!
        }else{
            self.loginbutton.isEnabled = true
            self.logoutbutton.isEnabled = false
            self.logininfolabel.text = "Hello. Please Login"
        }
    }
    

    @IBAction func logoutbuttonclick(_ sender: Any) {
        
        if  Auth.auth().currentUser != nil {
            
            do{
            try Auth.auth().signOut()
                
            self.loginbutton.isEnabled = true
            self.logoutbutton.isEnabled = false
            self.logininfolabel.text = "Hello please login"
                
            }catch let signOutError as NSError{
                print("Error signin out: %@" , signOutError)
        }
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell  = imagencolecction.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ImageCollectionViewCell
        
        
        
        let image = images[indexPath.row]
        cell.imageView.sd_setImage(with: URL(string: image.url), placeholderImage: UIImage(named: "image1"))
        return cell
        
    }
}

