import UIKit
import Parse
import FBSDKCoreKit
import ParseFacebookUtilsV4
import FBSDKLoginKit

class ViewController: UIViewController {

    @IBAction func fbLogin(sender: AnyObject) {
    
        let permissions = ["public_profile", "email"]
        
        PFFacebookUtils.logInInBackgroundWithReadPermissions(permissions, block: { (user: PFUser?, error: NSError?) -> Void in
            
            if let user = user {
                if user.isNew {
                    print("User signed up and logged in through Facebook!")
                } else {
                    print("User logged in through Facebook!")
                    if let username = PFUser.currentUser()?.username {
                        self.performSegueWithIdentifier("showSignInScreen", sender: self)
                    }
                }
            } else {
                print("Uh oh. The user cancelled the Facebook login.")
            }
        })
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        if let username = PFUser.currentUser()?.username {
            performSegueWithIdentifier("showSignInScreen", sender: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
