//
//  CommonViewController.swift
//  Flix
//
//  Created by Pann Cherry on 4/6/22.
//  Copyright © 2022 Pann Cherry. All rights reserved.
//

import UIKit
import AlamofireImage

class CommonViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func configureCustomWhiteNavigationBar(title: String) {
        self.navigationItem.title = title
        self.extendedLayoutIncludesOpaqueBars = true
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .bold)]
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.view.backgroundColor = .white
    }

    func setupRegularTitleNavigationBar(title: String, font: UIFont, color: UIColor) {
        self.navigationItem.title = title
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: color, .font: font]
    }

    func setupLargeTitleNavigationBar(title: String, font: UIFont, color: UIColor) {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = title
        self.navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: color, .font: font]
    }

    func addCutsomLeftNavigationTitle(title: String) {
        let titleLabel = UILabel()
        titleLabel.text = "\(title)"
        titleLabel.sizeToFit()
        titleLabel.textColor = .black
        titleLabel.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        let leftItem = UIBarButtonItem(customView: titleLabel)
        self.navigationItem.leftBarButtonItem = leftItem
        self.navigationItem.largeTitleDisplayMode = .never
    }

    @objc func back() {
        self.navigationController?.popViewController(animated: true)
    }

    func leftNavigationBarCustomBackButton(imageName: String = "Back", selector: Selector = #selector(back)) {
        self.extendedLayoutIncludesOpaqueBars = true
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.tintColor = .black

        let button = UIButton(type: UIButton.ButtonType.custom)
        let origImage = UIImage(named: imageName)
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        button.setImage(tintedImage, for: .normal)
        button.addTarget(self, action: selector, for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItems = [barButton]
    }

    func networkErrorAlert(title:String, message:String, completionHandler: @escaping () -> Void){
        let networkErrorAlert = UIAlertController(title: "Network Error", message: "The internet connection appears to be offline. Please try again later.", preferredStyle: UIAlertController.Style.alert)
        networkErrorAlert.addAction(UIAlertAction(title: "Try again", style: UIAlertAction.Style.default, handler: { (action) in
            completionHandler()
        }))
        self.present(networkErrorAlert, animated: true, completion: nil)
    }


}
