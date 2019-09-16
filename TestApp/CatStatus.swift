//
//  CatStatus.swift
//  TestApp
//
//  Created by Kristiina on 15/09/2019.
//  Copyright © 2019 Kristiina. All rights reserved.
//

import Foundation

class CatStatus {
    let value: String
    var imageData: Data?
    var updated: (()->())?
    
    init(value: String) {
        self.value = value
    }
    
    func makeRequest() {
        DispatchQueue.global().async {
            if let url = URL(string: "https://http.cat/\(self.value)") {
                if let data = try? Data(contentsOf: url) {
                    self.imageData = data
                    
                    if let updated = self.updated {
                        updated()
                    }
                }
            }
        }
    }
}
