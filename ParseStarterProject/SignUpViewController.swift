
import UIKit
import Parse

class SignUpViewController: UIViewController {
    
    @IBAction func signUp(sender: AnyObject) {
        
        PFUser.currentUser()?["interestedInIntermediate"] = interestedInIntermediate.on
        try! PFUser.currentUser()?.save()
    }

    @IBOutlet var userImage: UIImageView!
    
    
    @IBOutlet var interestedInIntermediate: UISwitch!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let graphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, gender, email"])
        graphRequest.startWithCompletionHandler { (connection, results, error) -> Void in
            
            if error != nil {
                print(error)
            } else if let result = results {
                PFUser.currentUser()?["gender"] = result["gender"]!
                PFUser.currentUser()?["name"] = result["name"]!
                PFUser.currentUser()?["email"] = result["email"]!
                
                let userId = result["id"]! as! String
                let facebookProfilePictureUrl = "https://graph.facebook.com/" + userId + "/picture?type=large"
                
                if let fbpicUrl = NSURL(string: facebookProfilePictureUrl),
                    data = NSData(contentsOfURL: fbpicUrl) {
                    self.userImage.image = UIImage(data: data)
                    let imageFile:PFFile = PFFile(data: data)!
                    PFUser.currentUser()?["image"] = imageFile
                    do {
                        try PFUser.currentUser()?.save()
                    } catch let ex {
                        print(ex)
                    }
                }
            }
        }

        }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
