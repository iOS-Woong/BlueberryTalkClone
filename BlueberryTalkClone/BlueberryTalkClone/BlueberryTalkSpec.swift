//
//  BluberryTalkSpec.swift
//  BlueberryTalkClone
//
//  Created by 서현웅 on 2023/05/23.
//

import Foundation
import CoreBluetooth

struct BlueberryTalkSpec {
    // Service UUID
    static let serviceUUID = CBUUID(string: "5B8CDEB7-2463-429C-BE44-706ECE3C7F71")
    // Characteristic UUID
    static let rxUUID = CBUUID(string: "A0F1631D-6E57-4C62-BA7D-94074B66E426")

}
