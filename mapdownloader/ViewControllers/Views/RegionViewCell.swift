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
    
    let downloadManager = DependencyManager.resolve(DownloadManager.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        downloadManager.subscribe(self)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func fill(with region:Region?) {
        
        self.region = region
        
        regionNameLabel.text = region?.name.replacingOccurrences(of: "-", with: " ").capitalized
        
        if let region = region {
            updateState(dm: self.downloadManager, region: region)
        }
        
    }
    
    func updateState(dm:DownloadManager, region:Region){
        switch dm.state(for: region) {
        case .dowloaded:
            regionNameLabelContrains.constant = 12
            self.downloadProgressView.isHidden = true
            self.disclosureImageView.isHidden = true
            self.dowloadImageView.isHidden = true
            self.iconImageView.image = #imageLiteral(resourceName: "ic_custom_map").withTintColor(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1).withAlphaComponent(0.8))
        case .uploading(let progress):
            regionNameLabelContrains.constant = 6
            self.disclosureImageView.isHidden = true
            self.downloadProgressView.isHidden = false
            self.dowloadImageView.isHidden = true
            self.downloadProgressView.progress = Float(progress)
            self.iconImageView.image = #imageLiteral(resourceName: "ic_custom_map")
        case .none:
            regionNameLabelContrains.constant = 12
            self.downloadProgressView.isHidden = true
            self.dowloadImageView.isHidden = (region.regions?.count != 0)
            self.disclosureImageView.isHidden = (region.regions?.count == 0)
            self.iconImageView.image = #imageLiteral(resourceName: "ic_custom_map")
        }
    }
}

extension RegionViewCell:Subscriber {
    func updateDownloadState(subject: AbstractPublisher, finished: Bool) {
        if let dm = subject as? DownloadManager, let region = self.region {
            DispatchQueue.main.async {
                self.updateState(dm: dm, region: region)
            }
        }
    }
}
