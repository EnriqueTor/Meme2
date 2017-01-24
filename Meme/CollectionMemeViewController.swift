////
////  CollectionMemeViewController.swift
////  Meme
////
////  Created by Enrique Torrendell on 1/16/17.
////  Copyright © 2017 Enrique Torrendell. All rights reserved.
////
//
//import UIKit
//
//class CollectionMemeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
//
//    @IBOutlet weak var collection: UICollectionView!
//    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
//    
//    var memes: [Meme] {
//        return (UIApplication.shared.delegate as! AppDelegate).memes
//    }
//    
//    let appDelegate = UIApplication.shared.delegate as! AppDelegate
//
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupView()
//        collection.reloadData()
//
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        collection.reloadData()
//        
//    }
//    
//    func setupView() {
//        
//        collection.delegate = self
//        collection.dataSource = self
//        
//        let space:CGFloat = 3.0
//        let dimension = (view.frame.size.width - (2 * space)) / 3.0
//        
//        flowLayout.minimumInteritemSpacing = space
//        flowLayout.minimumLineSpacing = space
//        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
//        
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        
//        print(memes.count)
//        
//        return memes.count
//    }
//        
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "memeCell", for: indexPath) as! MemeCellCollectionViewCell
//        
//        cell.memeImage.image = memes[indexPath.row].memedImage
//        
//        return cell
//    }
//        
//    @IBAction func addMeme(_ sender: Any) {
//        
//        performSegue(withIdentifier: "addMemeSegue", sender: self)
//        
//    }
//}
