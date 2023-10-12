//
//  CGFloat+Extensions.swift
//  Limitless Elemental Controller iOS
//
//  Created by Alidin on 12/10/23.
//

import Foundation

extension CGFloat {
	func degreesToRadians() -> CGFloat {
		return self * CGFloat.pi / 180.0
	}
}

extension Double {
	func degreesToRadians() -> CGFloat {
		return self * CGFloat.pi / 180.0
	}
}
