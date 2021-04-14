//
//  TappedCategoryVC.swift
//  Voluny
//


import UIKit
import Firebase

class TappedCategoryVC: UIViewController, UITextFieldDelegate, ExperienceSearchProtocol {

    @IBOutlet weak var categoryTtitleLabel: UILabel!
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var tableview: UITableView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var selectedCategory:String!
    
    var isUserAppliedSelectedExperience = false

    var experiences = [Experience]()
    var reusableTable: ReusableExperienceTableView!
    
    @IBOutlet weak var citySearchTableView: UITableView!
    var reusableCitySearchTable: ReusabeCitySearchTableView!
    @IBOutlet weak var suggestionsView: WalkthroughShadowView!
    
    // Indicator Views
    var indicatorBackground: UIView!
    var suggestionsActivityIndicator: UIActivityIndicatorView!
    var isInternetAvailable = true
    @IBOutlet weak var suggestionBackgroundView: UIView!
    
    @IBOutlet weak var unavailableView: NoCityFoundView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Hide keyboard and suggestions view when tapped away
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    
        setupIndicatorViews() // Setting up the activity indicator view and its background view
        
        reusableCitySearchTable = ReusabeCitySearchTableView(tableView: citySearchTableView)
    
        
        self.hideKeyboardWhenTappedAround()
        
        categoryLabel.text = selectedCategory
        categoryTtitleLabel.text = "CATEGORY: \(selectedCategory!)"
        bannerImageView.image = UIImage(named: "\(selectedCategory!).png")
        
    
        reusableTable = ReusableExperienceTableView(tableView: tableview)
        reusableTable.experienceSearchProtocol = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableview.isUserInteractionEnabled = true
    }
    
    
    @objc override func dismissKeyboard() {
        suggestionViewShow(show: false)
        view.endEditing(true)
    }
    
    // MARK: Managing the Activity Indicator
    func setupIndicatorViews(){
        indicatorBackground = UIView(frame: view.bounds)
        indicatorBackground.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.203537632)
        suggestionsActivityIndicator = UIActivityIndicatorView(frame: CGRect(x: view.center.x-18, y: view.center.y-18, width: 36, height: 36))
        suggestionsActivityIndicator.style = .whiteLarge
        indicatorBackground.addSubview(suggestionsActivityIndicator)
    }
    

    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if !Reachability.isConnectedToNetwork(){ // We don't have internet connection
            let alertVC = UIAlertController(title: "No Internet Connection!", message: "Please connect to the internet to use Voluny", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertVC, animated: true, completion: nil)
            textField.resignFirstResponder()
            isInternetAvailable = false
        }else{
            isInternetAvailable = true
        }
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toOpenedExperienceVC" {
            let destination = segue.destination as! OpenedExperienceVC
            destination.selectedExperience = experiences[sender as! Int]
            destination.isApplied = isUserAppliedSelectedExperience
        }
    }
    
    
    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func experienceTapped(experienceID: String, indexPath: IndexPath) {
        self.hidesBottomBarWhenPushed = true
        tableview.isUserInteractionEnabled = false
        
        if Auth.auth().currentUser?.isAnonymous == false{
            DataService.instance.didUserApply(experienceID: experienceID, userID: (Auth.auth().currentUser?.uid)!) { (applied) in
                self.isUserAppliedSelectedExperience = applied
                self.performSegue(withIdentifier: "toOpenedExperienceVC", sender: indexPath.row)
                self.hidesBottomBarWhenPushed = false
            }
        }else{
            performSegue(withIdentifier: "toOpenedExperienceVC", sender: indexPath.row)
            self.hidesBottomBarWhenPushed = false
        }
    }

}

// Conforming to the CitySearchProtocol
extension TappedCategoryVC{
    func locationDenied() {
        let alertVC = UIAlertController(title: "Location Services Disabled", message: "Please enable location services for this app in Settings", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    
    func showInidicatorAcitivity(show: Bool) {
        if show{
            view.addSubview(indicatorBackground)
            suggestionsActivityIndicator.startAnimating()
            view.isUserInteractionEnabled = false
        }else{ // remove the indicator
            indicatorBackground.removeFromSuperview()
            suggestionsActivityIndicator.stopAnimating()
            view.isUserInteractionEnabled = true
        }
    }
    
    
    func suggestionViewShow(show: Bool) {
        if show{
            suggestionsView.isHidden = false
            suggestionBackgroundView.isHidden = false
        }else{
            suggestionsView.isHidden = true
            suggestionBackgroundView.isHidden = true
        }
    }
    

}


