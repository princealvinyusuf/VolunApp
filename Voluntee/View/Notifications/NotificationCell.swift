//
//  NotificationCell.swift
//  Voluny
//


import UIKit

class NotificationCell: UITableViewCell {

    @IBOutlet weak var statusImage: UIImageView!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureCell(notific: ExperienceNotification){
        if notific.status == "accepted"{
            statusImage.image = UIImage(named: "bluecheck")
            messageLabel.text = "You are accepted to join \(notific.title)"
            let normalFont = UIFont.systemFont(ofSize: 14)
            let boldFont = UIFont.boldSystemFont(ofSize: 17)
            self.messageLabel.attributedText = addBoldText(fullString: messageLabel.text! as NSString, boldPartsOfString: ["accepted"], font: normalFont, boldFont: boldFont)
        }
        
        if notific.status == "pending"{
            statusImage.image = UIImage(named: "Pending: Icon")
            messageLabel.text = "Your application is being reviewed. Thanks for applying for \(notific.title)"
            timeLabel.text = notific.date
            let normalFont = UIFont.systemFont(ofSize: 14)
            let boldFont = UIFont.boldSystemFont(ofSize: 17)
            self.messageLabel.attributedText = addBoldText(fullString: messageLabel.text! as NSString, boldPartsOfString: ["being","reviewed"], font: normalFont, boldFont: boldFont)
        }
        
        if notific.status == "declined"{
            statusImage.image = UIImage(named: "redx")
            messageLabel.text = "You are declined to join. Thanks for applying for \(notific.title)"
            timeLabel.text = notific.date
            let normalFont = UIFont.systemFont(ofSize: 14)
            let boldFont = UIFont.boldSystemFont(ofSize: 17)
            self.messageLabel.attributedText = addBoldText(fullString: messageLabel.text! as NSString, boldPartsOfString: ["declined"], font: normalFont, boldFont: boldFont)
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm:ss"
        let date = dateFormatter.date(from: notific.date)
        timeLabel.text = timeAgoSince(date!)
    
    }
    
    func addBoldText(fullString: NSString, boldPartsOfString: Array<NSString>, font: UIFont!, boldFont: UIFont!) -> NSAttributedString {
        let nonBoldFontAttribute = [NSAttributedString.Key.font:font!]
        let boldFontAttribute = [NSAttributedString.Key.font:boldFont!]
        let boldString = NSMutableAttributedString(string: fullString as String, attributes:nonBoldFontAttribute)
        for i in 0 ..< boldPartsOfString.count {
            boldString.addAttributes(boldFontAttribute, range: fullString.range(of: boldPartsOfString[i] as String))
        }
        return boldString
    }
    


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
