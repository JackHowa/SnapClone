//
//  ViewSnapViewController.swift
//  SnapClone
//
//  Created by Jack Howard on 7/4/17.
//  Copyright © 2017 JackHowa. All rights reserved.
//

import UIKit
import SDWebImage
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage

class ViewSnapViewController: UIViewController {

    @IBOutlet weak var captionTextField: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var message = Message()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        captionTextField.text = message.descrip
        imageView.sd_setImage(with: URL(string: message.imageURL))
        // Do any additional setup after loading the view.
    }
    
    // to make message disappear
    override func viewWillDisappear(_ animated: Bool) {
        // test print statement
        print("disappearing view")
        Database.database().reference().child("users").child(Auth.auth().currentUser!.uid).child("messages").child(message.key).removeValue()
        
        // interpolate the message's uuid url of the photo here to delete that too
        Storage.storage().reference().child("images").child("\(message.uuid).jpg").delete { (error) in
            print("we deleted the picture")
        }
    }



}
