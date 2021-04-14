//
//  TestCells.swift
//  Voluny
//


import UIKit
import SDWebImage

class ExperienceCell: UITableViewCell{
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var applyDateLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var quotaLabel: UILabel!
    @IBOutlet weak var eventPhoto: UIImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets.init(top: 10, left: 16, bottom: 3, right: 18))
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.3
        contentView.layer.shadowRadius = 4.0
        contentView.layer.masksToBounds = false
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        eventPhoto.layer.cornerRadius = 33
        eventPhoto.layer.borderWidth = 2
        // eventPhoto.frame.height / 25
        eventPhoto.clipsToBounds = true
        
        if #available(iOS 12.0, *) {
            if self.traitCollection.userInterfaceStyle == .dark {
                contentView.layer.borderWidth = 1
                contentView.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                // User Interface is Light
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
    func configureCell(experience: Experience){
        titleLabel.text = experience.title
        categoryLabel.text = experience.category
        quotaLabel.text = experience.ageGroup + " People"
        locationLabel.text = experience.preciseLocation
        dateLabel.text = experience.date
        applyDateLabel.text = experience.applydate
        eventPhoto.sd_setImage(with: URL(string: experience.iconPhoto))
        
        if categoryLabel.text == "Peduli Edukasi" {
            categoryLabel.backgroundColor = #colorLiteral(red: 0.7176470588, green: 0.6, blue: 0.3019607843, alpha: 1)
            photo.image = UIImage(named: "cardView2")
            eventPhoto.layer.borderColor = #colorLiteral(red: 0.7176470588, green: 0.6, blue: 0.3019607843, alpha: 1)
        } else if categoryLabel.text == "Peduli Sosial" {
            categoryLabel.backgroundColor = #colorLiteral(red: 0.9058823529, green: 0.3725490196, blue: 0.3490196078, alpha: 1)
            photo.image = UIImage(named: "cardView1")
            eventPhoto.layer.borderColor = #colorLiteral(red: 0.9058823529, green: 0.3725490196, blue: 0.3490196078, alpha: 1)
        } else {
            categoryLabel.backgroundColor = #colorLiteral(red: 0.2705882353, green: 0.5882352941, blue: 0.7843137255, alpha: 1)
            photo.image = UIImage(named: "cardView3")
            eventPhoto.layer.borderColor = #colorLiteral(red: 0.2705882353, green: 0.5882352941, blue: 0.7843137255, alpha: 1)
        }
    }
    
    
}
