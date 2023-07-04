//
//  DownloadManager.swift
//  mapdownloader
//
//  Created by ankudinov aleksandr on 03.07.2023.
//

import Foundation
import Alamofire

class DownloadManager: AbstractPublisher {
    
    enum FileState {
        case none
        case uploading(Double)
        case dowloaded
    }
    
    private var fileStates = [URL:FileState]()
    
    override init() {
        super.init()
        refreshStatuses()
    }
    
    func state(for region:Region)-> FileState {
        return self.fileStates[region.url] ?? .none
    }
    
    func dowload(region:Region){
        Task {
            let destination: DownloadRequest.Destination = { _, _ in
                let documentsURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
                let fileURL = documentsURL.appendingPathComponent( region.url.absoluteString )
                return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
            }
            
            if let url = URL(string: Constants.downloadPrefix + region.url.absoluteString) {
                AF.download(url,to: destination)
                .downloadProgress { progress in
                    self.fileStates[region.url] = .uploading(progress.fractionCompleted)
                    self.notify(finished: false)
                }
                .responseData { response in
                    self.fileStates[region.url] = .dowloaded
                    self.refreshStatuses()
                    self.notify(finished: true)
                }
            }
        }
    }
    
    func refreshStatuses(){
        let documentsURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]

        do {
            let items = try FileManager.default.contentsOfDirectory(atPath: documentsURL.absoluteString)
            for item in items {
                if let fileName = item.components(separatedBy: ".").last, let url = URL(string: fileName) {
                    self.fileStates[url] = .dowloaded
                }
            }
        } catch {
            print(error)
        }
    }
}
