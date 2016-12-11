//
//  ServerViewController.swift
//  ExemploComunicacaoTvOS
//
//  Created by Gustavo Henrique on 07/11/16.
//  Copyright © 2016 Gustavo Henrique. All rights reserved.
//

import UIKit

class ServerViewController: UIViewController, GCDAsyncSocketDelegate {

    @IBOutlet weak var label: UILabel!
    
    var server : GCDAsyncSocket!
    
    var connectedClients = NSMutableSet()
    
    var netService = NetService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        server = GCDAsyncSocket(delegate: self, delegateQueue: DispatchQueue.main)
        
        let service = Foundation.NetService()
        
        
        do{
            try server.accept(onPort: 50000)
            netService.publish(server.localPort)
        }catch{
        
        }
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Server
    func socket(_ sock: GCDAsyncSocket!, didAcceptNewSocket newSocket: GCDAsyncSocket!) {
        print(#function)
        connectedClients.add(newSocket)
        newSocket.readData(to: GCDAsyncSocket.crlfData(), withTimeout: -1, tag: 0)
    }

    func socketDidDisconnect(_ sock: GCDAsyncSocket!, withError err: NSError!) {
        print(#function)
        connectedClients.remove(sock)
    }
    
    func socket(_ sock: GCDAsyncSocket!, didRead data: Data!, withTag tag: Int) {
        print(#function)
        
        self.label.text = "Recebi dados do socket!"
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
