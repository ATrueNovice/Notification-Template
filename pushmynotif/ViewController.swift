//
//  ViewController.swift
//  pushmynotif
//
//  Created by New on 5/19/17.
//  Copyright © 2017 HSI. All rights reserved.
//

import UIKit
import Firebase
import FirebaseInstanceID
import FirebaseMessaging

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        FIRMessaging.messaging().subscribe(toTopic: "/topics/news")
    }

}

