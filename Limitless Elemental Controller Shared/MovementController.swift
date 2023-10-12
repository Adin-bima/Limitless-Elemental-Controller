//
//  MovementController.swift
//  Limitless Elemental Controller iOS
//
//  Created by Alidin on 12/10/23.
//

import SpriteKit

class MovementController: SKNode {
	var baseNode: SKShapeNode!
	var knobNode: SKShapeNode!
	
	var baseRadius: CGFloat
	var knobRadius: CGFloat
	
	var isFocused = false
	
	init(baseRadius : CGFloat, knobRadius : CGFloat) {
		self.baseRadius = baseRadius
		self.knobRadius = knobRadius
		super.init()
		
		// Create the base of the analog controller
		baseNode = SKShapeNode(circleOfRadius: baseRadius)
		baseNode.fillColor = SKColor.gray
		baseNode.alpha = 0.5
		addChild(baseNode)
		
		// Create the knob of the analog controller
		knobNode = SKShapeNode(circleOfRadius: knobRadius)
		knobNode.fillColor = SKColor.white.withAlphaComponent(0.5)
		addChild(knobNode)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func updateKnobPosition(_ position: CGPoint) {
		let relativePosition = CGPoint(x: position.x - self.position.x, y: position.y - self.position.y)
		let distance = sqrt(pow(relativePosition.x, 2) + pow(relativePosition.y, 2))
		
		if distance <= baseRadius {
			knobNode.position = relativePosition
		} else {
			let angle = atan2(relativePosition.y, relativePosition.x)
			let x = baseRadius * cos(angle)
			let y = baseRadius * sin(angle)
			knobNode.position = CGPoint(x: x, y: y)
		}
	}
	
	func resetKnobPosition() {
		knobNode.position = CGPoint.zero
		isFocused = false
	}
	
	func focus(){
		self.isFocused = true
	}
	
}
