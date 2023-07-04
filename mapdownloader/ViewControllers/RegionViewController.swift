//
//  RegionViewController.swift
//  mapdownloader
//
//  Created by ankudinov aleksandr on 03.07.2023.
//

import UIKit
import Swinject

class RegionViewController: UITableViewController {

    let discStatus = DependencyManager.resolve(DiskStatus.self)
   
    var isSecondaryController = false 
    var regionList:[Region]? {
        didSet{
            self.tableView.reloadData()
        }
    }
    
    @IBOutlet weak var deviceMemoryView: FreeSpaceView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
        
        self.deviceMemoryView.updateWith(discStatus: discStatus)
        
        self.tableView?.tableHeaderView = isSecondaryController ? nil : deviceMemoryView
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return regionList?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return regionList?[section].regions?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return isSecondaryController ? "REGIONS" : regionList?[section].name
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:
                                                    Constants.regionCellReuseID,
                                                 for: indexPath) as? RegionViewCell
        
        cell?.fill(with: regionList?[indexPath.section].regions?[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.tableViewHeaderHeight
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        if let regionViewController = Constants.getRegionViewController() {
            if let region = regionList?[indexPath.section].regions?[indexPath.row], let regions = region.regions, regions.count > 0 {
                regionViewController.isSecondaryController = true
                regionViewController.regionList = [region]
                regionViewController.title = regionList?[indexPath.section].regions?[indexPath.row].name
                self.navigationController?.pushViewController(regionViewController, animated: true)
            }
        }
    }
    
}
