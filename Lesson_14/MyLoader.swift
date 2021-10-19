//
//  MyLoader.swift
//  lesson_12
//
//  Created by Александр Бельчиков on 25.05.2021.
//

//import UIKit
import Foundation
import Alamofire
import AlamofireImage

class MyLoader {
    
    //Листинг Персонажей
    func loadCharacters(completion: @escaping (Characters) -> Void){
        AF.request("https://rickandmortyapi.com/api/character").responseDecodable(of: Characters.self) { response in
            guard let char_list = response.value else { return }
            completion(char_list)
        }
    }
    
    //Детальная Персонажа
    func loadCharacter(detailurl : String, completion: @escaping (Character) -> Void){
        AF.request(detailurl).responseDecodable(of: Character.self) { (response) in
            guard let char = response.value else { return }
            completion(char)
        }
    }
    
    //загрузка картинок
    func downloadImage(_ path: String, completion: @escaping (UIImage?) -> Void) {
        AF.request(path).responseImage { response in
            DispatchQueue.main.async {
                completion(response.value)
            }
        }
    }
}



struct Characters : Decodable{
    //var info: info?
    var results: [Character]?
    enum CodingKeys: String, CodingKey {
        case results = "results"
    }
}
//struct info : Decodable {
//    let count: String?
//    let next: String?
//}
struct Character : Decodable {
    var name: String?
    let image: String?
    let location: location?
    let gender: String?
    let url: String?
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case image
        case location
        case gender
        case url
    }
}
struct location : Decodable {
    let name: String
    let url: String
}


//class Characters{
//
//    let name, Prop, Location, imageURL, detailUrl: String
//    init?(data: NSDictionary){
//        guard let name = data["name"] as? String,
//              let imageURL = data["image"] as? String,
//              let Prop_1 = data["gender"] as? String,
//              let Prop_2 = data["species"] as? String,
//              let Prop_3 = data["status"] as? String,
//
//              let Location = data["location"] as? [String: AnyObject],
//              let LocationName = Location["name"] as? String,
//
//              let detailUrl = data["url"] as? String
//        else {
//            return nil
//        }
//        self.name = name
//        self.Prop = Prop_3 + " - " + Prop_1 + " - " + Prop_2
//        self.Location = LocationName
//        self.imageURL = imageURL
//        self.detailUrl = detailUrl
//    }
//}
