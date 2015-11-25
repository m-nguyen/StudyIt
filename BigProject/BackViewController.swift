//
//  BackViewController.swift
//  StudyIt
//
//  Created by Isabel Laurenceau on 10/23/15.
//  Copyright © 2015 Isabel Laurenceau. All rights reserved.
//

import UIKit
import Parse

class BackViewController: UIViewController {
    
    @IBOutlet var backText: UITextView!
    var selected: String!
    //var cardID: String!
    var setName: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(selected)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func Save(sender: AnyObject) {
        //get objectID
        let query = PFQuery(className:"CardInfo")
        query.getObjectInBackgroundWithId(ID) {
            (object, error) -> Void in
            if error != nil {
                print(error)
            } else {
                if let object = object {
                    print("found")
                    object["backstring"] = self.backText.text
                    object["username"] = (PFUser.currentUser()?.username)!
                    object.saveInBackground()
                }
            }
        }
        print("Saving Back")
//        performSegueWithIdentifier("toIndividualCards", sender: nil)
        performSegueWithIdentifier("BackToCard", sender: nil)
        
    }
    
    //segue set name
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toIndividualCards"   {
            
            let fvc = segue.destinationViewController as! cardTableViewController
            fvc.selectedSet = setName
        }
        else if segue.identifier == "BackToCard"   {
            
            let fvc = segue.destinationViewController as! SetToCardViewController
            fvc.setName = setName
        }
        
    }
    //********************************************************************************************************************//
    @IBOutlet var Image: UIImageView!
    var picker = UIImagePickerController()
    
    @IBAction func upload(sender: AnyObject) {
        picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        picker.allowsEditing = true
        self.presentViewController(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        //set selectedIMage to image that we picked.
        Image.image = image
        //get rid of picker
        self.dismissViewControllerAnimated(true, completion: nil)
        
        
        if picker.sourceType == UIImagePickerControllerSourceType.Camera{
            //save photos in app
            //doing image:didFinishSavingWithError means sending to function image with parameter didFinishSavingWithError
            UIImageWriteToSavedPhotosAlbum(image, self, "image:didFinishSavingWithError", nil)
        }
    }
    
    //save image to photo album
    //will let us know if there was error whil saving
    //will than display message
    func image(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafePointer<Void>){
        if error == nil{
            let alertSuccess = UIAlertController(title: "SUCESSSSSSSS!", message: "Because it would suck otherwise", preferredStyle: .Alert)
            
            let alertAction = UIAlertAction(title: "Yes!", style: .Default, handler: nil)
            alertSuccess.addAction(alertAction)
            presentViewController(alertSuccess, animated: true, completion: nil)
        }
        else{
            let alertSuccess = UIAlertController(title: "FAILLLL!", message: "Boooooo", preferredStyle: .Alert)
            
            let alertAction = UIAlertAction(title: ":(!", style: .Cancel, handler: nil)
            alertSuccess.addAction(alertAction)
            presentViewController(alertSuccess, animated: true, completion: nil)
            
        }
    }
    
    @IBAction func AddPhoto(sender: AnyObject) {
        
        let alertControl: UIAlertController = UIAlertController(title: "Upload Photo", message: "Upload photo from Camera or Gallery", preferredStyle: .Alert)
        let Camera = UIAlertAction(title: "Take Photo", style: .Default) {action  in self.PickFromCamera()}
        alertControl.addAction(Camera)
        
        let Gallery = UIAlertAction(title: "Choose from Gallery", style: .Default) {action  in self.PickFromGallery()}
        alertControl.addAction(Gallery)
        
        self.presentViewController(alertControl, animated: true, completion: nil)
    }
    
    
    func PickFromGallery() {
        picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        picker.allowsEditing = true
        self.presentViewController(picker, animated: true, completion: nil)
        
    }
    
    func PickFromCamera() {
        picker.sourceType = UIImagePickerControllerSourceType.Camera
        picker.allowsEditing = true
        self.presentViewController(picker, animated: true, completion: nil)
        
    }
    
    
    
}
