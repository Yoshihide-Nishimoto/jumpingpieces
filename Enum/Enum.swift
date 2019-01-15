//
//  Enum.swift
//  pyonpyon
//
//  Created by 西本至秀 on 2019/01/07.
//  Copyright © 2019 jp.co.wbcompany. All rights reserved.
//

enum StatusType {
    case unSelected
    case selected
}

enum TurnPlayer:Int {
    case player1 = 1
    case player2 = 2
}

enum Player:Int {
    case player1 = 1
    case player2 = 2
}

enum SquareAvailability {
    case vacant
    case full
}

enum SquareMovable {
    case impossible
    case possible
}

enum PieceSide {
    case head
    case tail
}
