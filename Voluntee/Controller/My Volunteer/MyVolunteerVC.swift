//
//  MyVolunteerVC.swift
//  Voluny
//


import UIKit
import Firebase

class MyVolunteerVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    @IBOutlet weak var acceptedCountLabel: UILabel!
    @IBOutlet weak var pendingCountLabel: UILabel!
    @IBOutlet weak var declinedCountLabel: UILabel!
    
    
    @IBOutlet weak var illustrateImage: UIImageView!
    @IBOutlet weak var illustrateMessage: UILabel!
    
    
    
    var acceptedExperiences = [MyVolunteerExperience]()
    var pendingExperiences = [MyVolunteerExperience]()
    var declinedExperiences = [MyVolunteerExperience]()
    
    
    var selectedOption = "" // Either Accepted or Pending depending on what kind of status the user taps on when hits reviews in the options menu
    var selectedAccepted: MyVolunteerExperience! // We store the accepted experience when the user hits on reviews in the options menu to get the date of the experience to see if it's in the past now, if it is, he can write reviews
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        indicator.startAnimating()
        
        tableView.backgroundView = UIImageView(image: UIImage(named: "bg ececec"))
        
        let dummyViewHeight = CGFloat(40)
        self.tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.bounds.size.width, height: dummyViewHeight))
        self.tableView.contentInset = UIEdgeInsets.init(top: -dummyViewHeight, left: 0, bottom: 30, right: 0)
        
        NotificationCenter.default.addObserver(self, selector: #selector(loginClosed), name: Notification.Name("loginClosed"), object: nil)
    }
    
    @objc func loginClosed(_ notification: Notification){
        self.tabBarController?.selectedIndex = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        loadAccepted()
        loadPending()
        loadDeclined()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if Auth.auth().currentUser?.isAnonymous == true{ // If user is not logged in yet, we need to present the login screens first
            DispatchQueue.main.async(execute: {
                self.performSegue(withIdentifier: "login", sender: nil)
                self.illustrateImage.isHidden = false
                self.illustrateMessage.isHidden = false
            })
        }else{
            //loadUserInfo() // This produces crash after signing in, maybe consider viewdidappear
        }
    }
    
    // MARK: Loading the statuses
    func loadAccepted(){
        DataService.instance.getExperiencesForStatus(userID: (Auth.auth().currentUser?.uid)!, status: "acceptedExperiences") { (returnedExperiences) in
            self.acceptedExperiences = returnedExperiences
            self.acceptedCountLabel.text = String(returnedExperiences.count)
            self.tableView.reloadData()
            self.indicator.stopAnimating()
            self.indicator.isHidden = true
            
            if returnedExperiences.count != 0 {
                self.illustrateImage.isHidden = true
                self.illustrateMessage.isHidden = true
            }
            
        }
    }
    
    func loadPending(){
        DataService.instance.getExperiencesForStatus(userID: (Auth.auth().currentUser?.uid)!, status: "pendingExperiences") { (returnedExperiences) in
            self.pendingExperiences = returnedExperiences
            self.pendingCountLabel.text = String(returnedExperiences.count)
            self.tableView.reloadData()
            self.indicator.stopAnimating()
            self.indicator.isHidden = true
            
            if returnedExperiences.count != 0 {
                self.illustrateImage.isHidden = true
                self.illustrateMessage.isHidden = true
            }
        }
    }
    
    func loadDeclined(){
        DataService.instance.getExperiencesForStatus(userID: (Auth.auth().currentUser?.uid)!, status: "declinedExperiences") { (returnedExperiences) in
            self.declinedExperiences = returnedExperiences
            self.declinedCountLabel.text = String(returnedExperiences.count)
            self.tableView.reloadData()
            self.indicator.stopAnimating()
            self.indicator.isHidden = true
            
            if returnedExperiences.count != 0 {
                self.illustrateImage.isHidden = true
                self.illustrateMessage.isHidden = true
            }
        }
    }
    
    func requestConfirmation(sender: UIButton){
        let alert = UIAlertController(title: "Cancel Confirmation", message: "Proceed to cancel?", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: {(UIAlertAction)in
            print("rquest tapped")
            let indexPath = IndexPath.init(row: sender.tag, section: 0)
            let cell = self.tableView.cellForRow(at: indexPath) as! MyVolunteerCell
            print("indexPath: ", indexPath.row)
            print("uid: ", (Auth.auth().currentUser?.uid)!)
            print("expID: ", self.acceptedExperiences[sender.tag].expID)
            
            DataService.instance.deleteUserApplication(uid: (Auth.auth().currentUser?.uid)!, expID: self.acceptedExperiences[sender.tag].expID, recruiterID: self.acceptedExperiences[sender.tag].recruiterID)
            self.loadAccepted()
            self.loadPending()
            self.loadDeclined()
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    // ini yang benar
    func pendingConfirmation(sender: UIButton){
        let alert = UIAlertController(title: "Cancel Confirmation", message: "Proceed to cancel?", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: {(UIAlertAction)in
            print("rquest tapped")
            let indexPath = IndexPath.init(row: sender.tag, section: 1)
            let cell = self.tableView.cellForRow(at: indexPath) as! MyVolunteerNonCell
            //            cell.optionsMenu.isHidden = true
            print("indexPath: ", indexPath.row)
            print("uid: ", (Auth.auth().currentUser?.uid)!)
            print("expID: ", self.pendingExperiences[sender.tag].expID)
            
            DataService.instance.deleteUserApplication(uid: (Auth.auth().currentUser?.uid)!, expID: self.pendingExperiences[sender.tag].expID, recruiterID: self.pendingExperiences[sender.tag].recruiterID)
            self.loadAccepted()
            self.loadPending()
            self.loadDeclined()
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    // MARK: Option Menu Actions
    @objc func optionTapped(sender: UIButton){
        let alert = UIAlertController()
        
        alert.addAction(UIAlertAction(title: "Request to Cancel", style: .destructive, handler: {(UIAlertAction)in
            print("User click Delete Button")
            self.requestConfirmation(sender: sender)
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {(UIAlertAction)in
            print("User click Cancel Button")
        }))
        
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
    @objc func requestTapped(sender: UIButton){
        let alert = UIAlertController()
        
        alert.addAction(UIAlertAction(title: "Request to Cancel", style: .destructive, handler: {(UIAlertAction)in
            print("User click Delete Button")
            self.requestConfirmation(sender: sender)
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {(UIAlertAction)in
            print("User click Cancel Button")
        }))
        
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
    @objc func reviewTapped(sender: UIButton){
        let indexPath = IndexPath.init(row: sender.tag, section: 0)
        let cell = tableView.cellForRow(at: indexPath) as! MyVolunteerCell
        //        cell.optionsMenu.isHidden = true
        print("expID: ", acceptedExperiences[sender.tag].expID)
        selectedOption = "accepted"
        selectedAccepted = acceptedExperiences[sender.tag]
        performSegue(withIdentifier: "review", sender: acceptedExperiences[sender.tag].expID)
    }
    
    @objc func PendingoptionTapped(sender: UIButton){
        let alert = UIAlertController()
        
        alert.addAction(UIAlertAction(title: "Request to Cancel", style: .destructive, handler: {(UIAlertAction)in
            print("User click Delete Button")
            self.pendingConfirmation(sender: sender)
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {(UIAlertAction)in
            print("User click Cancel Button")
        }))
        
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
        //        let indexPath = IndexPath.init(row: sender.tag, section: 1)
        //        let cell = tableView.cellForRow(at: indexPath) as! MyVolunteerNonCell
        //        cell.optionsMenu.isHidden = false
    }
    
    @objc func PendingrequestTapped(sender: UIButton){
        let alert = UIAlertController()
        
        alert.addAction(UIAlertAction(title: "Request to Cancel", style: .destructive, handler: {(UIAlertAction)in
            print("User click Delete Button")
            self.pendingConfirmation(sender: sender)
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {(UIAlertAction)in
            print("User click Cancel Button")
        }))
        
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
    @objc func PendingreviewTapped(sender: UIButton){
        let indexPath = IndexPath.init(row: sender.tag, section: 1)
        let cell = tableView.cellForRow(at: indexPath) as! MyVolunteerNonCell
        //        cell.optionsMenu.isHidden = true
        print("expID: ", pendingExperiences[sender.tag].expID)
        selectedOption = "pending"
        performSegue(withIdentifier: "review", sender: pendingExperiences[sender.tag].expID)
    }
    
    @objc func redDotsTapped(sender: UIButton){
        let indexPath = IndexPath.init(row: sender.tag, section: 0)
        let cell = tableView.cellForRow(at: indexPath) as! MyVolunteerCell
    }
    
    @objc func whiteDotsTapped(sender: UIButton){
        let indexPath = IndexPath.init(row: sender.tag, section: 1)
        let cell = tableView.cellForRow(at: indexPath) as! MyVolunteerNonCell
        //        cell.optionsMenu.isHidden = true
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "review"{
            let destination = segue.destination as! OpenedExperienceReviewsVC
            destination.experienceID = sender as? String
            
            if selectedOption == "accepted"{
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
                let date = dateFormatter.date(from: "\(selectedAccepted.date) \(selectedAccepted.time)")
                print(date!)
                if date! > Date(){ // If the accepted experience didn't happen yet, the user cannot reviews yet, only when it's in the past
                    destination.isWriteMode = false
                }else{
                    destination.isWriteMode = true
                }
            }else{ // User wants to read reviews of a pending experience, so the user cannot post new reviews yet
                destination.isWriteMode = false
            }
            
            
        }
    }
    
}

// MARK: TableView delegate methods
extension MyVolunteerVC{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return acceptedExperiences.count
        }
        
        if section == 1{
            return pendingExperiences.count
        }
        
        if section == 2{
            return declinedExperiences.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellFilled") as! MyVolunteerCell
            cell.configureCell(experience: acceptedExperiences[indexPath.row])
            
            cell.requestButton.tag = indexPath.row
            cell.requestButton.addTarget(self, action: #selector(requestTapped(sender:)), for: .touchUpInside)
            
            return cell
        }
        
        if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellUnfilled") as! MyVolunteerNonCell
            cell.configureCell(experience: pendingExperiences[indexPath.row], section: 1)
            
            cell.requestButton.tag = indexPath.row
            cell.requestButton.addTarget(self, action: #selector(PendingrequestTapped(sender:)), for: .touchUpInside)
            
            return cell
        }
        
        if indexPath.section == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellUnfilled") as! MyVolunteerNonCell
            cell.configureCell(experience: declinedExperiences[indexPath.row], section: 2)
            return cell
        }
            
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellUnfilled") as! MyVolunteerNonCell
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "headerCell") as! MyHeaderCell
        switch section{
        case 0:
            if acceptedExperiences.count > 0{
                cell.titleLabel.text = "Accepted"
                cell.titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
            }
        case 1:
            if pendingExperiences.count > 0{
                cell.titleLabel.text = "Pending"
                cell.titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
            }
        case 2:
            if declinedExperiences.count > 0{
                cell.titleLabel.text = "Declined"
                cell.titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
            }
        default:
            cell.titleLabel.text = ""
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section{
        case 0:
            if acceptedExperiences.count > 0{
                return 50
            }else{
                return 0
            }
        case 1:
            if pendingExperiences.count > 0{
                return 50
            }else{
                return 0
            }
        case 2:
            if declinedExperiences.count > 0{
                return 50
            }else{
                return 0
            }
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return CGFloat(integerLiteral: 156)
        }else{
            //            return CGFloat(integerLiteral: 80)
            return CGFloat(integerLiteral: 156)
        }
    }
    
    
}
