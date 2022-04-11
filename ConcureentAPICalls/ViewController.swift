//
//  ViewController.swift
//  ConcureentAPICalls
//
//  Created by Gurjinder Singh on 31/08/21.
//

import UIKit

class ViewController: UIViewController {
    let group = DispatchGroup()
    let urls = [
        URL(string:"https://jsonplaceholder.typicode.com/comments"),
        URL(string:"https://jsonplaceholder.typicode.com/comments"),
        URL(string:"https://jsonplaceholder.typicode.com/comments"),
        URL(string:"https://jsonplaceholder.typicode.com/comments"),
        URL(string:"https://jsonplaceholder.typicode.com/comments"),
        URL(string:"https://jsonplaceholder.typicode.com/comments")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for url in urls {
            group.enter()
            let urlReq = URLRequest.init(url: url!)
            URLSession.shared.dataTask(with: urlReq) { (data, response, error) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    if let data = data {
                        if let json = try? JSONSerialization.jsonObject(with: data, options: []) {
                            print(json)
                        }
                    }
                }
                self.group.leave()
            }.resume()
        }
        
        // Configure a completion callback
        group.notify(queue: .main) {
            // All requests completed
            print("API calling Done")
        }
    }


}

