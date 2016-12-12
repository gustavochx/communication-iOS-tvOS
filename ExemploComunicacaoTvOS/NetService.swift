//
//  NetService.swift
//  ExemploComunicacaoTvOS
//
//  Created by Gustavo Henrique on 07/11/16.
//  Copyright © 2016 Gustavo Henrique. All rights reserved.
//


import Foundation
import UIKit

class NetService: NSObject, NetServiceDelegate {
    var service : Foundation.NetService = Foundation.NetService()

    func publish(_ port : UInt16){
        print(#function)
        service = Foundation.NetService(domain: "local", type: "_exemplo._tcp", name: UIDevice.current.identifierForVendor!.uuidString, port: Int32(port))
        service.delegate = self
        service.publish()
    }

    func netServiceWillPublish(_ sender: NetService) {
        print(#function)
    }
    func netServiceDidStop(_ sender: NetService) {
        print(#function)
    }
    func netServiceWillResolve(_ sender: NetService) {
        print(#function)
    }
    func netService(_ sender: NetService, didUpdateTXTRecord data: Data) {
        print(#function)
    }

}
