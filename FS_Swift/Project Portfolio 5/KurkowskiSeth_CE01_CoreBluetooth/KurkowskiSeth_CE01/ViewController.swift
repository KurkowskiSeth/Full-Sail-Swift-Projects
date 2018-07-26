//
//  ViewController.swift
//  KurkowskiSeth_CE01
//
//  Created by Seth Kurkowski on 3/4/18.
//  Copyright © 2018 Seth Kurkowski. All rights reserved.
//

import UIKit
import CoreBluetooth

class ViewController: UIViewController, CBPeripheralManagerDelegate{
    
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn5: UIButton!
    @IBOutlet weak var btn6: UIButton!
    
    let TRANSFER_SERVICE_UUID = CBUUID(string: "06B280C1-419D-4D87-810E-00D88B506717")
    let TRANSFER_CHARACTERISTIC_UUID = CBUUID(string: "CD570797-087C-4008-B692-7835A1246377")
    
    var mutableService: CBMutableService?
    var mutableCharacteristic: CBMutableCharacteristic?
    var peripheralManager: CBPeripheralManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Instantiate manager, service, and characteristics.
        peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
        mutableService = CBMutableService(type: TRANSFER_SERVICE_UUID, primary: true)
        mutableCharacteristic = CBMutableCharacteristic(type: TRANSFER_CHARACTERISTIC_UUID, properties: .notify, value: nil, permissions: .readable)
    }
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        if peripheral.state != .poweredOn {
            print("Bluetooth powered off")
        } else {
            print("Bluetooth powered on")
            // Add charateristis to the service and add the service to the manager then advertise to try to connect to the app.
            mutableService?.characteristics = [mutableCharacteristic!]
            peripheralManager?.add(mutableService!)
            peripheralManager?.startAdvertising([CBAdvertisementDataServiceUUIDsKey:[TRANSFER_SERVICE_UUID]])
        }
    }
    
    func peripheralManager(_ peripheral: CBPeripheralManager, central: CBCentral, didSubscribeTo characteristic: CBCharacteristic) {
        print("Subscribed")
        
        btn1.isEnabled = true
        btn2.isEnabled = true
        btn3.isEnabled = true
        btn4.isEnabled = true
        btn5.isEnabled = true
        btn6.isEnabled = true
    }

    @IBAction func buttonTouched(_ sender: UIButton) {
        // Update characteristic value back 
        let selectedBtn = String(sender.tag)
        let sendValue = selectedBtn.data(using: String.Encoding.utf8)
        print("conncectedCentral")
        peripheralManager?.updateValue(sendValue!, for: mutableCharacteristic!, onSubscribedCentrals: nil)
    }
}

