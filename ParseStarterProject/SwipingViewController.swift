
import UIKit

class SwipingViewController: UIViewController {

    
    @IBOutlet var userImage: UIImageView!
    
    @IBOutlet var infoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
