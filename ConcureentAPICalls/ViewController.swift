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
        self.makeAPICalls()
    }

    private func makeAPICalls() {
        urls.forEach { url in
            group.enter()
            print("--------------Making request---------")
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
        group.notify(queue: .main) { [weak self] in
            // All requests completed
            print("API calling Done")
            let lbl = UILabel.init(frame: CGRect.init(x: 0, y: 200, width: 200, height: 30))
            lbl.textAlignment = .center
            lbl.center = self?.view.center ?? CGPoint.init(x: 0, y: 200)
            lbl.text = "All calls completed"
            lbl.backgroundColor = .red
            lbl.textColor = .white
            self?.view.addSubview(lbl)
        }
    }

}

