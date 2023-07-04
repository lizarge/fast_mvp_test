//
//  Constants.swift
//  mapdownloader
//
//  Created by ankudinov aleksandr on 04.07.2023.
//

import Foundation
import UIKit

class Constants {
    //main
    static let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    //ui
    static let tableViewHeaderHeight:CGFloat = 38
    static let regionCellReuseID = "RegionViewCell"
    static let regionViewController = "RegionViewController"
    
    //xml
    static let datasourceXML = NSDataAsset(name: "Regions")
    static let nameFieldName = "name"
    
    static func getRegionViewController()->RegionViewController? {
        return Constants.mainStoryboard.instantiateViewController(withIdentifier:
                                                Constants.regionViewController) as? RegionViewController
    }
}

