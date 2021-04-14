//
//  WelcomeVC.swift
//  Voluny
//


import UIKit

class WelcomeVC: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!

    @IBOutlet weak var page1ImageView: UIImageView!
    @IBOutlet weak var page2ImageView: UIImageView!
    @IBOutlet weak var page3ImageView: UIImageView!
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    let filledImage = UIImage(named: "oval")
    let unFilledImage = UIImage(named: "oval_")
    
    @IBOutlet weak var startButton: UIButton!
    
    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        let slides = createSlides()
        setupScrollView(slides)
        backButton.isHidden = true
    }
    
    
    func createSlides() ->[SlideView]{
        let slide1 = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! SlideView
        slide1.welcomeImage.image = UIImage(named: "onboard5")
        slide1.underImageLabel.text = "Do something"
        slide1.descriptionLabel.text = "Willing to contribute for people around you? Be a part of volunteering team and make impact together."
        slide1.onboardWhite.image = UIImage(named: "onboard")
        
        let slide2 = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! SlideView
        slide2.welcomeImage.image = UIImage(named: "onboard6")
        slide2.underImageLabel.text = "Search & apply to any event"
        slide2.descriptionLabel.text = "Search for any event by your interest & passion and submit your application."
        slide2.onboardWhite.image = UIImage(named: "onboardwhite2")
        
        let slide3 = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! SlideView
        slide3.welcomeImage.image = UIImage(named: "onboard7")
        slide3.underImageLabel.text = "Get approved and join the event"
        slide3.descriptionLabel.text = "Get notified when you’re approved to join any event and enjoy your volunteering day."
        slide3.onboardWhite.image = UIImage(named: "onboardwhite3")
        
        return [slide1, slide2, slide3]
    }
    
    func setupScrollView(_ slides: [SlideView]){
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: scrollView.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: 1.0)
        scrollView.isPagingEnabled = true
        
        for each in 0..<slides.count{
            slides[each].frame = CGRect(x: view.frame.width * CGFloat(each), y: 0, width: view.frame.width, height: scrollView.frame.height)
            scrollView.addSubview(slides[each])
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/scrollView.frame.width)
        if pageIndex == 0{
            backButton.isHidden = true
        }else{
            backButton.isHidden = false
        }
        
        if pageIndex == 2{
            nextButton.isHidden = true
            startButton.isHidden = false
        }else{
            nextButton.isHidden = false
            startButton.isHidden = true
        }
        
        if pageIndex == 0{
            selectedIndex = 0
            page1ImageView.image = filledImage
            
            page2ImageView.image = unFilledImage
            page3ImageView.image = unFilledImage
        }else if pageIndex == 1{
            selectedIndex = 1
            page2ImageView.image = filledImage
            
            page1ImageView.image = unFilledImage
            page3ImageView.image = unFilledImage
        }else if pageIndex == 2{
            selectedIndex = 2
            page3ImageView.image = filledImage
            
            page1ImageView.image = unFilledImage
            page2ImageView.image = unFilledImage
        }else if pageIndex == 3{
            selectedIndex = 3
            
            page1ImageView.image = unFilledImage
            page2ImageView.image = unFilledImage
            page3ImageView.image = unFilledImage
        }
    }
    
    @IBAction func nextTapped(_ sender: UIButton){
        if selectedIndex == 0{
            scrollView.scrollRectToVisible(CGRect(x: view.frame.width, y: 0, width: view.frame.width, height: scrollView.frame.height), animated: true)
        }else if selectedIndex == 1{
            scrollView.scrollRectToVisible(CGRect(x: view.frame.width*2, y: 0, width: view.frame.width, height: scrollView.frame.height), animated: true)
        }else if selectedIndex == 2{
            scrollView.scrollRectToVisible(CGRect(x: view.frame.width*3, y: 0, width: view.frame.width, height: scrollView.frame.height), animated: true)
        }
    }
    
    @IBAction func backTapped(_ sender: UIButton){
        if selectedIndex == 1{
            scrollView.scrollRectToVisible(CGRect(x: 0, y: 0, width: view.frame.width, height: scrollView.frame.height), animated: true)
        }else if selectedIndex == 2{
            scrollView.scrollRectToVisible(CGRect(x: view.frame.width, y: 0, width: view.frame.width, height: scrollView.frame.height), animated: true)
        }else if selectedIndex == 3{
            scrollView.scrollRectToVisible(CGRect(x: view.frame.width*2, y: 0, width: view.frame.width, height: scrollView.frame.height), animated: true)
        }
    }
    
    @IBAction func startTapped(_ sender: UIButton){
        
    }
    
}
