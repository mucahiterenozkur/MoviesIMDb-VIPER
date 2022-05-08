//
//  BaseViewController.swift
//  MoviesIMDb
//
//  Created by Mücahit Eren Özkur on 25.04.2022.
//

import UIKit

public class BaseViewController: UIViewController {

    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    internal func showAlert(title:String, message:String) {
        
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Warning", message: "There is no internet connection.", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
        
    }

}
