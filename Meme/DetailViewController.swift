//
//  DetailViewController.swift
//  Meme
//
//  Created by Enrique Torrendell on 1/25/17.
//  Copyright © 2017 Enrique Torrendell. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var memeImage: UIImageView!
    
    var memedImage = UIImage()
    var memeTitle = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarController?.tabBar.isHidden = true
        
        navigationItem.title = memeTitle
        memeImage.image = memedImage
        
        navigationController?.navigationBar.tintColor = UIColor.white
        
        let backButton = UIBarButtonItem(title: "< Home", style: UIBarButtonItemStyle.plain, target: self, action: #selector(DetailViewController.goBack))
        
        navigationItem.leftBarButtonItem = backButton

    }

    func goBack() {
        
        tabBarController?.tabBar.isHidden = false
        
        navigationController?.popViewController(animated: true)
        
    }
}
