//
//  NavigationController.swift
//  mapdownloader
//
//  Created by ankudinov aleksandr on 03.07.2023.
//

import UIKit
import ProgressHUD

class EntryViewController: UINavigationController {

    let regionManager = DependencyManager.resolve(RegionManager.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationBar.prefersLargeTitles = true
       
        let appearance =  UINavigationBar.appearance()
        appearance.backgroundColor = UIColor(named: "navbar")
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        appearance.isTranslucent = false
        appearance.tintColor = .white
        
        UIApplication.shared.statusBarUIView?.backgroundColor = appearance.backgroundColor
        
        Task {
            if let regionViewController = Constants.getRegionViewController()  {
                regionViewController.regionList = await regionManager.loadAndParse()
                self.pushViewController(regionViewController, animated: true)
            }
        }
        
        ProgressHUD.show(icon: .bolt)
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .darkContent
    }

}
