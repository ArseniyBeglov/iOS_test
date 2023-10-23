//
//  ViewController.swift
//  iOS_test
//
//  Created by Арсений Беглов on 09.10.2023.
//

import UIKit



class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        let url: URL = URL(string: "https://api.punkapi.com/v2/beers")!
        URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            guard let data = data,
                  error == nil
            else{
                return
            }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let model = try! decoder.decode([BeerDTO].self, from: data)
            print(model)
        }).resume()
    }
    
}

struct BeerDTO: Decodable{
    let id: Int
    let name, tagline: String
    let imageUrl: URL
}
