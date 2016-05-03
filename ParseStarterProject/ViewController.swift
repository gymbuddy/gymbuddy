
import UIKit
import Parse
import FBSDKCoreKit
import ParseFacebookUtilsV4
import FBSDKLoginKit

class ViewController: UIViewController {

    @IBAction func fbLogin(sender: AnyObject) {
    
        let permissions = ["public_profile", "email"]
        
        PFFacebookUtils.logInInBackgroundWithReadPermissions(permissions, block: {
            
            (user: PFUser?, error: NSError?) -> Void in
            
            if let error = error {
                print(error)
            } else {
                if let user = user {
                    if let interestedInIntermediate = user["interestedInIntermediate"] {
                        self.performSegueWithIdentifier("logUserIn", sender: self)
                    } else {
                        self.performSegueWithIdentifier("showSigninScreen", sender: self)
                    }
                }
            }
        })
    }
    
    override func viewDidAppear(animated: Bool) {
        if let username = PFUser.currentUser()?.username {
            if let interestedInIntermediate = PFUser.currentUser()?["interestedInIntermediate"] {
                self.performSegueWithIdentifier("logUserIn", sender: self)
            } else {
                self.performSegueWithIdentifier("showSigninScreen", sender: self)
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

