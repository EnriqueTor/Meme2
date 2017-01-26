//
//  CollectionMemeViewController.swift
//  Meme
//
//  Created by Enrique Torrendell on 1/16/17.
//  Copyright © 2017 Enrique Torrendell. All rights reserved.
//

import UIKit

class CollectionMemeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    //MARK: - Outlets
    
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    //MARK: - Variables
    
    var memes: [Meme]!
    var selectedMemeImage = UIImage()
    var selectedMemeTitle = String()

    //MARK: - Loads
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes

        setupView()
        collection.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collection.reloadData()
    }
    
    //MARK: - Actions
    
    @IBAction func addMeme(_ sender: Any) {
        
        performSegue(withIdentifier: "addSegue", sender: self)
    }
    
    //MARK: - Functions
    
    func setupView() {
                
        let space:CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
        
        tabBarController?.tabBar.isHidden = false
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return memes.count
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "memeCell", for: indexPath) as! MemeCollectionViewCell
        
        cell.memeImage.image = memes[indexPath.row].memedImage
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
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
