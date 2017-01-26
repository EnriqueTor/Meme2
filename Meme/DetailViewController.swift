//
//  DetailViewController.swift
//  Meme
//
//  Created by Enrique Torrendell on 1/24/17.
//  Copyright © 2017 Enrique Torrendell. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var memeImage: UIImageView!
    
    var memedImage = UIImage()
    var memeTitle = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = memeTitle
        memeImage.image = memedImage
        
        navigationController?.navigationBar.tintColor = UIColor.white
    }
}
