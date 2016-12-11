//
//  BrowserViewController.swift
//  ExemploComunicacao
//
//  Created by Gustavo Henrique on 07/11/16.
//  Copyright © 2016 Gustavo Henrique. All rights reserved.
//
import Foundation
import UIKit


class BrowserViewController: UIViewController, NetServiceBrowserDelegate,NetServiceDelegate, GCDAsyncSocketDelegate {
    
    var browser = NetServiceBrowser()
    var servidores = NSMutableArray()
    var socket: GCDAsyncSocket! = nil

    override func viewDidLoad() {
        search()
        setupConnection()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func search(){
        
        browser.delegate = self
        browser.searchForServices(ofType: "_exemplo._tcp", inDomain: "local")
    }
    
    
    func netServiceBrowser(_ browser: NetServiceBrowser, didFind service: NetService, moreComing: Bool) {
        servidores.add(service)
        service.delegate = self
        service.resolve(withTimeout: 500)
        
    }
    
    
    func netServiceBrowser(_ browser: NetServiceBrowser, didRemove service: NetService, moreComing: Bool) {
        print(#function,service.addresses?.first?.description as Any)
        
    }
    
    
    func netServiceDidResolveAddress(_ sender: NetService) {
        if sender.addresses?.first != nil {
            do{
                try socket.connect(toAddress: sender.addresses?.first, withTimeout: -1.0)
            }catch let erro{
                print(erro)
            }
        }
    }
    
}

extension BrowserViewController {

    func setupConnection() {
        
        print("Testando conectividade")
        if (socket == nil) {
            socket = GCDAsyncSocket(delegate: self, delegateQueue: DispatchQueue.main)
        } else {
            socket.disconnect()
        }
    }
    
    func send(msgBytes: Data){
        socket.write(msgBytes, withTimeout: -1.0, tag: 0)
        socket.write(GCDAsyncSocket.crlfData(), withTimeout: -1.0, tag: 0)
        socket.readData(withTimeout: -1.0, tag: 0)
    }
    
    
    func socket(sock: GCDAsyncSocket!, didConnectToHost host: String!, port: UInt16) {
        print("Conectei com esse \(host) na porta \(port)")
        
        // Forma de enviar dados utilizando o formato de encoding utf 8
        let array = ["Enviando".data(using: String.Encoding.utf8)!,"Dados".data(using: String.Encoding.utf8)!]
        let data = NSKeyedArchiver.archivedData(withRootObject: array)
        
        send(msgBytes: data)
    }

}
