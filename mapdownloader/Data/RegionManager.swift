//
//  RegionManager.swift
//  mapdownloader
//
//  Created by ankudinov aleksandr on 03.07.2023.
//

import Foundation
import UIKit
import SwiftyXMLParser

class RegionManager:NSObject {
    
    private(set) var regionList:[Region]?
    
    func loadAndParse() async -> [Region]?   {
        if let asset = Constants.datasourceXML {
            regionList = packToStatic(rootRegion: XML.parse(asset.data).regions_list)
        }
        return regionList
    }
    
    //упакуем все в человеческую модель для скорости и экономии
    func packToStatic(rootRegion: XML.Accessor) -> [Region]  {
        var regions = [Region]()
        for element in rootRegion.region {
            if let name = element.attributes[Constants.nameFieldName] {
                var region = Region(name: name)
                region.regions = packToStatic(rootRegion: element)
                regions.append(region)
            }
        }
        
        return regions
    }

}
