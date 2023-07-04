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
    
    func dowload(region:Region, downloadPrefix anotherBoringPrefix:String = ""){
        Task {
            let destination: DownloadRequest.Destination = { _, _ in
                let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                let fileURL = documentsURL.appendingPathComponent( region.url.absoluteString )
                return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
            }
            
            if let url = URL(string: Constants.downloadPrefix + region.url.absoluteString + anotherBoringPrefix + Constants.fileNamePostfix ) {
                
                print(url)
                
                self.fileStates[region.url] = .uploading(0)
                self.notify(finished: true)
                
                AF.download(url,to: destination)
                .downloadProgress { progress in
                    self.fileStates[region.url] = .uploading(progress.fractionCompleted)
                    self.notify(finished: false)
                }
                .responseData { response in
                    var statusCode = response.response?.statusCode
                    
                    if statusCode != 200 {
                        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                        let fileURL = documentsURL.appendingPathComponent( region.url.absoluteString )
                        try? FileManager.default.removeItem(at: documentsURL)
                    }
                    
                    self.fileStates[region.url] = statusCode == 200 ? .dowloaded : .none
                    self.refreshStatuses()
                    self.notify(finished: true)
           
                }
            }
        }
    }
    
    func refreshStatuses(){
        
        do {
            // Get the document directory url
            let documentDirectory = try FileManager.default.url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: true
            )
           
            let directoryContents = try FileManager.default.contentsOfDirectory(
                at: documentDirectory,
                includingPropertiesForKeys: nil
            )
        
            let items = directoryContents.map { $0.lastPathComponent }
            
            for item in items {
                if let url = URL(string: item) {
                    self.fileStates[url] = .dowloaded
                }
            }
            
        } catch {
            print(error)
        }
        
    }
}
