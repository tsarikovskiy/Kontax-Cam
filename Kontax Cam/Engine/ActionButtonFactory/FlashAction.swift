//
//  FlashAction.swift
//  Kontax Cam
//
//  Created by Kevin Laminto on 23/5/20.
//  Copyright © 2020 Kevin Laminto. All rights reserved.
//

import UIKit

class FlashAction: UIButton {
    
    private let flash = ["", "bolt.slash", "bolt", "bolt.badge.a"]

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setImage(getIcon(currentIcon: nil).0, for: .normal)
        self.addTarget(self, action: #selector(flashTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func flashTapped() {
        TapticHelper.shared.lightTaptic()
        let (image, index) = getIcon(currentIcon: self.imageView?.image?.accessibilityIdentifier!)
        self.setImage(image, for: .normal)
        
        switch index {
        case 1: CameraActionView.cameraManager.flashMode = .off
        case 2: CameraActionView.cameraManager.flashMode = .on
        case 3: CameraActionView.cameraManager.flashMode = .auto
        default: fatalError("Invalid index")
        }
    }
    
    private func getIcon(currentIcon: String?) -> (UIImage, Int?) {
        let currentIcon = currentIcon == nil ? flash[0] : currentIcon
        var nextIndex = flash.firstIndex{ $0 == currentIcon }! + 1
        nextIndex = nextIndex >= flash.count ? 1 : nextIndex
        
        let image = IconHelper.shared.getIconImage(iconName: flash[nextIndex])
        image.accessibilityIdentifier = flash[nextIndex]
        
        return (image, nextIndex)
    }
}
