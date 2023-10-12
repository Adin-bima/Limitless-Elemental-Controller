//
//  RoundedRectangleNode.swift
//  Limitless Elemental Controller iOS
//
//  Created by Alidin on 12/10/23.
//

import SpriteKit

class RoundedRectangleButton: SKSpriteNode {
	var foregroundColor : SKColor = .white
	var labelNode : SKLabelNode!
	
	init(size: CGSize, cornerRadius: CGFloat, bgColor: SKColor, labelText: String) {
		super.init(texture: nil, color: .clear, size: size)
		self.name = "roundedRectangleButton"
		
		// Create the rounded rectangle shape
		let roundedRectangle = SKShapeNode(rectOf: size, cornerRadius: cornerRadius)
		roundedRectangle.fillColor = bgColor
		roundedRectangle.strokeColor = color
		roundedRectangle.position = CGPoint(x: 0, y: 0)
		self.addChild(roundedRectangle)
		
		// Create the label node
		labelNode = SKLabelNode(text: labelText)
		labelNode.fontName = "Helvetica"
		labelNode.fontSize = 14
		labelNode.fontColor = foregroundColor
		labelNode.position = CGPoint(x: 0, y: -labelNode.frame.size.height / 2)
		self.addChild(labelNode)
	}
	
	func setForegroundColor(color : SKColor){
		labelNode.fontColor = color
	}
	
	func setFontSize(size : Double){
		labelNode.fontSize = size
	}
	
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

