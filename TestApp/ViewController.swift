//
//  ViewController.swift
//  TestApp
//
//  Created by Kristiina on 13/09/2019.
//  Copyright © 2019 Kristiina. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField?
    @IBOutlet weak var tableView: UITableView?
    
    var cats: [CatStatus] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView?.dataSource = self
    }
    
    @IBAction func didSubmit() {
        if let text = self.textField?.text {
            if text.count == 3 {
                self.textField?.textColor = .black // status code is valid
                self.textField?.text = nil
                
                let newCat = CatStatus(value: text)
                self.cats.append(newCat)
                
                let indexPath = IndexPath(row: cats.count - 1, section: 0)
                tableView?.insertRows(at: [indexPath], with: .automatic)
                
                newCat.updated = { [unowned self] in
                    DispatchQueue.main.async {
                        self.tableView?.reloadRows(at: [indexPath], with: .automatic)
                    }
                }
                newCat.makeRequest()
            } else {
                self.textField?.textColor = .red // status code has more or less than 3 digits
            }
            if text.count == 0 {
                self.textField?.textColor = .black // status code is empty
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CatCell") as! CatTableViewCell
        
        let cat = cats[indexPath.row]
        cell.label?.text = cat.value
        
        if let data = cat.imageData {
            cell.catImageView?.image = UIImage(data: data)
        }
        
        return cell
    }
}
