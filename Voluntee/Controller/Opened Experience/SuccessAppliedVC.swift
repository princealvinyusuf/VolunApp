//
//  SuccessAppliedVC.swift
//  Voluny
//


import UIKit

class SuccessAppliedVC: UIViewController {
    
    @IBOutlet weak var illustrateImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // create tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SuccessAppliedVC.imageTapped(gesture:)))

        // add it to the image view;
        illustrateImage.addGestureRecognizer(tapGesture)
        // make sure imageView can be interacted with by user
        illustrateImage.isUserInteractionEnabled = true
    }

    
    @objc func imageTapped(gesture: UIGestureRecognizer) {
        // if the tapped view is a UIImageView then set it to imageview
        if (gesture.view as? UIImageView) != nil {
            backToHome()
            //Here you can initiate your new ViewController

        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    
    @IBAction func backTapped(_ sender: UIButton){
        backToHome()
    }
    
    func backToHome(){
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: HomeVC .self) || controller.isKind(of: CategoryVC .self){
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
    }
    
    
}
