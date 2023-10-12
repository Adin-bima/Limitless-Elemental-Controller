//
//  SkillController.swift
//  Limitless Elemental Controller iOS
//
//  Created by Alidin on 12/10/23.
//

import SpriteKit

class SkillController: SKNode {
	var baseNode: SKShapeNode!
	var knobNode: SKShapeNode!
	var baseRadius: CGFloat
	var knobRadius: CGFloat
	var isFocused = false
	var cooldown = 5
	
	var amountOfSkill = 5
	var amountOfSkillLeft = 5
	
	var skillCircles : [SKShapeNode] = []
	
	private let skillCircleRadius: CGFloat = 10.0  // Radius of the skill circle
	private let skillCircleSpacing: CGFloat = 15.0

	
	var currentCountdown: Int {
		didSet {
			// Update countdownTextNode text and visibility
			countdownTextNode.text = currentCountdown > 0 ? "\(currentCountdown)" : ""
			countdownTextNode.isHidden = currentCountdown == 0
			if(currentCountdown > 0 ){
				knobNode.fillColor = .black.withAlphaComponent(0.5)
			}else{
				knobNode.fillColor = .systemTeal.withAlphaComponent(0.5)
			}
		}
	}
	
	
	var countdownTextNode : SKLabelNode
		
	init(baseRadius : CGFloat, knobRadius : CGFloat) {
		self.baseRadius = baseRadius
		self.knobRadius = knobRadius
		self.currentCountdown = 0
		self.countdownTextNode = SKLabelNode(text: "0")
		super.init()
		
		self.countdownTextNode.fontColor = .clear
		self.countdownTextNode.fontSize = 24
		self.countdownTextNode.position.y = -countdownTextNode.frame.size.height / 2
		
		// Create the base of the analog controller
		baseNode = SKShapeNode(circleOfRadius: baseRadius)
		baseNode.fillColor = SKColor.gray
		baseNode.alpha = 0.5
		addChild(baseNode)
		
		// Create the knob of the analog controller
		knobNode = SKShapeNode(circleOfRadius: knobRadius)
		knobNode.fillColor = SKColor.systemTeal.withAlphaComponent(0.5)
		
		knobNode.addChild(countdownTextNode)
		
		addChild(knobNode)
		drawSkillCircles(amount: 5)
		
		Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCountdown), userInfo: nil, repeats: true)
		
	}
	
	private func drawSkillCircles(amount: Int) {
		guard amount > 0 else { return }
		
		let angleSpacing = 90 / Double(amount)
		for i in 0..<amount {
			let angle = 90 + Double(i) * angleSpacing
			let x = (baseRadius + 20) * cos(angle.degreesToRadians())
			let y = (baseRadius + 20) * sin(angle.degreesToRadians())
			let circleNode = SKShapeNode(circleOfRadius: skillCircleRadius)
			circleNode.position = CGPoint(x: x, y: y)
			circleNode.fillColor = SKColor.systemTeal
			skillCircles.append(circleNode)
			baseNode.addChild(circleNode)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	@objc private func updateCountdown() {
		guard currentCountdown > 0 else { return }
		
		if(currentCountdown > 0){
			currentCountdown -= 1
		}
		
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
		currentCountdown = cooldown
		if(amountOfSkillLeft > 0){
			amountOfSkillLeft -= 1
			skillCircles[amountOfSkillLeft].fillColor = .gray
		}
		self.countdownTextNode.fontColor = .white
		isFocused = false
	}
	
	func focus(){
		if(currentCountdown == 0 && amountOfSkillLeft > 0){
			self.isFocused = true
		}
	}
	
}
