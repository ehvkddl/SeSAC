//
//  PaddingLabel.swift
//  TMDB
//
//  Created by do hee kim on 2023/08/13.
//

import UIKit

class PaddingLabel: UILabel {
    
    var padding: UIEdgeInsets = .zero
    
    override func drawText(in rect: CGRect) {
        let insets = padding
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + padding.left + padding.right, height: size.height + padding.top + padding.bottom)
    }
    
    override var bounds: CGRect {
        didSet { preferredMaxLayoutWidth = bounds.width - (padding.left + padding.right) }
    }
    
}
