//
//  GameScene.swift
//  Limitless Elemental Controller Shared
//
//  Created by Alidin on 12/10/23.
//

import SpriteKit

class GameScene: SKScene {

	var movementControler : MovementController!
	var startPauseButton : RoundedRectangleButton!
	var selectButton : RoundedRectangleButton!
	var jumpButton : CircularTriangleButton!
	var skillController : SkillController!
	
	private var fixedDeltaTime: TimeInterval = 1.0 / 20.0  // Update 20 times per second
	private var accumulatedTime: TimeInterval = 0.0
	private var lastUpdateTime: TimeInterval = 0.0

	
    func setupMovementController() {
		movementControler = MovementController(baseRadius: 80, knobRadius: 30)
		movementControler.position.x = 150
		movementControler.position.y = 150
		self.addChild(movementControler)
    }
	
	func setupSkillController() {
		skillController = SkillController(baseRadius: 80, knobRadius: 30)
		skillController.position.x =  frame.maxX - 150
		skillController.position.y =  frame.midY
		self.addChild(skillController)
	}
	
	func setupButtonController(){
		startPauseButton = RoundedRectangleButton(size: CGSize(width: 120, height: 48), cornerRadius: 16, bgColor: .gray.withAlphaComponent(0.5), labelText: "Start")
		startPauseButton.position.x = self.frame.midX - (startPauseButton.frame.width / 2 ) - 8
		startPauseButton.position.y = 150
		self.addChild(startPauseButton)
		
		selectButton = RoundedRectangleButton(size: CGSize(width: 120, height: 48), cornerRadius: 16, bgColor: .gray.withAlphaComponent(0.5), labelText: "Select")
		selectButton.position.x = self.frame.midX + (selectButton.frame.width / 2 ) + 8
		selectButton.position.y = 150
		self.addChild(selectButton)
	}
	
	func setupActionButton(){
		jumpButton = CircularTriangleButton(radius: 30)
		jumpButton.position = CGPoint(x: self.frame.maxX - jumpButton.frame.width - 150, y: 80)
		self.addChild(jumpButton)
	}
    
    override func didMove(to view: SKView) {
        self.setupMovementController()
		self.setupButtonController()
		self.setupActionButton()
		self.setupSkillController()
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
		
		accumulatedTime += currentTime - lastUpdateTime
		lastUpdateTime = currentTime
		
		// Ensure the update is called 20 times per second
		while accumulatedTime >= fixedDeltaTime {
			sendData()
			accumulatedTime -= fixedDeltaTime
		}
    }
	
	func sendData(){
		print("send data to backend 20 tick persecond")
	}
}

#if os(iOS) || os(tvOS)
// Touch-based event handling
extension GameScene {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
			let location = touch.location(in: self)
			
			if(movementControler.contains(location)){
				movementControler.focus()
			}
			
			if(skillController.contains(location)){
				skillController.focus()
			}
			
			if(startPauseButton.contains(location)){
				print("start button pressed")
			}
			
			if(selectButton.contains(location)){
				print("select button pressed")
			}
			
			if(jumpButton.contains(location)){
				print("jump button presed")
			}
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
			let location = touch.location(in: self)
			
// 			movement controller
			if(movementControler.isFocused && location.x < frame.midX ){
				movementControler.updateKnobPosition(location)
			}
		
//			skill controller
			if(skillController.isFocused && location.x > frame.midX ){
				skillController.updateKnobPosition(location)
			}
		
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
			let location = touch.location(in: self)

			if( movementControler.isFocused && location.x < frame.midX ){
				movementControler.resetKnobPosition()
			}
			
//			cast skill on release
			if( skillController.isFocused && location.x > frame.midX ){
				print("cast skill to \(skillController.knobNode.position)")
				skillController.resetKnobPosition()
			}
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
			movementControler.resetKnobPosition()
			skillController.resetKnobPosition()
    }
    
   
}
#endif
