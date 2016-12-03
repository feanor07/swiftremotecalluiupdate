//
//  ViewController.swift
//  remotecalluiupdate
//
//  Created by Tubitak YTE on 03/12/2016.
//  Copyright © 2016 alptugdilek. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    var count: Int = 1;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "Just Started"
        // Do any additional setup after loading the view, typically from a nib.
        _ = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(ViewController.self.getScore), userInfo: nil, repeats: true)
    }
    
    func getScore() {
        let myUrl = URL(string: "http://jsonplaceholder.typicode.com/posts/" + String(count));
        var request = URLRequest(url:myUrl!)
        
        request.httpMethod = "GET"// Compose a query string
        
        //input data bind to send server
        
        //request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil
            {
                print("error=\(error)")
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                
                if let parseJSON = json {
                    let title = parseJSON["title"] as? String
                    
                    DispatchQueue.main.async {
                        self.label.text = title
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
        
        self.count = (self.count + 1) % 100;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

