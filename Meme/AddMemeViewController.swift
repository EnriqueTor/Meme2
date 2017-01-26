//
//  ViewController.swift
//  Meme
//
//  Created by Enrique Torrendell on 1/16/17.
//  Copyright © 2017 Enrique Torrendell. All rights reserved.
//

import UIKit
import Foundation

class AddMemeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    //MARK: - Outlets
    
    @IBOutlet weak var share: UIBarButtonItem!
    @IBOutlet weak var imageShow: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var addPhoto: UIImageView!
    @IBOutlet weak var bottomText: UITextField!
    @IBOutlet weak var toolbar: UIToolbar!
    
    //MARK: - Variables
    let applicationDelegate = (UIApplication.shared.delegate as! AppDelegate)

    
    //MARK: - Loads
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        subscribeToKeyboardNotifications()
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    //MARK: - Actions
    
    @IBAction func imageFromCamera(_ sender: Any) {
        presentPicker(withSourceType: .camera)
    }
    
    @IBAction func pickImage(_ sender: Any) {
        pickPhotoFromAlbum()
    }
    
    @IBAction func cancelMeme(_ sender: Any) {
        cleanMeme()
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func sharePressed(_ sender: Any) {
        
        let meme = generateMemedImage()
        
        let ac = UIActivityViewController(activityItems: [meme], applicationActivities: nil)
        present(ac, animated: true, completion: nil)
        
        ac.completionWithItemsHandler = { activity, completed, items, error in
            
            if completed {
                self.saveMeme()
                self.navigationController?.popViewController(animated: true)

            }
            self.cleanMeme()
        }
    }
    
    @IBAction func addPhotoFromAlbum(_ sender: Any) {
        pickPhotoFromAlbum()
    }
    
    //MARK: - Methods
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        topText.resignFirstResponder()
        bottomText.resignFirstResponder()
        return true
    }
    
    //MARK: - Functions
    
    func setupView() {
        
        share.isEnabled = false
        addPhoto.isUserInteractionEnabled = true
        
        configure(textField: topText, withText: "add text")
        configure(textField: bottomText, withText: "add text")

    }
    
    // imagePicker
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageShow.image = image
            share.isEnabled = true
            addPhoto.isHidden = true
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func pickPhotoFromAlbum() {
        presentPicker(withSourceType: .photoLibrary)
    }

    // keyboard
    
    func keyboardWillShow(_ notification:Notification) {
        if bottomText.isEditing {
            view.frame.origin.y = 0 - getKeyboardHeight(notification)
        }
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        
        return keyboardSize.cgRectValue.height
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWillHide(_ notification:Notification) {
        view.frame.origin.y = 0
    }
    
    func generateMemedImage() -> UIImage {
        
        configureBars(hidden: true)
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        configureBars(hidden: false)
        
        return memedImage
    }
    
    func saveMeme() {
        
        let memedImage = generateMemedImage()
        
        let meme = Meme(topText: topText.text!, bottomText: bottomText.text!, originalImage: imageShow.image!, memedImage: memedImage)
        
        applicationDelegate.memes.append(meme)
    }
    
    func cleanMeme() {
    
        topText.text = nil
        bottomText.text = nil
        imageShow.image = nil
        share.isEnabled = false
        addPhoto.isHidden = false
    }
    
    func presentPicker(withSourceType source: UIImagePickerControllerSourceType){
        
        let imagePicker = UIImagePickerController()
        
        imagePicker.delegate = self
        imagePicker.navigationBar.tintColor = UIColor.white
        imagePicker.sourceType = source
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func configureBars(hidden: Bool) {
        navigationController?.isNavigationBarHidden = hidden
        toolbar.isHidden = hidden
    }
    
    func configure(textField: UITextField, withText text: String) {
        
        textField.delegate = self
        textField.placeholder = text
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        
        let memeTextAttributes:[String:Any] = [
            NSForegroundColorAttributeName: UIColor.white,
            NSStrokeColorAttributeName: UIColor.black,
            NSParagraphStyleAttributeName: paragraph,
            NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName: -1]
        
        textField.defaultTextAttributes = memeTextAttributes
    }
    
}
