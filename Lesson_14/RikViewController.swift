//
//  RikViewController.swift
//  Lesson_14
//
//  Created by Александр Бельчиков on 03.06.2021.
//

import UIKit
import Foundation


class RikViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //var isLoading = false
    var currentPage = 1
    var totalPages = 34
    //var totalItemsPage = 20
    
    @IBOutlet weak var characterTable: UITableView!
    
    var characters : [Character] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MyLoader().loadCharacters(currentPage: currentPage) { characters in
            self.characters = characters.results!
            self.characterTable.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row + 1 == self.characters.count && self.currentPage < totalPages{
            self.currentPage = self.currentPage + 1
            //print(currentPage)
            //print(indexPath.row)
            //print("loadMoreData");
            MyLoader().loadCharacters(currentPage: currentPage) { characters in
                //self.characters = characters.results!
                self.characters += characters.results!
                DispatchQueue.main.async {
                    self.characterTable.reloadData()
                }
            }
        }
        
        let CharacterCell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell", for: indexPath) as! CharacterTableViewCell
        let character = characters[indexPath.row]
        
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

