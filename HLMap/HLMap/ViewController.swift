//
//  ViewController.swift
//  HLMap
//
//  Created by 黄露 on 2017/1/17.
//  Copyright © 2017年 黄露. All rights reserved.
//

import UIKit

class ViewController: UIViewController , BMKMapViewDelegate {

    @IBOutlet weak var bMap: BMKMapView!
    
    @IBOutlet weak var destinationTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bMap.showsUserLocation = true
//        self.bMap.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}

