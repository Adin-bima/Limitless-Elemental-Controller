//
//  CircularTriangleButton.swift
//  Limitless Elemental Controller iOS
//
//  Created by Alidin on 12/10/23.
//

import SpriteKit

class CircularTriangleButton: SKSpriteNode {
	
	init(radius: CGFloat) {
		super.init(texture: nil, color: .clear, size: CGSize(width: radius * 2, height: radius * 2))
		self.name = "CircularButton"
		
		// Create circular shape
		let circleShape = SKShapeNode(circleOfRadius: radius + 12)
		circleShape.fillColor = .gray.withAlphaComponent(0.5)
		circleShape.strokeColor = .white
		circleShape.lineWidth = 5
		addChild(circleShape)
		
		// Create equilateral triangle
		let trianglePath = UIBezierPath()
		let triangleSize = radius * sqrt(3)  // Height of an equilateral triangle
		trianglePath.move(to: CGPoint(x: 0, y: -radius))
		trianglePath.addLine(to: CGPoint(x: -triangleSize / 2, y: radius / 2))
		trianglePath.addLine(to: CGPoint(x: triangleSize / 2, y: radius / 2))
		trianglePath.close()
		
		let triangleShape = SKShapeNode(path: trianglePath.cgPath)
		triangleShape.yScale = -1
		triangleShape.fillColor = .white.withAlphaComponent(0.5)
		addChild(triangleShape)
	}


	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}






