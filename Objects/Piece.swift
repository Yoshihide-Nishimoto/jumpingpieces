//
//  Player.swift
//  pyonpyon
//
//  Created by 西本至秀 on 2019/01/06.
//  Copyright © 2019 jp.co.wbcompany. All rights reserved.
//

import UIKit

class Piece: UIImageView {
    
    var player:Player!
    var side:PieceSide = .head
    
    var squareSize:CGFloat = 0.0 {
        didSet {
            self.setPosition()
        }
    }
    var position:Positon = Positon(column: 0, row: 0) {
        didSet {
            self.setPosition()
        }
    }
    
    override init(image: UIImage?) {
        super.init(image: image)
    }
    
    convenience init(player: Player) {
        let imageNamePlayer1 = "player1.png"
        let imageNamePlayer2 = "player2.png"
        let angle = CGFloat((180.0 * M_PI) / 180.0)
        if(player == .player1) {
            self.init(image: UIImage(named: imageNamePlayer1))
        } else {
            self.init(image: UIImage(named: imageNamePlayer2))
            self.transform = CGAffineTransform(rotationAngle: angle)
        }
        self.player = player
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func selected() {
        UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.1, initialSpringVelocity: 0.0, options: [.autoreverse, .repeat, .allowUserInteraction], animations: {
            self.bounds.size.height += 3.0
            self.bounds.size.width += 3.0
        })
    }
    
    func canceled() {
        self.bounds.size.height -= 3.0
        self.bounds.size.width -= 3.0
        self.layer.removeAllAnimations()
    }
    
    private func setPosition() {
        self.center = CGPoint(x: CGFloat(position.row) * squareSize + (squareSize / 2), y: CGFloat(position.column) * squareSize + (squareSize / 2))
        if player == Player.player1 {
            if 0...2 ~= position.column {
                let imageNamePlayer1 = "player1_r.png"
                self.image = UIImage(named: imageNamePlayer1)
                self.side = .tail
            }
        } else {
            if 6...8 ~= position.column {
                let imageNamePlayer2 = "player2_r.png"
                self.image = UIImage(named: imageNamePlayer2)
                self.side = .tail
            }
        }
        self.canceled()
    }
}
