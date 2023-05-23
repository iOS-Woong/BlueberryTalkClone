//
//  BlueberryChatService.swift
//  BlueberryTalkClone
//
//  Created by 서현웅 on 2023/05/23.
//

import Foundation
import CoreBluetooth

class BlueberryChatService: NSObject, ObservableObject {
    var centralManager: CBCentralManager!
    var peripheralManager: CBPeripheralManager!
    
    
    init(peripheralManager: CBPeripheralManager!) {
        super.init()
        self.centralManager = CBCentralManager(delegate: self, queue: nil)
        self.peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
        
        initService()
    }
    
    func initService() {
        let chatService = CBMutableService(type: BlueberryTalkSpec.serviceUUID,
                                           primary: true) // Service 객체
        let rxCharacteristic = CBMutableCharacteristic(type: BlueberryTalkSpec.rxUUID,
                                                       properties: .write,
                                                       value: nil,
                                                       permissions: .writeable) // Characteristic 객체
        chatService.characteristics = [rxCharacteristic]
        peripheralManager.add(chatService)
    }
    
}

//MARK: CBCentralManager Delegate 관련
extension BlueberryChatService: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        //
    }
}

//MARK: CBperipheralManager Delegate 관련
extension BlueberryChatService: CBPeripheralManagerDelegate {
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        //
    }
    
    
}

