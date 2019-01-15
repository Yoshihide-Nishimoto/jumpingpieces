//
//  Square.swift
//  pyonpyon
//
//  Created by 西本至秀 on 2019/01/06.
//  Copyright © 2019 jp.co.wbcompany. All rights reserved.
//

import UIKit

class Square: UIView {
    
    var defaultBackgroundColor:UIColor = .clear
    var movable:SquareMovable = .impossible {
        didSet {
            if movable == .possible {
                self.backgroundColor = UIColor.movable()
                return
            }
            self.backgroundColor = self.defaultBackgroundColor
        }
    }
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
    
    convenience init() {
        self.init(frame: .zero)
        self.layer.borderColor = UIColor.boaderColor().cgColor
        self.layer.borderWidth = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    private func setPosition() {
        self.center = CGPoint(x: CGFloat(position.row) * squareSize + (squareSize / 2), y: CGFloat(position.column) * squareSize + (squareSize / 2))
        switch position.column {
        case 0...2:
            self.backgroundColor = UIColor.player2()
            self.defaultBackgroundColor = UIColor.player2()
        case 6...8:
            self.backgroundColor = UIColor.player1()
            self.defaultBackgroundColor = UIColor.player1()
        default:
            self.backgroundColor = UIColor.clear
            self.defaultBackgroundColor = UIColor.clear
        }
    }
}
