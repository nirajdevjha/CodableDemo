//
//  ViewController.swift
//  CodableDemo
//
//  Created by Niraj Jha on 02/04/19.
//  Copyright © 2019 Niraj Jha. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var petitions = [Petition]()
    
    
    // MARK:- Life cycle
    
    deinit {
         print("deinit called")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        performSelector(inBackground: #selector(fetchJSON), with: nil)
       /* navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Credits", style: .plain, target: self, action: #selector(didTappedCredits))
        // let urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
        let urlString: String
        
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    //We're ok to parse
                    self?.parse(json: data)
                    return
                }
            }
            self?.showError()
        } */
    }
    
    // MARK: - Private
    
    // alternative way
    @objc func fetchJSON() {
        
        // let urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
        let urlString: String
        
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                return
            }
        }
        performSelector(onMainThread: #selector(showError1), with: nil, waitUntilDone: false)
    }
    
    // alternative way
    @objc func showError1() {
            let alertController = UIAlertController(title: "Loading error", message: "There was a problem loading the feed, please check your connection and try again", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alertController, animated: true, completion: nil)
    }
    

    @objc func didTappedCredits() {
            let alertController = UIAlertController(title: nil, message: "the data comes from the We The People API of the Whitehouse", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            present(alertController, animated: true, completion: nil)
    }
    
    func showError() {
        DispatchQueue.main.async { [weak self] in
            let alertController = UIAlertController(title: "Loading error", message: "There was a problem loading the feed, please check your connection and try again", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            self?.present(alertController, animated: true, completion: nil)
        }
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            
            //Alternate way
//            DispatchQueue.main.async { [weak self] in
//                self?.tableView.reloadData()
//            }
            tableView.performSelector(onMainThread: #selector(tableView.reloadData), with: nil, waitUntilDone: false)
        } else {
            performSelector(onMainThread: #selector(showError1), with: nil, waitUntilDone: false)
        }
    }
    
    // MARK: - Table view delegate and datasource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        let detailVC = DetailViewController()
        detailVC.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
        
    }
    
}


