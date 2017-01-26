//
//  ListViewController.swift
//  Meme
//
//  Created by Enrique Torrendell on 1/25/17.
//  Copyright © 2017 Enrique Torrendell. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Variables
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Variables
    
    var memes: [Meme]!
    var selectedMemeImage = UIImage()
    var selectedMemeTitle = String()
    
    //MARK: - Loads
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        let applicationDelegate = (UIApplication.shared.delegate as! AppDelegate)
        memes = applicationDelegate.memes
        
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let applicationDelegate = (UIApplication.shared.delegate as! AppDelegate)
        
        memes = applicationDelegate.memes
        
        tableView.reloadData()
    }
    
    //MARK: - Actions
    
    @IBAction func addMeme(_ sender: Any) {
        
        performSegue(withIdentifier: "addSegue", sender: self)
        
    }
    
    // MARK: - Functions
    
    func setupView() {
        
        tabBarController?.tabBar.isHidden = false
        
    }
    
    //MARK: - Methods TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "memeCell", for: indexPath) as! MemeTableViewCell
        
        let data = memes[indexPath.row]
        
        cell.memeImage.image = data.memedImage
        
        cell.memeLabel.text = data.topText + " " + data.bottomText
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            (UIApplication.shared.delegate as! AppDelegate).memes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedMeme = memes[indexPath.row]
        
        selectedMemeTitle = selectedMeme.topText + " " + selectedMeme.bottomText
        selectedMemeImage = selectedMeme.memedImage
        
        performSegue(withIdentifier: "detailSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "detailSegue" {
            
            let dest = segue.destination as! DetailViewController
            
            dest.memedImage = selectedMemeImage
            dest.memeTitle = selectedMemeTitle
        }
    }

    
}
