//
//  NSColor+Extensions.swift
//  Haauti
//
//  Created by Perceval FARAMAZ on 23/02/2018.
//  Copyright © 2018 deicoon. All rights reserved.
//

import Cocoa

extension NSColor {
    
    /// Creates a NSColor from "#XXXXXX"/"XXXXXX" format
    convenience init(hex: String, alpha: CGFloat = 1) {
        // TODO: Validate hex string is in the "#XXXXXX" or "XXXXXX" format
        
        let scanner = Scanner(string: hex)
        scanner.scanLocation = hex[hex.startIndex] == "#" ? 1 : 0
        
        var rgb: UInt32 = 0
        scanner.scanHexInt32(&rgb)
        
        self.init(red: CGFloat((rgb & 0xFF0000) >> 16)/255.0, green: CGFloat((rgb & 0xFF00) >> 8)/255.0, blue: CGFloat(rgb & 0xFF)/255.0, alpha: alpha)
    }
    
    func textColor() -> NSColor {
        var red     : CGFloat = 0
        var green   : CGFloat = 0
        var blue    : CGFloat = 0
        var alpha   : CGFloat = 0
        
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        let colorBrightness : CGFloat = ((red * 299) + (green * 587) + (blue * 114)) / 1000;
        if (colorBrightness < 0.5) {
            return NSColor.black
        }
        else {
            return NSColor.white
        }
    }
    
    func lighter(amount : CGFloat = 0.25) -> NSColor {
        return hueColor(brightnessAmount: 1 + amount)
    }
    
    func darker(amount : CGFloat = 0.25) -> NSColor {
        return hueColor(brightnessAmount: 1 - amount)
    }
    
    private func hueColor(brightnessAmount: CGFloat) -> NSColor {
        var hue         : CGFloat = 0
        var saturation  : CGFloat = 0
        var brightness  : CGFloat = 0
        var alpha       : CGFloat = 0
        
        let color = usingColorSpaceName(NSColorSpaceName.calibratedRGB)
        color?.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        
        return NSColor( hue: hue,
                        saturation: saturation - brightnessAmount/3,
                        brightness: brightness * brightnessAmount,
                        alpha: alpha )
        
    }
    
}
