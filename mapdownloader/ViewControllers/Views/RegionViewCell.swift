//
//  RegionViewCell.swift
//  mapdownloader
//
//  Created by ankudinov aleksandr on 04.07.2023.
//

import UIKit

class RegionViewCell: UITableViewCell {

    public var region:Region?
    
    @IBOutlet weak var regionNameLabelContrains: NSLayoutConstraint!
    
    @IBOutlet weak var iconImageView: UIImageView! // 6 - 12
    @IBOutlet weak var regionNameLabel: UILabel!
    @IBOutlet weak var disclosureImageView: UIImageView!
    @IBOutlet weak var downloadProgressView: UIProgressView!
    @IBOutlet weak var dowloadImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func fill(with region:Region?) {
        regionNameLabel.text = region?.name.replacingOccurrences(of: "-", with: " ").capitalized
        
        regionNameLabelContrains.constant = 12
        downloadProgressView.isHidden = true
        
        if let regions = region?.regions, regions.count  > 0 {
            dowloadImageView.isHidden = true
            disclosureImageView.isHidden = false
        } else {
            dowloadImageView.isHidden = false
            disclosureImageView.isHidden = true
        }
        
    }
    
}
