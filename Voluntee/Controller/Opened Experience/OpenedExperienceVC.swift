//
//  OpenedExperienceVC.swift
//  Voluny
//


import UIKit
import Cosmos
import SDWebImage
import Firebase

class OpenedExperienceVC: UIViewController {
    
    var selectedExperience: Experience!
    
    @IBOutlet weak var bannerPhoto: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var applyBeforeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeClockLabel: UILabel!
    @IBOutlet weak var participantLabel: UILabel!
    @IBOutlet weak var timeNeededLabel: UILabel!
    @IBOutlet weak var feeLabel: UILabel!
    @IBOutlet weak var preciseLocationLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var requirementLabel: UITextView!
    
    @IBOutlet weak var volunteerButton: WalkthroughRoundedButton!
    
    var isApplied = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        if isApplied ==  true{
            volunteerButtonApplied()
        }
        
        bannerPhoto.sd_setImage(with: URL(string: selectedExperience.bannerPhoto))
        titleLabel.text = selectedExperience.title
        dateLabel.text = selectedExperience.date
        categoryLabel.text = selectedExperience.category
        applyBeforeLabel.text = "Apply before " + selectedExperience.applydate
        timeClockLabel.text = selectedExperience.time
        participantLabel.text = selectedExperience.ageGroup + " People"
        timeNeededLabel.text = selectedExperience.duration + " Hours"
        feeLabel.text = "Rp. " + selectedExperience.fee 
        preciseLocationLabel.text = selectedExperience.preciseLocation
        requirementLabel.text = selectedExperience.requirement
        descriptionTextView.text = selectedExperience.longDescription
        
        NotificationCenter.default.addObserver(self, selector: #selector(userLoggedIn), name: Notification.Name("userLoggedIn"), object: nil)
        
        applyDateChecker()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tabBarController?.tabBar.invalidateIntrinsicContentSize()
    }
    
    func volunteerButtonApplied(){
        volunteerButton.setTitle("Applied", for: .normal)
        volunteerButton.setTitleColor(UIColor(red:0.29, green:0.29, blue:0.29, alpha:1.0), for: .normal)
        volunteerButton.backgroundColor = UIColor(red:0.91, green:0.91, blue:0.91, alpha:1.0)
        volunteerButton.isEnabled = false
    }
    
    func volunteerButtonEnded(){
        volunteerButton.setTitle("Ended", for: .normal)
        volunteerButton.setTitleColor(UIColor(red:0.29, green:0.29, blue:0.29, alpha:1.0), for: .normal)
        volunteerButton.backgroundColor = UIColor(red:0.91, green:0.91, blue:0.91, alpha:1.0)
        volunteerButton.isEnabled = false
    }
    
    func applyDateChecker(){
        let todayDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/mm/yyyy"
        let today = dateFormatter.string(from: todayDate)
        let date2 = dateFormatter.date(from: today)
        let date1 = dateFormatter.date(from: selectedExperience.applydate)
        let timeIntervalDate1 = date1!.timeIntervalSince1970
        let timeIntervalDate2 = date2!.timeIntervalSince1970
        
        print(Int(timeIntervalDate1))
        print(Int(timeIntervalDate2))

        if Int(timeIntervalDate2) > Int(timeIntervalDate1){
            volunteerButtonEnded()
        }
    }
    
    // User taps on volunteer, signed in or anonymous?
    @IBAction func volunteerTapped(_ sender: Any){
        if Auth.auth().currentUser?.isAnonymous == true{
            // user is not signed in, sign in/up user
            performSegue(withIdentifier: "toLogin", sender: nil)
        }else{
            // user is signed in, button is enabled so user didn't apply yet
            self.hidesBottomBarWhenPushed = true
            performSegue(withIdentifier: "apply", sender: nil)
        }
    }
    
    @objc func userLoggedIn(_ notification: Notification){
        if let isSignIn = notification.object as? Bool{
            // user just signed in -> check if applied already if no, let's apply
            //signed up - let's apply
            if isSignIn{
                DataService.instance.didUserApply(experienceID: selectedExperience.id, userID: (Auth.auth().currentUser?.uid)!) { (applied) in
                    if applied{
                        self.volunteerButtonApplied()
                        self.performSegue(withIdentifier: "appliedAlready", sender: nil)
                    }else{
                        self.hidesBottomBarWhenPushed = true
                        self.performSegue(withIdentifier: "apply", sender: nil)
                    }
                }
            }else{
                self.hidesBottomBarWhenPushed = true
                performSegue(withIdentifier: "apply", sender: nil)
            }
        }
    }
    
    
    @IBAction func reviewsTapped(_ sender: Any) {
        self.hidesBottomBarWhenPushed = true
        performSegue(withIdentifier: "toReviews", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toReviews"{
            let destinationVC = segue.destination as! OpenedExperienceReviewsVC
            destinationVC.experienceID = selectedExperience.id
        }
        
        if segue.identifier == "apply"{
            let applyVC = segue.destination as! SubmitApplicationVC
            applyVC.experience = selectedExperience
        }
        
        if segue.identifier == "appliedAlready"{
            let errorVC = segue.destination as! LoginMessage
            errorVC.message = "You already applied to this experience, try to apply to another one instead."
            errorVC.buttonText = "Okay"
        }
    }
    

    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
