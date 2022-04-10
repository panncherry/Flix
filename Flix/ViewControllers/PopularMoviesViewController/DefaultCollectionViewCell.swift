//
//  DefaultCollectionViewCell.swift
//  Flix
//
//  Created by Pann Cherry on 4/10/22.
//  Copyright © 2022 Pann Cherry. All rights reserved.
//

import UIKit

class DefaultCollectionViewCell: UICollectionViewCell {

    static var nibName = "DefaultCollectionViewCell"
    static var identifier = "DefaultCollectionViewCell"

    @IBOutlet weak var textLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }

}
