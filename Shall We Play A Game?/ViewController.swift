//
//  ViewController.swift
//  Shall We Play A Game?
//
//  Created by Jaswitha Reddy G on 1/28/23.
//

import Foundation
import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    /// game logic and other utilities of the game
    
    @IBOutlet var infoView: InfoView!
    @IBOutlet var infoLabel: UILabel!
    @IBOutlet var okButton: UIButton!
    
    @IBOutlet var square0: UIView!
    @IBOutlet var square1: UIView!
    @IBOutlet var square2: UIView!
    @IBOutlet var square3: UIView!
    @IBOutlet var square4: UIView!
    @IBOutlet var square5: UIView!
    @IBOutlet var square6: UIView!
    @IBOutlet var square7: UIView!
    @IBOutlet var square8: UIView!
    
    @IBOutlet var XPiece: UILabel!
    @IBOutlet var OPiece: UILabel!
    @IBOutlet var collectionOfSquares: Array<UIView>?
    
    let grid = Grid()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // first xpiece
        let panGesture1 = UIPanGestureRecognizer(target: self, action: #selector(didPan(_:)))
        panGesture1.delegate = self
        XPiece.addGestureRecognizer(panGesture1)
        XPiece.tag = 1
        XPiece.textColor = UIColor.white
        XPiece.backgroundColor = UIColor.systemBlue

        // first opiece
        let panGesture2 = UIPanGestureRecognizer(target: self, action: #selector(didPan(_:)))
        panGesture2.delegate = self
        OPiece.addGestureRecognizer(panGesture2)
        OPiece.tag = 2
        OPiece.textColor = UIColor.white
        OPiece.backgroundColor = UIColor.systemPink
        
        //self.infoView.center = CGPoint(x: self.view.center.x, y: -250)
        // sets the info view above grid
        self.infoView.layer.zPosition = CGFloat(Float.greatestFiniteMagnitude)
        
        okButton.layer.cornerRadius = 15

        xTurn()
    }
    
    func xTurn() {
        UIView.animate(withDuration: 0.5) {
            self.XPiece.alpha = 0.5
        } completion: { (finished) in
        }
        UIView.animate(withDuration: 0.5) {
            self.XPiece.alpha = 1
        } completion: { (finished) in
        }
        self.XPiece.isUserInteractionEnabled = true
        self.OPiece.isUserInteractionEnabled = false
        self.OPiece.alpha = 0.1
    }
    
    func oTurn() {
        UIView.animate(withDuration: 0.5) {
            self.OPiece.alpha = 0.5
        } completion: { (finished) in
        }
        UIView.animate(withDuration: 0.5) {
            self.OPiece.alpha = 1
        } completion: { (finished) in
        }
        self.OPiece.isUserInteractionEnabled = true
        self.XPiece.isUserInteractionEnabled = false
        self.XPiece.alpha = 0.1
    }
    
    @IBAction func tapInfoButton(_ sender: UIButton) {
        infoLabel.text = "Get either X or O in a row, column, or diagonal to win!"
        infoLabel.lineBreakMode = .byWordWrapping
        infoLabel.numberOfLines = 0
        infoLabel.textColor = UIColor.white
        UIView.animate(withDuration: 1.0) {
            self.infoView.center = self.view.center
        } completion: {(finished) in
          }
    }
    
    @IBAction func tapOkButton(_ sender: UIButton) {
        //self.infoView.center = CGPoint(x: self.view.center.x, y: -200)
        self.infoView.isHidden = true
        if !grid.winner.isEmpty {
            newGame()
        }
    }
    
    // Create new X and O pieces
    func createNewPiece(pieceType: String) -> UILabel {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(didPan(_:)))
        panGesture.delegate = self
        if pieceType == "X" {
            let newXPiece = UILabel(frame: CGRect(x: 47, y: 600, width: 80, height: 80))
            newXPiece.text = "X"
            newXPiece.textColor = UIColor.white
            newXPiece.backgroundColor = UIColor.systemBlue
            newXPiece.font = newXPiece.font.withSize(80)
            newXPiece.textAlignment = .center
            newXPiece.tag = 1
            newXPiece.isUserInteractionEnabled = true
            newXPiece.addGestureRecognizer(panGesture)
            view.addSubview(newXPiece)
            return newXPiece
        } else {
            let newOPiece = UILabel(frame: CGRect(x: 247, y: 600, width: 80, height: 80))
            newOPiece.text = "O"
            newOPiece.textColor = UIColor.white
            newOPiece.backgroundColor = UIColor.systemPink
            newOPiece.font = newOPiece.font.withSize(80)
            newOPiece.textAlignment = .center
            newOPiece.tag = 2
            newOPiece.isUserInteractionEnabled = true
            newOPiece.addGestureRecognizer(panGesture)
            view.addSubview(newOPiece)
            return newOPiece
        }
    }
    
    func comparingOverlap(piece: UIView, square: UIView) -> Bool {
        let pieceRec = CGRect(x: piece.center.x, y: piece.center.y, width: 80, height: 80)
        let squareRec = CGRect(x: square.center.x, y: square.center.y, width: 80, height: 80)
        return pieceRec.intersects(squareRec)
    }
    
    // drawing a line across the grid
    func drawLine(start: Int, end: Int) {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: collectionOfSquares![start].center.x, y: collectionOfSquares![start].center.y))
        path.addLine(to: CGPoint(x: collectionOfSquares![end].center.x, y: collectionOfSquares![end].center.y))

        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = UIColor.systemGreen.cgColor
        shapeLayer.lineWidth = 10

        view.layer.addSublayer(shapeLayer)
    }
    
    func newGame() {
        // removes the squared to play a new game
        for subview in view.subviews {
            if subview.tag > 0 {
                subview.removeFromSuperview()
            }
        }
        XPiece = createNewPiece(pieceType: "X")
        OPiece = createNewPiece(pieceType: "O")
        grid.clearGrid()
        xTurn()
    }
    
    @objc func didPan(_ recognizer:UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.view)
        if let view = recognizer.view {
            view.center = CGPoint(x: view.center.x + translation.x,
                                  y: view.center.y + translation.y)
            
            recognizer.setTranslation(CGPoint.zero, in: self.view)
            
            // When the pieces are released
            if recognizer.state == .ended {
                var overlapping = false
                for i in 0...8 {
                    if comparingOverlap(piece: view, square: collectionOfSquares![i]) &&
                        grid.squares[i] == 0
                    {
                        UIView.animate(withDuration: 0.5) {
                            view.center = self.collectionOfSquares![i].center
                        } completion: { (finished) in
                        }
                        grid.squares[i] = view.tag
                        overlapping = true
                        break
                    }
                }
                
                if overlapping {
                    view.isUserInteractionEnabled = false
                    if view.tag == 1 {
                        XPiece = createNewPiece(pieceType: "X")
                        oTurn()
                    }
                    else {
                        OPiece = createNewPiece(pieceType: "O")
                        xTurn()
                    }
                } else {
                    if view.tag == 1 {
                        view.center = CGPoint(x: 47, y: 600)
                        xTurn()
                    } else {
                        view.center = CGPoint(x: 247, y: 600)
                        oTurn()
                    }
                }
                grid.check()

                if !grid.winner.isEmpty {
                    if grid.winner[0] == 1 {
                        self.XPiece.isUserInteractionEnabled = false
                        self.OPiece.isUserInteractionEnabled = false
                        infoLabel.textColor = UIColor.white
                        self.infoLabel.text = "Congratulations, X wins!"
                        UIView.animate(withDuration: 1.0) {
                            self.infoView.center = self.view.center
                        } completion: { (finished) in
                        }
                        drawLine(start: grid.winner[1], end: grid.winner[2])
                    } else if grid.winner[0] == 2 {
                        self.XPiece.isUserInteractionEnabled = false
                        self.OPiece.isUserInteractionEnabled = false
                        infoLabel.textColor = UIColor.white
                        infoLabel.text = "Congratulations, O wins!"
                        UIView.animate(withDuration: 1.0) {
                            self.infoView.center = self.view.center
                        } completion: { (finished) in
                        }
                        drawLine(start: grid.winner[1], end: grid.winner[2])
                    } else if grid.winner == [3] {
                        self.XPiece.isUserInteractionEnabled = false
                        self.OPiece.isUserInteractionEnabled = false
                        infoLabel.textColor = UIColor.white
                        infoLabel.text = "It's a tie!"
                        UIView.animate(withDuration: 1.0) {
                            self.infoView.center = self.view.center
                        } completion: { (finished) in
                        }
                    }
                }
            }
        }
    }
}
