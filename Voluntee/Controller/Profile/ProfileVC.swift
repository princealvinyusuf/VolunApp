//
//  ProfileVC.swift
//  Voluny
//


import UIKit
import Firebase
import SDWebImage
import MessageUI

class ProfileVC: UIViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var lastLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var signOut: WalkthroughRoundedButton!
    
    @IBOutlet weak var noSignIn: UIImageView!
    @IBOutlet weak var noLabel: UILabel!
    
    
    var selectedUser: Volunteer!
    
//    @IBOutlet weak var indicator: UIActivityIndicatorView!
//
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        profileImage.layer.cornerRadius = profileImage.frame.height / 2
        profileImage.clipsToBounds = true
        profileImage.isHidden = true
//        indicator.startAnimating()
        stackView.isHidden = true
        signOut.isHidden = true
        self.noLabel.isHidden = false
        
        NotificationCenter.default.addObserver(self, selector: #selector(loginClosed), name: Notification.Name("loginClosed"), object: nil)
        
    }
    
    @objc func loginClosed(_ notification: Notification){
        self.tabBarController?.selectedIndex = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Auth.auth().currentUser?.isAnonymous == true{
            DispatchQueue.main.async(execute: {
                self.performSegue(withIdentifier: "login", sender: nil)
                self.stackView.isHidden = true
                self.signOut.isHidden = true
                self.noLabel.isHidden = false
            })
        }else{
            loadUserInfo() // this produces crash after signing in, maybe consider viewdidappear
        }
    }
    
    func loadUserInfo(){
        DataService.instance.getUserInfo(userID: (Auth.auth().currentUser?.uid)!) { (volunteer) in
            self.selectedUser = volunteer
            let names = volunteer.name.split(separator: " ")
            self.firstLabel.text = String(names[0])
            self.lastLabel.text = String(names[1])
            self.emailLabel.text = volunteer.email
            self.dateLabel.text = volunteer.date
            self.phoneLabel.text = volunteer.phone
            self.profileImage.sd_setImage(with: URL(string: volunteer.profileURL))
            self.profileImage.isHidden = false
//            self.indicator.stopAnimating()
//            self.indicator.isHidden = true
            self.stackView.isHidden = false
            self.signOut.isHidden = false
            self.noSignIn.isHidden = true
            self.noLabel.isHidden = true
        }
    }
    
    @IBAction func logoutTapped(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            print("Firebase: Successfully signed out!")
            Auth.auth().signInAnonymously() { (user, error) in
                print("Firebase: Anonymous singed in!")
            }
        }catch let signOutError as NSError{
            print("Error signing out: \(signOutError)")
        }
    }
    
}
