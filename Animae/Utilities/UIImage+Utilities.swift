//
//  UIImage+Utilities.swift
//  Animae
//
//  Created by João Pedro Rocha on 22/11/24.
//

import UIKit

// Caso precise um dia, essa função pega a cor da imagem.

extension UIImage {
  func dominantColor() -> UIColor? {
    guard let cgImage = self.cgImage else { return nil }

    let width = 1
    let height = 1
    let bitmapInfo = CGImageAlphaInfo.premultipliedLast.rawValue
    let colorSpace = CGColorSpaceCreateDeviceRGB()
    
    var pixelData = [UInt8](repeating: 0, count: 4)
    guard let context = CGContext(data:
      &pixelData, width: width, height: height, bitsPerComponent: 8, bytesPerRow: width * 4, space: colorSpace, bitmapInfo: bitmapInfo)
    else {
      return nil
    };
          
    context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
    
    let red = CGFloat(pixelData[0]) / 255.0
    let green = CGFloat(pixelData[1]) / 255.0
    let blue = CGFloat(pixelData[2]) / 255.0
    
    return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
  };
};
