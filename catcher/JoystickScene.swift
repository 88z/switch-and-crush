//
//  JoystickScene.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 03.10.2020.
//

import SpriteKit

protocol JoystickDelegate {
    func joystickTouched(at pos:CGPoint)
    func joystickMoved(to pos: CGPoint)
    func joystickPressed()
    func joystickReleased()
}

class JoystickScene: SKScene {
    private var touchStartSeconds:TimeInterval = 0
    private var touchStartPoint = CGPoint.zero
    
    var joystickDelegate: JoystickDelegate?
    
    var calmDownTimer: Timer?
    
    override func didMove(to view: SKView) {
        
    }
    
    func touchDown(atPoint pos : CGPoint, tapCount: Int) {
        calmDownTimer?.invalidate()
        touchStartSeconds = NSDate().timeIntervalSince1970
        touchStartPoint = pos
        joystickDelegate?.joystickTouched(at: pos)
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        joystickDelegate?.joystickMoved(to: CGPoint(x: pos.x - touchStartPoint.x, y: pos.y - touchStartPoint.y))
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if NSDate().timeIntervalSince1970 - touchStartSeconds <= 0.3 {
            joystickDelegate?.joystickPressed()
        }
        //ждем время и только после этого отпускаем stick
        calmDownTimer = Timer.scheduledTimer(withTimeInterval: 0.7, repeats: false, block: { [unowned self] timer in
            joystickDelegate?.joystickReleased()
        })
    }
    
   
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            self.touchDown(atPoint: t.location(in: self), tapCount:t.tapCount)
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
}
