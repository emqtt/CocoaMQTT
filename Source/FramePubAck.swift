//
//  FramePuback.swift
//  CocoaMQTT
//
//  Created by JianBo on 2019/8/7.
//  Copyright © 2019 emqtt.io. All rights reserved.
//

import Foundation


/// MQTT PUBACK packet
struct FramePubAck: Frame {
    
    // -- Inherit
    
    var fixedHeader: UInt8 = FrameType.puback.rawValue
    
    var variableHeader: [UInt8] = []
    
    var payload: [UInt8] = []
    
    // -- Inherit end
    
    var msgid: UInt16
    
    init(msgid: UInt16) {
        self.msgid = msgid
    }
    
    func bytes() -> [UInt8] {
        return [fixedHeader, 0x02] + msgid.hlBytes
    }
    
    func pack() { /* won't use */ }
}


extension FramePubAck: InitialWithBytes {
    
    init?(fixedHeader: UInt8, bytes: [UInt8]) {
        guard fixedHeader == FrameType.puback.rawValue else {
            return nil
        }
        guard bytes.count == 2 else {
            return nil
        }
        
        msgid = UInt16(bytes[0]) << 8 + UInt16(bytes[1])
    }
}
