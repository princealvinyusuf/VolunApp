//
//  NotificationVC.swift
//  Voluny
//



import UIKit
import Firebase

class NotificationVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableview: UITableView!
    
    var notifications = [ExperienceNotification]()
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    @IBOutlet weak var noLabel: UILabel!
    @IBOutlet weak var noData: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        tableview.backgroundView = UIImageView(image: UIImage(named: "bg ececec"))
        
        NotificationCenter.default.addObserver(self, selector: #selector(loginClosed), name: Notification.Name("loginClosed"), object: nil)
    }
    
    @objc func loginClosed(_ notification: Notification){
        self.tabBarController?.selectedIndex = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if Auth.auth().currentUser?.isAnonymous == true{
            DispatchQueue.main.async(execute: {
                self.performSegue(withIdentifier: "login", sender: nil)
                self.noLabel.isHidden = false
            })
        }else{
            loadNotifications()
        }
    }
    
    func loadNotifications(){
        indicator.startAnimating()
        DataService.instance.getNotifications(userID: (Auth.auth().currentUser?.uid)!) { (notificationArray) in
            //dates.sort { $0 < $1 }
            self.notifications = notificationArray
            self.notifications.sort { $0.nsDate > $1.nsDate }
            
            self.tableview.reloadData()
            self.indicator.stopAnimating()
            self.indicator.isHidden = true
            if notificationArray.count == 0{
                self.noLabel.isHidden = false
                self.noData.isHidden = false
            }else{
                self.noLabel.isHidden = true
                self.noData.isHidden = true
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? NotificationCell else{
            return UITableViewCell()
        }
        
        if indexPath.row % 2 == 0{
            if #available(iOS 13.0, *) {
                cell.contentView.backgroundColor = UIColor.systemBackground
            } else {
                // Fallback on earlier versions
            }
        }else{
            if #available(iOS 13.0, *) {
                cell.contentView.backgroundColor = UIColor.systemBackground
            } else {
                // Fallback on earlier versions
            }
        }
        
        tableView.separatorStyle = .singleLine
        cell.configureCell(notific: notifications[indexPath.row])
        
        return cell
        
    }
    
    
    
}
