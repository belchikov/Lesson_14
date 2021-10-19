//
//  CharacterTableViewCell.swift
//  lesson_12
//
//  Created by Александр Бельчиков on 25.05.2021.
//

import UIKit
@IBDesignable
class CharacterTableViewCell: UITableViewCell {

    @IBOutlet weak var CharacterImage: UIImageView!
    @IBOutlet weak var CharacterName: UILabel!
    @IBOutlet weak var CharacterProp: UILabel!
    @IBOutlet weak var CharacterLocation: UILabel!
    var detalUrl : String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func initCell(item: [String]){
        
        //print(item)
        
    }
}
