//
//  ViewController.swift
//  iOS_test
//
//  Created by Арсений Беглов on 09.10.2023.
//

import UIKit



class ViewController: UIViewController, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        beerData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let beer = beerData[indexPath.row]
        var cell = UITableViewCell()
        var configuration = cell.defaultContentConfiguration()
        configuration.text = beer.name
        configuration.secondaryText=beer.tagline
        cell.contentConfiguration = configuration
        return cell
    }
    
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .cyan
        tableView.dataSource = self
        return tableView
    }()
    
    private var beerData: [BeerDTO] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        tableView.translatesAutoresizingMaskIntoConstraints=false
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        let url: URL = URL(string: "https://api.punkapi.com/v2/beers")!
        URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            guard let data = data,
                  error == nil
            else{
                return
            }
            let decoder = JSONDecoder()
            self.beerData = try! decoder.decode([BeerDTO].self, from: data)
            DispatchQueue.main.async(execute: {self.tableView.reloadData()})
            
        }).resume()
    }
    
}



struct BeerDTO: Decodable{
    let id: Int
    let name, tagline: String
    let imageUrl: URL
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case tagline
        case imageUrl = "image_url"
    }
}
