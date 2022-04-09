//
//  PillSegmentedControl.swift
//  Flix
//
//  Created by Pann Cherry on 4/9/22.
//  Copyright © 2022 Pann Cherry. All rights reserved.
//

import UIKit

@IBDesignable
class PillSegmentedControl: UISegmentedControl {

    override func layoutSubviews() {
        super.layoutSubviews()

        for view in self.subviews {
            view.clipsToBounds = true
            view.layer.cornerRadius = 12
        }
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.configure()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }

    override init(items: [Any]?) {
        super.init(items: items)
        self.commonInit()
    }

    private func commonInit() {
        self.configure()
    }

    // Disable swipe gesture to select segment to work with ScrollView
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

    func configure() {
        self.setFontStyle()
        self.clipsToBounds = true
        self.layer.cornerRadius = 12
        self.setCornerRadius(radius: 12)
        self.setSegmentBorder(width: 1, color: .black)
        self.setSegmentColors()
    }

    func setCornerRadius(radius: CGFloat) {
        for view in self.subviews {
            view.clipsToBounds = true
            view.layer.cornerRadius = radius
        }
    }

    func setSegmentBorder(width: CGFloat, color: UIColor) {
        for view in self.subviews {
            view.layer.borderWidth = width
            view.layer.borderColor = color.cgColor
        }

        self.layer.backgroundColor = UIColor.white.cgColor
    }

    func setFontStyle() {
        self.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .light), NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
        self.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .light), NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
    }

    func setSegmentColors() {
        self.setBackgroundImage(UIImage(color: .white, size: CGSize(width: 100, height: 30))?.rounded(radius: 12), for: .normal, barMetrics: .default)
        self.setBackgroundImage(UIImage(color: UIColor.lightGray.withAlphaComponent(0.5), size: CGSize(width: 100, height: 30))?.rounded(radius: 12), for: .selected, barMetrics: .default)
        self.setBackgroundImage(UIImage(color: UIColor.lightGray.withAlphaComponent(0.5), size: CGSize(width: 100, height: 30))?.rounded(radius: 12), for: .highlighted, barMetrics: .default)

        let dividerImage = UIColor.clear.image(size: CGSize(width: 8, height: 30))
        self.setDividerImage(dividerImage, forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
    }

}
