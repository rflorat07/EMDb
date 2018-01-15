//
//  ViewController.swift
//  EMDb
//
//  Created by Roger Florat on 15/01/18.
//  Copyright © 2018 Roger Florat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let remote = RemoteiTunesMovieService()
        
        remote.getTopMovies { (result) in
            
            if let result = result {
                print(result)
            }
            
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

