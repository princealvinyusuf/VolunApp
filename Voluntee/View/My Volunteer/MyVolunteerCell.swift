//
//  MyVolunteerCell.swift
//  Voluny
//


import UIKit

class MyVolunteerCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var participantLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var applyBeforeLabel: UILabel!
    
    @IBOutlet weak var requestButton: UIButton!
    
    @IBOutlet weak var illustrateImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //        backgroundImage.layer.masksToBounds = false
        //        backgroundImage.clipsToBounds = true
        //        backgroundImage.layer.cornerRadius = 8
        
        
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //        contentView.frame = contentView.frame.inset(by: UIEdgeInsets.init(top: 0, left: 29, bottom: 20, right: 29))
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets.init(top: 10, left: 16, bottom: 3, right: 18))
        contentView.layer.cornerRadius = 8
        contentView.layer.shadowColor = UIColor(red:0.61, green:0.61, blue:0.61, alpha:1).cgColor
        contentView.layer.shadowOpacity = 0.5
        contentView.layer.shadowRadius = 4.0
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
    }
    
    func configureCell(experience: MyVolunteerExperience){
        titleLabel.text = experience.title
        categoryLabel.text = experience.category
        locationLabel.text = experience.location
        participantLabel.text = experience.ageGroup + " People"
        dateLabel.text = experience.date
        applyBeforeLabel.text = experience.applydate
        
        contentView.layer.borderColor = #colorLiteral(red: 0.003921568627, green: 0.568627451, blue: 0.9254901961, alpha: 1)
        contentView.layer.borderWidth = CGFloat(integerLiteral: 1)
        
        titleLabel.textColor = #colorLiteral(red: 0.003921568627, green: 0.568627451, blue: 0.9254901961, alpha: 1)
        
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
