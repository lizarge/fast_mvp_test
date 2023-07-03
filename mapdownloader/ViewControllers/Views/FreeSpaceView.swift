//
//  FreeSpaceView.swift
//  mapdownloader
//
//  Created by ankudinov aleksandr on 03.07.2023.
//

import UIKit

class FreeSpaceView: UIView {

    @IBOutlet weak var freeSpaceLabel: UILabel!
    @IBOutlet weak var freeSpaceProgress: UIProgressView!
    
    func updateWith(discStatus:DiskStatus){
        freeSpaceLabel.text = "Free \(DiskStatus.freeDiskSpace)"
        freeSpaceProgress.setProgress(
            Float( DiskStatus.usedDiskSpaceInBytes  / DiskStatus.totalDiskSpaceInBytes  ),
            animated: true)
    }
}



