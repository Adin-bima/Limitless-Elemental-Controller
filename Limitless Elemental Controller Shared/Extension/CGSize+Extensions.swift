//
//  CGSize+Extensions.swift
//  Limitless Elemental
//
//  Created by Alidin on 07/10/23.
//

import Foundation

extension CGSize {
	static func / (size: CGSize, divisor: CGFloat) -> CGSize {
		return CGSize(width: size.width / divisor, height: size.height / divisor)
	}
	
	static func + (size : CGSize, adder : CGSize) -> CGSize{
		return CGSize(width: size.width + adder.width, height: size.height + adder.height)
	}
	
	static func - (size : CGSize, subtractor : CGSize) -> CGSize{
		return CGSize(width: size.width - subtractor.width, height: size.height - subtractor.height)
	}
	
	
	
}
