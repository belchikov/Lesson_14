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
    func loadCharacters(apipage: String, completion: @escaping (Characters) -> Void){
        AF.request(apipage).responseDecodable(of: Characters.self) { response in
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
    var info: CharactersInfo
    var results: [Character]?
    enum CodingKeys: String, CodingKey {
        case results = "results"
        case info
    }
}
struct CharactersInfo : Decodable {
    var count: Int
    var next: String?
}
struct Character : Decodable {
    var name: String
    let image: String
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
