//
//  ViewController.swift
//  pyonpyon
//
//  Created by 西本至秀 on 2019/01/02.
//  Copyright © 2019 jp.co.wbcompany. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var boardView:UIView!
    var popup:UIView!
    var popLabel:UILabel!
    
    var pieces: [Piece] = []
    var squares: [Square] = []
    
    var status = StatusType.unSelected
    var selectedPiece:Piece? = nil
    var turn = TurnPlayer.player1

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialize()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        for piece:Piece in pieces {
            piece.squareSize = boardView.frame.width / 3
        }
    }
    
    private func initialize() {
        self.makeBoard()
        self.setPieces()
        self.makePopup()
    }
    
    private func makePopup() {
        let popup = UIView()
        let popLabel = UILabel()
        popLabel.textAlignment = .center
        popLabel.font.withSize(36.0)
        self.boardView.addSubview(popup)
        popup.addSubview(popLabel)
        popup.alpha = 0.2
        let guide = self.view.safeAreaLayoutGuide
        popup.translatesAutoresizingMaskIntoConstraints = false
        popLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            popup.topAnchor.constraint(equalTo: guide.topAnchor, constant: 0),
            popup.leftAnchor.constraint(equalTo: guide.leftAnchor, constant: 0),
            popup.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: 0),
            popup.rightAnchor.constraint(equalTo: guide.rightAnchor, constant: 0),
            popLabel.centerXAnchor.constraint(equalTo: popup.centerXAnchor, constant: 0),
            popLabel.centerYAnchor.constraint(equalTo: popup.centerYAnchor, constant: 0),
            popLabel.widthAnchor.constraint(equalTo: popup.widthAnchor , multiplier: 1/2),
            popLabel.heightAnchor.constraint(equalTo: popup.heightAnchor , multiplier: 1/3),
        ])
        popup.isHidden = true
        popup.backgroundColor = .gray
        self.popup = popup
        self.popLabel = popLabel
    }
    
    private func setPieces() {
        let height = squares[0].heightAnchor
        for i in 0...8 {
            let piece = Piece(player: .player1)
            piece.position = Positon(column: 8 - (i % 3), row: i / 3)
            self.boardView.addSubview(piece)
            piece.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                piece.heightAnchor.constraint(equalTo: height, multiplier: 1),
                piece.widthAnchor.constraint(equalTo: height, multiplier: 1),
            ])
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.pieceTapped(_:)))
            tapGesture.numberOfTapsRequired = 1
            piece.isUserInteractionEnabled = true
            piece.addGestureRecognizer(tapGesture)
            pieces.append(piece)
        }
        for i in 0...8 {
            let piece = Piece(player: .player2)
            piece.position = Positon(column: i % 3, row: i / 3)
            self.boardView.addSubview(piece)
            piece.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                piece.heightAnchor.constraint(equalTo: height, multiplier: 1),
                piece.widthAnchor.constraint(equalTo: height, multiplier: 1),
                ])
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.pieceTapped(_:)))
            tapGesture.numberOfTapsRequired = 1
            piece.isUserInteractionEnabled = true
            piece.addGestureRecognizer(tapGesture)
            pieces.append(piece)
        }
    }
    
    private func makeBoard() {
        let guide = self.view.safeAreaLayoutGuide
        let boardView = UIView()
        self.boardView = boardView
        self.view.addSubview(self.boardView)
        boardView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            boardView.topAnchor.constraint(equalTo: guide.topAnchor, constant: 24),
            boardView.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -24),
            boardView.centerXAnchor.constraint(equalTo: guide.centerXAnchor, constant: 0),
            boardView.widthAnchor.constraint(equalTo: boardView.heightAnchor, multiplier: 1/3)
        ])
        boardView.backgroundColor = UIColor.white
        
        for i in 0...26 {
            let square = Square()
            square.position = Positon(column: i % 9, row: i / 9)
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.squareTapped(_:)))
            tapGesture.numberOfTapsRequired = 1
            square.isUserInteractionEnabled = true
            square.addGestureRecognizer(tapGesture)
            self.boardView.addSubview(square)
            square.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                square.widthAnchor.constraint(equalTo: boardView.widthAnchor, multiplier: 1/3),
                square.heightAnchor.constraint(equalTo: boardView.heightAnchor, multiplier: 1/9),
            ])
            if(i / 9 == 0) {
                NSLayoutConstraint.activate([
                    square.leftAnchor.constraint(equalTo: boardView.leftAnchor, constant: 0),
                ])
            } else {
                let l_square = squares[i - 9]
                NSLayoutConstraint.activate([
                    square.leftAnchor.constraint(equalTo: l_square.rightAnchor, constant: 0),
                ])
            }
            if(i % 9 == 0) {
                NSLayoutConstraint.activate([
                    square.topAnchor.constraint(equalTo: boardView.topAnchor, constant: 0),
                ])
            } else {
                let a_square = squares[i - 1]
                NSLayoutConstraint.activate([
                    square.topAnchor.constraint(equalTo: a_square.bottomAnchor, constant: 0),
                ])
            }
            squares.append(square)
        }
        
    }
    
    @objc func pieceTapped(_ gesture: UITapGestureRecognizer) {
        let view = gesture.view as! Piece
        
        if self.status == StatusType.unSelected, view.player.rawValue == turn.rawValue, view.side == PieceSide.head {
            if let movable = self.detectMovable(selectedPiece: view) {
                view.selected()
                self.status = StatusType.selected
                self.selectedPiece = view
                let square = squares.filter({ $0.position.column == movable && $0.position.row == view.position.row }).first!
                square.movable = .possible
            }
            return
        }
        if self.status == StatusType.selected, self.selectedPiece == view {
            view.canceled()
            self.status = StatusType.unSelected
            self.selectedPiece = nil
            squares.forEach({ $0.movable = .impossible })
            return
        }
    }
    
    @objc func squareTapped(_ gesture: UITapGestureRecognizer) {
        let view = gesture.view as! Square
        if self.status == StatusType.selected, view.movable == .possible {
            selectedPiece?.position = view.position
            squares.forEach({ $0.movable = .impossible })
            
            if isFinish() {
                self.popLabel.text = "\(turn.rawValue)の勝ち"
                self.popup.isHidden = false
                UIView.animate(withDuration: 0.8, animations: {
                    self.popup.alpha = 0.5
                }) { finished in
                }
            } else {
                changeTurn()
            }
            
        }
    }
    
    private func changeTurn() {
        self.status = StatusType.unSelected
        self.turn = turn == .player1 ? .player2 : .player1
        
        if !self.isRemovable() {
            self.popLabel.text = "パス！"
            self.popup.isHidden = false
            UIView.animate(withDuration: 1.0, animations: {
                self.popup.alpha = 0.8
            }) { finished in
                self.popup.isHidden = true
                self.popup.alpha = 0.2
                self.changeTurn()
            }
        }
    }
    
    private func detectMovable(selectedPiece: Piece) -> Int? {
        let row = selectedPiece.position.row
        let column = selectedPiece.position.column
        let player = selectedPiece.player
        
        return self.isFrontMovable(column: column, row: row, player: player!)
    }
    
    private func isFrontMovable(column: Int, row: Int, player: Player) -> Int? {
        let front = player == Player.player1 ? column - 1 : column + 1
        
        if player == Player.player1, front < 0 {
            return nil
        }
        
        if player == Player.player2, front > 8 {
            return nil
        }
        if pieces.filter({ $0.position.column == front && $0.position.row == row }).isEmpty {
            return front
        }
        return self.isFrontMovable(column: front, row: row, player: player)
    }
    
    private func isRemovable() -> Bool {
        var result: Bool = false
        pieces.filter({ $0.player.rawValue == self.turn.rawValue }).forEach({
            if detectMovable(selectedPiece: $0) != nil {
                result = true
                return
            }
        })
        return result
    }
    
    private func isFinish() -> Bool {
        return pieces.filter({ $0.player.rawValue == self.turn.rawValue && $0.side == .head }).isEmpty
    }
}

