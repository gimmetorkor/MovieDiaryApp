//
//  DiaryTableViewCell.swift
//  MovieDiary
//
//  Created by imyourtk on 3/12/2566 BE.
//

import UIKit

class DiaryTableViewCell: UITableViewCell {

    @IBOutlet weak var nameDiary: UILabel!
    @IBOutlet weak var imgDiary: UIImageView!
    @IBOutlet weak var yearDiary: UILabel!
    @IBOutlet weak var dateDiary: UILabel!
    @IBOutlet weak var noteDiaryTxtView: UITextView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        isUserInteractionEnabled = false
    }
    
    func configureCell(name: String, image: String, year: String, note: String, date: String) {
        nameDiary.text = name
        imgDiary.image = UIImage.init(named: image)
        yearDiary.text = year
        dateDiary.text = date
        noteDiaryTxtView.text = note
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
