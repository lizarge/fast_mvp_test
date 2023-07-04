//
//  AbstractSuscriber.swift
//  mapdownloader
//
//  Created by ankudinov aleksandr on 04.07.2023.
//

import Foundation

protocol Subscriber : AnyObject {
    func updateDownloadState(subject : AbstractPublisher, finished:Bool)
}

struct WeakSubscriber {
    weak var value : Subscriber?
}


class AbstractPublisher {
    private lazy var subscribers : [WeakSubscriber] = [] // Создаем массив с подписчиками
        
    func subscribe(_ subscriber: Subscriber) {
        subscriber.updateDownloadState(subject: self, finished: true)
        subscribers.append(WeakSubscriber(value: subscriber))
    }
    
    func unsubscribe(_ subscriber: Subscriber) {
        subscribers.removeAll(where: { $0.value === subscriber })
    }
    
    func notify(finished:Bool?) {
        subscribers.forEach { $0.value?.updateDownloadState(subject: self, finished:true ) }
    }
}
