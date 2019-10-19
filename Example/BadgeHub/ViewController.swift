//
//  ViewController.swift
//  BadgeHub
//
//  Created by jogendra on 05/31/2019.
//  Copyright (c) 2019 jogendra. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var hub: BadgeHub?
    var hub2: BadgeHub?
    
    @IBOutlet weak var barItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupButton()
        setupImageView()
        setupBarButtomItem()
    }

    func setupButton() {
        let color = UIColor(red: 255/255, green: 47/255, blue: 146/255, alpha: 1)
        let navigationHeight: CGFloat = self.navigationController?.navigationBar.frame.size.height ?? 0
        let button = UIButton(frame: CGRect(x: view.frame.size.width / 2 - 75, y: 200 + navigationHeight, width: 150, height: 44))
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitle("Increment", for: .normal)
        button.backgroundColor = color
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(self.testIncrement), for: .touchUpInside)

        view.addSubview(button)
    }

    func setupImageView() {
        let imageView = UIImageView(image: UIImage(named: "github_color"))
        let navigationHeight: CGFloat = self.navigationController?.navigationBar.frame.size.height ?? 0
        imageView.frame = CGRect(x: view.frame.size.width / 2 - 48, y: 80 + navigationHeight, width: 96, height: 96)

        hub = BadgeHub(view: imageView)
        hub?.moveCircleBy(x: -15, y: 15)

        view.addSubview(imageView)
    }
    
    func setupBarButtomItem(){
         hub2 = BadgeHub(barButtonItem: barItem)
    }

    @objc func testIncrement() {
        hub2?.increment()
        hub2?.pop()
        hub?.increment()
        hub?.pop()
    }

}
