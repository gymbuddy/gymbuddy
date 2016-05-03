
import UIKit

class SwipingViewController: UIViewController {

    
    @IBOutlet var userImage: UIImageView!
    
    @IBOutlet var infoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var query = PFUser.query()
        
        var interestedIn = "beginner"
        
        if PFUser.currentUser()!["interestedInIntermediate"]! as! Bool == true {
            
            interestedIn = "intermediate"
            
        }
        
        var isExperienced = true
        
        //if PFUser.currentUser()!["experience"]! as! String == "beginner" {
            //isExperienced = false
        //}
        
        query!.whereKey("experience", equalTo:interestedIn)
        query!.whereKey("interestedInIntermediate", equalTo: isExperienced)
        query!.limit = 1
        
        query!.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error != nil {
                
                print(error)
                
            } else if let objects = objects as [PFObject]! {
                
                for object in objects {
                    
                    let imageFile = object ["image"] as! PFFile
                    
                    imageFile.getDataInBackgroundWithBlock {
                        (imageData: NSData?, error: NSError?) -> Void in
                        
                        if error != nil {
                            
                            print(error)
                            
                        } else {
                            
                            if let data = imageData {
                                
                                self.userImage.image = UIImage(data: data)
                                
                            }
                            
                        }
                    }
                    
                }
                
            }
        }

    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "logOut" {
            PFUser.logOut()
            
        }
    }
}
