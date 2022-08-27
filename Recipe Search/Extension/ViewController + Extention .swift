//
//  ViewController + Extention .swift
//  Recipe Search
//
//  Created by Radwa on 26/08/2022.
//

import Foundation
import UIKit
import NVActivityIndicatorView

extension UIViewController{
    func showActivityIndicator(indicator: NVActivityIndicatorView? ,startIndicator: Bool){
        guard let indicator = indicator else {return}
        DispatchQueue.main.async {
            indicator.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(indicator)
            
            NSLayoutConstraint.activate([
                indicator.widthAnchor.constraint(equalToConstant: 40),
                indicator.heightAnchor.constraint(equalToConstant: 40),
                indicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
                indicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
            ])
        }
        if startIndicator{
            indicator.startAnimating()
        }else{
            indicator.stopAnimating()
        }
    }
}
