//
//  InterfaceController.swift
//  BitWatch WatchKit Extension
//
//  Created by Adam Lassy on 8/16/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

import WatchKit
import Foundation
import BitWatchKit


class InterfaceController: WKInterfaceController, SpacebrewDelegate {
    
    var sb:Spacebrew?

    let tracker = Tracker()
    var updating = false
    var _count = 0

    @IBOutlet weak var spacebrewOut: WKInterfaceLabel!
    
    @IBAction func btnGo() {
        
        println("button press")

        self.sb!.send("buttonTapped", type: .BrewBool, value: "True")
    }

    private func update() {
    
        spacebrewOut.setText("ASS BUTTS")
    }
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()

        println("Connecting!")
        
        self.sb = Spacebrew(host: "50.112.244.54", name: "Swift Test", description: "This is an iOS app in Swift")
        
        self.sb!.delegate = self
        self.sb!.addPublish("buttonTapped", type: .BrewBool, def: String(0))
        self.sb!.addSubscribe("toggleBackground", type: .BrewBool)
        self.sb!.connect()

    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    /****************************
    // MARK: SpacebrewDelegate
    *****************************/
    
    func spacebrewConnectionOpened() {
        println("Connected!")
    }
    
    func spacebrewConnectionClosed() {
        println("Closed!")
    }
    
    func spacebrewCustomMessageReceived(name: String, value: String, type: String) {
        println("Custom message received!")
    }
    
    func spacebrewRangeMessageReceived(name: String, value: Int) {
        println("Range received!")
    }
    
    func spacebrewStringMessageReceived(name: String, value: String) {
        println("String received!")
    }
    
    func spacebrewBoolMessageReceived(name: String, value: Bool) {
        println("Bool received!")
        
        
        if (value == true) {
            _count = _count + 1

            spacebrewOut.setText("RECEIVED: " + String(_count))
        }
    }
    
    func spacebrewBinaryMessageReceived(name: String, value: String, type: NSMutableData?) {
        println("Binary message received!")
    }

}
