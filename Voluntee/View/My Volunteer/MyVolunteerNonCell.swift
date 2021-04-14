//
//  MyVolunteerNonCell.swift
//  Voluny
//


import UIKit

class MyVolunteerNonCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var requestButton: UIButton!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var participantLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var applyBeforeLabel: UILabel!
    @IBOutlet weak var illustrateImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //        contentView.frame = contentView.frame.inset(by: UIEdgeInsets.init(top: 0, left: 29, bottom: 18, right: 29))
        //        contentView.layer.cornerRadius = 8
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets.init(top: 0, left: 29, bottom: 20, right: 29))
        contentView.layer.cornerRadius = 8
        contentView.layer.shadowColor = UIColor(red:0.61, green:0.61, blue:0.61, alpha:1).cgColor
        contentView.layer.shadowOpacity = 0.5
        contentView.layer.shadowRadius = 4.0
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        
    }
    
    func configureCell(experience: MyVolunteerExperience, section: Int){
        titleLabel.text = experience.title
        categoryLabel.text = experience.category
        locationLabel.text = experience.location
        participantLabel.text = experience.ageGroup + " People"
        dateLabel.text = experience.date
        applyBeforeLabel.text = experience.applydate
        
        
        if section == 2 {
            contentView.layer.borderColor = UIColor(red:0.61, green:0.61, blue:0.61, alpha:1.0).cgColor
            contentView.layer.borderWidth = CGFloat(integerLiteral: 1)
            titleLabel.textColor = UIColor(red:0.61, green:0.61, blue:0.61, alpha:1.0)
            requestButton.isHidden = true
        }else{
            contentView.layer.borderColor = #colorLiteral(red: 0.003921568627, green: 0.568627451, blue: 0.9254901961, alpha: 1)
            contentView.layer.borderWidth = CGFloat(integerLiteral: 1)
            titleLabel.textColor = #colorLiteral(red: 0.003921568627, green: 0.568627451, blue: 0.9254901961, alpha: 1)
            requestButton.isHidden = false
        }
        
        if categoryLabel.text == "Peduli Edukasi" {
            categoryLabel.backgroundColor = #colorLiteral(red: 0.7176470588, green: 0.6, blue: 0.3019607843, alpha: 1)
            illustrateImage.image = UIImage(named: "cardView2")
        } else if categoryLabel.text == "Peduli Sosial" {
            categoryLabel.backgroundColor = #colorLiteral(red: 0.9058823529, green: 0.3725490196, blue: 0.3490196078, alpha: 1)
            illustrateImage.image = UIImage(named: "cardView1")
        } else {
            categoryLabel.backgroundColor = #colorLiteral(red: 0.2705882353, green: 0.5882352941, blue: 0.7843137255, alpha: 1)
            illustrateImage.image = UIImage(named: "cardView3")
        }
        
    }
    
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
