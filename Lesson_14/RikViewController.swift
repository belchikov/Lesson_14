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
    //var characters : [results] = []
    //var characters : [result] = []
    var characters : [Character] = []
    //var characters : [Any] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MyLoader().loadCharacters { characters in
            //я вот тут не понимаю как из characters.results данные добавить в var characters: [Characters] = []
            self.characters = characters.results!
            self.characterTable.reloadData()
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let CharacterCell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell", for: indexPath) as! CharacterTableViewCell
        let character = characters[indexPath.row]
        
        //print(character)
        //print(character.name)
        //print(character.location)
        
        CharacterCell.CharacterName.text = character.name
        CharacterCell.CharacterProp.text = character.gender
        CharacterCell.CharacterLocation.text = character.location!.name
        CharacterCell.detalUrl = character.url
        MyLoader().downloadImage(character.image){ image in
            CharacterCell.CharacterImage.image = image
        }
        return CharacterCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "DetailViewControllerShow" {
            let indexRow = characterTable.indexPathForSelectedRow?.row
            let detail = segue.destination as? DetailViewController
            
            //c подгрузкой
            //detail?.setDetailUrl(characters[indexRow!].url!)
            
            detail?.Character = characters[indexRow!]
        }
    }
}

