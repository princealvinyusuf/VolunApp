//
//  CategoryVC.swift
//  Voluny
//


import UIKit

class CategoryVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextFieldDelegate {
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    let categoryNames = ["ANIMAL", "CHILDREN", "COMMUNITY", "DISABILITY", "EDUCATION", "ENVIRONMENT", "HEALTH", "HOMELESS", "SENIOR"]
    
    @IBOutlet weak var citySearchTableView: UITableView!
    var reusableCitySearchTable: ReusabeCitySearchTableView!
    @IBOutlet weak var suggestionsView: WalkthroughShadowView!
    
    // Indicator Views
    var indicatorBackground: UIView!
    var activityIndicator: UIActivityIndicatorView!
    var isInternetAvailable = true
    @IBOutlet weak var suggestionBackgroundView: UIView!
    
    @IBOutlet weak var unavailableView: NoCityFoundView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Hide keyboard and suggestions view when tapped away
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
      
        setupIndicatorViews() // Setting up the activity indicator view and its background view
        
        reusableCitySearchTable = ReusabeCitySearchTableView(tableView: citySearchTableView)
       

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        
        

        
    }
    
    
    @objc override func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: Managing the Activity Indicator
    func setupIndicatorViews(){
        indicatorBackground = UIView(frame: view.bounds)
        indicatorBackground.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.203537632)
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: view.center.x-18, y: view.center.y-18, width: 36, height: 36))
        activityIndicator.style = .whiteLarge
        indicatorBackground.addSubview(activityIndicator)
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
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CategoryCell
        cell.titleLabel.text = categoryNames[indexPath.row]
        cell.iconImageView.image = UIImage(named: "\(categoryNames[indexPath.row])_i.png")
        
        cell.contentView.layer.cornerRadius = 20
        cell.contentView.layer.masksToBounds = true
        
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.3
        cell.layer.shadowRadius = 4.0
        cell.layer.masksToBounds = false
        cell.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 28 - 28 - 10 - 10) / 2
        return CGSize(width: width, height: UIScreen.main.bounds.height * 0.3)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toTappedCategory", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTappedCategory"{
            let destinationVC = segue.destination as! TappedCategoryVC
            let index = sender as! Int
            destinationVC.selectedCategory = categoryNames[index]
        }
    }

}
