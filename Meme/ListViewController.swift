//
//  ListViewController.swift
//  Meme
//
//  Created by Enrique Torrendell on 1/23/17.
//  Copyright © 2017 Enrique Torrendell. All rights reserved.
//

import UIKit
import Foundation

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK: - Outlets
    
    @IBOutlet var listTableView: UITableView?
    
    //MARK: - Variables
    
    var memes: [Meme] {
        return (UIApplication.shared.delegate as! AppDelegate).memes
    }
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    //MARK: - Loads 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        listTableView?.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        listTableView?.reloadData()
        
    }
    
    func setupView() {
        print("1")
       
        
        print("===========> \(memes)")

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "memeCell", for: indexPath) as! MemeCellTableViewCell
        
        let data = memes[indexPath.row]
        
        cell.memeImage.image = data.memedImage
        cell.memeLabel.text = data.topText + data.bottomText
        
        return cell
        
    }
    
    
    
    
    
}
