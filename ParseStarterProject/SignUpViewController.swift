
import UIKit
import Parse

class SignUpViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBAction func signUp(sender: AnyObject) {
        
        PFUser.currentUser()?["interestedInIntermediate"] = interestedInIntermediate.on
        try! PFUser.currentUser()?.save()
    }

    @IBOutlet var userImage: UIImageView!
    
    @IBOutlet var interestedInIntermediate: UISwitch!
    
    @IBOutlet var pickerTextField: UITextField!

    var pickOption = ["Beginner", "Intermediate"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pickerView = UIPickerView()
        
        pickerView.delegate = self
        
        pickerTextField.inputView = pickerView
        
        
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
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickOption.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickOption[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerTextField.text = pickOption[row]
        PFUser.currentUser()?["experience"] = self.pickerTextField.text!.lowercaseString
        do {
            try PFUser.currentUser()?.save()
        } catch let ex {
            print(ex)
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
}
