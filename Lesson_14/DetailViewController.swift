//
//  DetailViewController.swift
//  lesson_12
//
//  Created by Александр Бельчиков on 25.05.2021.
//
//https://ru.stackoverflow.com/questions/1031350/swift-%D0%BF%D0%B5%D1%80%D0%B5%D1%85%D0%BE%D0%B4-%D0%BC%D0%B5%D0%B6%D0%B4%D1%83-viewcontroller-%D0%B2-xcode-11
//https://www.codingexplorer.com/segue-uitableviewcell-taps-swift/
//https://www.raywenderlich.com/6587213-alamofire-5-tutorial-for-ios-getting-started

import UIKit

protocol ShowDetailDelegate {
    func setDetailUrl(_ url : String)
}
class DetailViewController: UIViewController, ShowDetailDelegate{

    //var MyDelegate : ShowDetailDelegate?
    var DetailUrl: String?
    var Character: Character?
    
    @IBOutlet weak var DetailImage: UIImageView!
    @IBOutlet weak var DetailTitle: UILabel!
    @IBOutlet weak var DetailLocation: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.DetailTitle.text = Character?.name
        self.DetailLocation.text = Character?.location?.name
        MyLoader().downloadImage(Character!.image){ image in
            self.DetailImage.image = image
        }
    }
    
    func setDetailUrl(_ url: String) {
        MyLoader().loadCharacter(detailurl: url){ character in
            MyLoader().downloadImage(character.image){ image in
                self.DetailImage.image = image
            }
            self.DetailTitle.text = character.name
            self.DetailLocation.text = character.location?.name
        }
    }

}
