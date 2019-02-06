//
//  ViewController.swift
//  BedgeNotificHub
//
//  Created by jogendra on 02/06/2019.
//  Copyright (c) 2019 jogendra. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var hub: BedgeNotificHub?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupButton()
        setupImageView()
    }

    func setupButton() {
        let color = UIColor(red: 255/255, green: 47/255, blue: 146/255, alpha: 1)

        let button = UIButton(frame: CGRect(x: view.frame.size.width / 2 - 75, y: 200, width: 150, height: 44))
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitle("Increment", for: .normal)
        button.backgroundColor = color
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(self.testIncrement), for: .touchUpInside)

        view.addSubview(button)
    }

    func setupImageView() {
        let imageView = UIImageView(image: UIImage(named: "github_color"))
        imageView.frame = CGRect(x: view.frame.size.width / 2 - 48, y: 80, width: 96, height: 96)

        hub = BedgeNotificHub(view: imageView)
        hub?.moveCircleBy(x: -15, y: 15)

        view.addSubview(imageView)
    }

    @objc func testIncrement() {
        hub?.increment()
        hub?.pop()
    }

}

