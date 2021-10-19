//
//  RikViewController.swift
//  Lesson_14
//
//  Created by Александр Бельчиков on 03.06.2021.
//

import UIKit
import Foundation


class RikViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var MyDelegate : ShowDetailDelegate?
    
    @IBOutlet weak var characterTable: UITableView!
    
    //var characters: [Characters] = []
    var characters = [Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MyLoader().loadCharacters { characters in
            
            //я вот тут не понимаю как из characters.results данные добавить в var characters: [Characters] = []
            
            //debugPrint(characters.results)
            //debugPrint(type(of: characters.results))
            //self.characters = characters.results
            self.characterTable.reloadData()
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //debugPrint(characters.count)
        return characters.count
        //return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let CharacterCell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell", for: indexPath) as! CharacterTableViewCell
        let character = characters[indexPath.row]
        
//      CharacterCell.initCell(item: characters[indexPath.row])
//      CharacterCell.CharacterName.text = character.name
//      CharacterCell.CharacterProp.text = character.Prop
//      CharacterCell.CharacterLocation.text = character.Location
//      CharacterCell.detalUrl = character.detailUrl
//      MyLoader().downloadImage(character.imageURL){ image in
//       CharacterCell.CharacterImage.image = image
//      }
        
        return CharacterCell
        //return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //        if  segue.identifier == "DetailViewControllerShow" {
        //            let indexRow = characterTable.indexPathForSelectedRow?.row
        //
        //            let detail = segue.destination as? DetailViewController
        //            //detail?.DetailUrl = characters[indexRow!].detailUrl
        //            detail?.setDetailUrl(characters[indexRow!].detailUrl)
        //
        //            //print(characters[indexRow!].detailUrl)
        //            //MyDelegate?.setDetailUrl(characters[indexRow!].detailUrl)
        //        }
    }
}

