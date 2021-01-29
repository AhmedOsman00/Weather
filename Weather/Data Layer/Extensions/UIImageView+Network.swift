//
//  UIImageView+Extensions.swift
//  MondiaMedia
//
//  Created by Ahmed Osman on 11/22/19.
//  Copyright © 2019 Ahmed Osman. All rights reserved.
//

import UIKit

extension UIImageView {
    func setImage(url: String, placeholder: String? = nil) {
        self.image = UIImage(named: placeholder ?? "")
        guard let url = URL(string: url) else { return }
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, !data.isEmpty, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                }
            } else {
                DispatchQueue.main.async {
                    self.image = UIImage(named: placeholder ?? "")
                }
            }
        }
        dataTask.resume()
    }
}
