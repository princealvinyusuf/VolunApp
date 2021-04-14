//
//  RecruitProfileVC.swift
//  Voluny
//


import UIKit
import Firebase
import MessageUI

class RecruitProfileVC: UIViewController, MFMailComposeViewControllerDelegate {
    
    
    @IBOutlet weak var organisationLabel: UILabel!
    @IBOutlet weak var recruiterLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    var currentUser: Recruiter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadInfo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func loadInfo(){
        DataService.instance.getRecruiterInfo(userID: (Auth.auth().currentUser?.uid)!) { (recruiter) in
            self.currentUser = recruiter
            self.organisationLabel.text = recruiter.organisation
            self.recruiterLabel.text = recruiter.recruiter
            self.emailLabel.text = recruiter.email
            self.phoneLabel.text = recruiter.phoneNumber
        }
    }
    
    @IBAction func editTapped(_ sender: Any) {
        performSegue(withIdentifier: "edit", sender: nil)
    }
    
    @IBAction func logoutTapped(_ sender: Any) {
        do{
            try Auth.auth().signOut()
//            let firstVC = storyboard?.instantiateViewController(withIdentifier: "UserTypeVC")
//            DispatchQueue.main.async {
//                self.present(firstVC!, animated: false, completion: nil)
//            }
            print("Firebase: Successfully signed out!")
        }catch let signOutError as NSError{
            print("Error signing out: \(signOutError)")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "edit"{
            let destination = segue.destination as! RecruitEditProfileVC
            destination.selectedUser = currentUser
        }
    }
    

}
