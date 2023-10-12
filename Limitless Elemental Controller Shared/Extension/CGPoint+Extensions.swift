//
//  CGPoint.swift
//  Limitless Elemental
//
//  Created by Bisma Mahendra I Dewa Gede on 10/10/23.
//

import Foundation

extension CGPoint {
	static func - (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
		return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
	}
	
	static func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
		return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
	}


	static func * (lhs: CGPoint, rhs: Double) -> CGPoint {
		return CGPoint(x: lhs.x * rhs, y: lhs.y * rhs)
	}
	
	static func / (lhs: CGPoint, rhs: Double) -> CGPoint {
		return CGPoint(x: lhs.x / rhs, y: lhs.y / rhs)
	}

	func normalized() -> CGPoint {
		let length = sqrt(pow(self.x, 2) + pow(self.y, 2))
		return CGPoint(x: self.x / length , y: self.y / length)
	}
	
	func distance(to point: CGPoint) -> CGFloat {
		let dx = self.x - point.x
		let dy = self.y - point.y
		return sqrt(dx * dx + dy * dy)
	}
}
