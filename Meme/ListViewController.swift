//
//  ListViewController.swift
//  Meme
//
//  Created by Enrique Torrendell on 1/23/17.
//  Copyright © 2017 Enrique Torrendell. All rights reserved.
//

import UIKit
import Foundation

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {

    //MARK: - Variables
    
    @IBOutlet weak var navigatorMeme: UINavigationItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionImage: UIImageView!
    @IBOutlet weak var listIcon: UIImageView!
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
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
        
        print(memes)
        tableView.reloadData()
        collection.reloadData()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let applicationDelegate = (UIApplication.shared.delegate as! AppDelegate)

        memes = applicationDelegate.memes
        
        tableView.reloadData()
        collection.reloadData()

    }
    
    // MARK: - Functions
    
    func setupView() {

        tableView.delegate = self
        tableView.dataSource = self
        collectionImage.isUserInteractionEnabled = true
        
        collection.delegate = self
        collection.dataSource = self
        
        collection.isHidden = true
        collectionImage.isUserInteractionEnabled = true
        listIcon.isUserInteractionEnabled = true
        
        let space:CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)

    }
    
    func showMeme(list: Bool, collection: Bool, title: String) {
        
        tableView.isHidden = !list
        collection.isHidden = !collection
        
        navigatorMeme.title = title
        
    }
    
    @IBAction func showList(_ sender: Any) {
        
        showMeme(list: true, collection: false, title: "Memes List")
        
    }
    
    @IBAction func shoCollection(_ sender: Any) {
        
        showMeme(list: false, collection: true, title: "Memes Collection")
        
    }

    
    //MARK: - Methods TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print(memes.count)
        return memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "memeCell", for: indexPath) as! MemeCellTableViewCell
        
        let data = memes[indexPath.row]
        
        cell.memeImage.image = data.memedImage
        
        print("this is the memed imaged \(data.memedImage)")
        
        cell.memeLabel.text = data.topText + " " + data.bottomText
        
        print("this is the text \(data.topText + data.bottomText)")
        
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
  
    //MARK: - Methods CollectionView
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return memes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "memeCell", for: indexPath) as! MemeCollectionViewCell
        
        cell.collectionImage.image = memes[indexPath.row].memedImage
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "detailSegue" {
        
            let dest = segue.destination as! DetailViewController
            
            dest.memedImage = selectedMemeImage
            dest.memeTitle = selectedMemeTitle
            
        }
    }
    
}
