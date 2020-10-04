//
//  InfiniteBackgroundManager.swift
//  catcher
//
//  Created by Aleksandr Zhuravlev on 03.10.2020.
//

import SpriteKit

protocol InfiniteBackgroundTextureGenerator {
    func generate() ->SKTexture?
}

class InfiniteBackgroundManager {
    private var nodes = [SKSpriteNode]()
    private var centralNode: SKSpriteNode!
    private var scene: SKScene
    private let colors:[UIColor] = [.blue, .systemOrange, .yellow, .blue, .systemOrange, .yellow, .blue, .systemOrange, .yellow]
    init?(scene: SKScene, textureGenerator: InfiniteBackgroundTextureGenerator) {
        self.scene = scene
        for row in -1...1 {
            for col in -1...1 {
                guard let texture = textureGenerator.generate() else {
                    return nil
                }
                let node = SKSpriteNode(texture: texture, color: .clear, size: texture.size())
                if row == 0 && col == 0 {
                    centralNode = node
                }
                nodes.append(node)
                node.position = positionFor(row: row, col: col, center: CGPoint(x: scene.frame.midX, y: scene.frame.midY))!
                node.zPosition = -1
                scene.addChild(node)
            }
            
        }
//        for i in 0...8 {
//            nodes[i].color = colors[i]
//            nodes[i].colorBlendFactor = 1
//        }
    }
    
    
    private func positionFor(row: Int, col: Int, center: CGPoint) -> CGPoint?{
        guard let anyNode = nodes.first else {
            return nil
        }
        let x = center.x + anyNode.size.width * CGFloat(col) - CGFloat(col)
        let y = center.y + anyNode.size.height * CGFloat(row) - CGFloat(row)
        return CGPoint(x: x, y: y)
    }
    
    private func nodeFor(cameraPosition: CGPoint) -> SKSpriteNode?  {
        for node in nodes {
            if node.frame.contains(cameraPosition) {
                return node
            }
        }
        return nil
    }
    
    private func rowOf(_ node: SKSpriteNode) -> Int {
        return Int(round((node.position.y - centralNode.position.y)/node.size.height))
        
    }
    
    private func colOf(_ node: SKSpriteNode) -> Int {
        return Int(round((node.position.x - centralNode.position.x)/node.size.width))
    }
    
    public func swapIfNeeded() {
        guard let cameraPosition = scene.camera?.position, let currentNode = nodeFor(cameraPosition: cameraPosition) else {
            return
        }
        
        if currentNode == centralNode {
            return
        }
        
        
        let col = colOf(currentNode)
        let row = rowOf(currentNode)
        
        if col == -1 {
            swipeLeft(newCenter: currentNode.position, oldCenter:centralNode.position)
        } else if col == 1 {
            swipeRight(newCenter: currentNode.position, oldCenter:centralNode.position)
        }
        
        
        if row == -1 {
            swipeDown(newCenter: currentNode.position, oldCenter:centralNode.position)
        } else if row == 1 {
            swipeUp(newCenter: currentNode.position, oldCenter:centralNode.position)
        }
        
        centralNode = currentNode
        
    }
    
    
    private func nodesAt(row: Int) -> [SKSpriteNode] {
        var nodesAtRow = [SKSpriteNode]()
        for node in nodes {
            if rowOf(node) == row {
                nodesAtRow.append(node)
            }
        }
        return nodesAtRow;
    }
    
    private func nodesAt(col: Int) -> [SKSpriteNode] {
        var nodesAtRow = [SKSpriteNode]()
        for node in nodes {
            if colOf(node) == col {
                nodesAtRow.append(node)
            }
        }
        return nodesAtRow;
    }
    
    private func swipeLeft(newCenter: CGPoint, oldCenter:CGPoint) {
        let rightNodes = nodesAt(col:1)
        for node in rightNodes {
            if let newPosition = positionFor(row: rowOf(node), col: -1, center: CGPoint(x:newCenter.x, y:oldCenter.y)) {
                node.position = newPosition
            }
        }
    }
    
    private func swipeRight(newCenter: CGPoint, oldCenter:CGPoint) {
        let leftNodes = nodesAt(col:-1)
        var i = -1
        for node in leftNodes {
            if let newPosition = positionFor(row: rowOf(node), col: 1, center: CGPoint(x:newCenter.x, y:oldCenter.y)) {
                node.position = newPosition
            }
            i+=1
        }
    }
    
    private func swipeUp(newCenter: CGPoint, oldCenter:CGPoint) {
        let bottonNodes = nodesAt(row:-1)
        for node in bottonNodes {
            if let newPosition = positionFor(row: 1, col: colOf(node),center: CGPoint(x:oldCenter.x, y:newCenter.y)) {
                node.position = newPosition
            }
        }
    }
    
    private func swipeDown(newCenter: CGPoint, oldCenter:CGPoint) {
        let topNodes = nodesAt(row:1)
        for node in topNodes {
            if let newPosition = positionFor(row: -1, col: colOf(node), center: CGPoint(x:oldCenter.x, y:newCenter.y)) {
                node.position = newPosition
            }
        }
    }
}
