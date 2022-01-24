//
//  AlertListCell.swift
//  DrinkAlarm
//
//  Created by Mac on 2022/01/24.
//

import UIKit

class AlertListCell: UITableViewCell {
    
    @IBOutlet weak var meridiemLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var alertSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func changeAlertSwitch(_ sender: UISwitch) {
    }
    
}
