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
        URLSession.shared.dataTask(with: url, completionHandler: {data, response, error in
            guard let data = data,
                  let response = response,
                  error == nil
            else{
                return
            }
//            let decoder = JSONDecoder()
//            let decodedData = try decoder.decode(MyData.self, from: data)
            let str = String(data:data, encoding: .utf8)
            print("\(str ?? "")")
        }).resume()
        
    }
}

