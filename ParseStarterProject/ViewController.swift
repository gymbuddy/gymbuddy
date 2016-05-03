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
        
        
//        let label = UILabel(frame: CGRectMake(self.view.bounds.width / 2 - 100, self.view.bounds.height / 2 - 50, 200, 100))
//        label.text = "Drag me!"
//        label.textAlignment = NSTextAlignment.Center
//        self.view.addSubview(label)
//        
//        let gesture = UIPanGestureRecognizer(target: self, action: Selector("wasDragged:"))
//        label.addGestureRecognizer(gesture)
//        
//        label.userInteractionEnabled = true
        
    }
    
//    func wasDragged(gesture: UIPanGestureRecognizer) {
//        
//        let translation = gesture.translationInView(self.view)
//        let label = gesture.view!
//        
//        label.center = CGPoint(x: self.view.bounds.width / 2 + translation.x, y: self.view.bounds.height / 2 + translation.y)
//
//        let xFromCenter = label.center.x - self.view.bounds.width / 2
//        
//        let scale = min(100 / abs(xFromCenter), 1)
//        
//        var rotation = CGAffineTransformMakeRotation(xFromCenter / 200)
//        
//        var stretch = CGAffineTransformScale(rotation, scale, scale)
//        
//        label.transform = stretch
//        
//        
//        
//        if gesture.state == UIGestureRecognizerState.Ended {
//            
//            if label.center.x < 100 {
//                
//                print("nope")
//                
//            } else if label.center.x > self.view.bounds.width - 100 {
//                
//                print("deep inside")
//                
//            }
//            
//            rotation = CGAffineTransformMakeRotation(0)
//            
//            stretch = CGAffineTransformScale(rotation, 1, 1)
//            
//            label.transform = stretch
//            
//            label.center = CGPoint(x: self.view.bounds.width / 2, y: self.view.bounds.height / 2)
//            
//        }
//        
//        
//    }
    
    override func viewDidAppear(animated: Bool) {

        //PFUser.logOut()
        
        
        if let username = PFUser.currentUser()?.username {
            performSegueWithIdentifier("showSignInScreen", sender: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
