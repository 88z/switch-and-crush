//
//  Gun.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 04.10.2020.
//



import SpriteKit

class Shooter {
    
    let scene: SKScene
    let target: SKNode
    let bulletCollisionBitMask: UInt32
    let bulletCategoryBitMask: UInt32
    let bulletContactBitMask: UInt32
    var bullets:[Bullet] = []
    
    init(scene: SKScene, target: SKNode, bulletCollisionBitMask: UInt32, bulletCategoryBitMask: UInt32, bulletContactBitMask: UInt32) {
        self.scene = scene
        self.target = target
        self.bulletCollisionBitMask = bulletCollisionBitMask
        self.bulletCategoryBitMask = bulletCategoryBitMask
        self.bulletContactBitMask = bulletContactBitMask
    }
    
    func shoot(scatter: CGFloat) {
        guard let camera = scene.camera, let targetBody = target.physicsBody else {
            return
        }
        let shootSpeed = CGFloat(600)
        let timeOfBulletFly = CGFloat(0.5)
        
        let hitPointDelta = CGVector(targetBody.velocity, changeLenTo: CGVectorLen(targetBody.velocity)*timeOfBulletFly)
        
        //точка попадания
        let hitPoint = randomPointInsideSquareWith(center: CGPoint(x: target.position.x+hitPointDelta.dx, y: target.position.y + hitPointDelta.dy), side: scatter)
        
        let shootingPoint = randomPointOnCircleWith(center: hitPoint, radius: shootSpeed*timeOfBulletFly)
        let shootingVector = CGVector(dx: hitPoint.x - shootingPoint.x, dy: hitPoint.y - shootingPoint.y)
        
        let bullet = Bullet(collisionBitMask: bulletCollisionBitMask, categoryBitMask: bulletCategoryBitMask, contactBitMask:bulletContactBitMask)
        
        bullet.position = shootingPoint
        bullet.physicsBody?.velocity = CGVector(shootingVector, changeLenTo: shootSpeed)
        bullets.append(bullet)
        scene.addChild(bullet)
    }
    
    public func rungarbageLoop() {
        return
        guard let camera = scene.camera, let targetBody = target.physicsBody else {
            return
        }
        for bullet in bullets {
            guard let bulletBody = bullet.physicsBody else {
                continue
            }
            if camera.contains(bullet) {
                continue
            }
            if CGVectorLen(bulletBody.velocity) > CGVectorLen(targetBody.velocity) {
                bullet.removeFromParent()
                if let index = bullets.firstIndex(of: bullet) {
                    bullets.remove(at: index)
                }
            }
        }
        // если скорость пули больше скорости героя
        //то просто смотрим наличие в камере, и если пуля там отсутствует, то удаляем
    }
    
}
