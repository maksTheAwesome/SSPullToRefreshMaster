//
//  SSPullToRefreshView.swift
//  SSPullToRefresh
//
//  Created by Maksym Lazebnyi on 1/14/18.
//  Copyright © 2018 FleetWit. All rights reserved.
//

import UIKit

func delay(_ seconds: Double, completion: @escaping () -> ()) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
        completion()
    }
}

class SSPullToRefreshView: UIRefreshControl {
    
    override var isHidden: Bool {
        didSet {
            if !isHidden {
                superview?.sendSubview(toBack: self)
            }
        }
    }
    
    @IBOutlet
    fileprivate weak var leftGear: UIImageView!
    @IBOutlet
    fileprivate weak var centerGear: UIImageView!
    @IBOutlet
    fileprivate weak var rightGear: UIImageView!
    
    var minimumRefreshTime: Double = 1
    
    fileprivate var gears: [UIImageView] {
        return [leftGear, centerGear, rightGear]
    }
    
    fileprivate let keyPath = "refreshing"
    
    fileprivate var triggerHeight: CGFloat {
        return UIApplication.shared.keyWindow!.frame.size.height * 0.5
    }
    
    @IBOutlet var view: UIView!
    
    override func didMoveToWindow() {
        if self.window != nil {
            self.superview?.sendSubview(toBack: self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        Bundle.main.loadNibNamed("SSPullToRefreshView", owner: self, options: nil)
        self.view.frame = self.bounds
        self.addSubview(self.view)
        self.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.view.topAnchor.constraint(equalTo: topAnchor),
            self.view.leftAnchor.constraint(equalTo: leftAnchor),
            self.view.rightAnchor.constraint(equalTo: rightAnchor),
            self.view.bottomAnchor.constraint(equalTo: bottomAnchor)])
        
        self.backgroundColor = UIColor.white
    }
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("SSPullToRefreshView", owner: self, options: nil)
        self.view.frame = self.bounds
        self.addSubview(self.view)
        self.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.view.topAnchor.constraint(equalTo: topAnchor),
            self.view.leftAnchor.constraint(equalTo: leftAnchor),
            self.view.rightAnchor.constraint(equalTo: rightAnchor),
            self.view.bottomAnchor.constraint(equalTo: bottomAnchor)])
        
        self.backgroundColor = UIColor.white
    }
    
    override func beginRefreshing() {
        super.beginRefreshing()
        startAnimation()
    }
    
    override func endRefreshing() {
        //In cases when refresh finished really fast animation does not look good. Just add a second for the animation to show up.
        delay(minimumRefreshTime) {[weak self] (_) in
            guard let strongSelf = self, strongSelf.isRefreshing else {return}
            strongSelf.superEndRefreshing()
            strongSelf.stopAnimation()
        }
    }
    
    func superEndRefreshing() {
        super.endRefreshing()
    }
    
    fileprivate func stopAnimation() {
        gears.forEach({$0.layer.removeAllAnimations()})
    }
    
    fileprivate func startAnimation() {
        stopAnimation()
        for gear in gears {
            let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
            rotateAnimation.fromValue = 0.0
            rotateAnimation.toValue = gear == centerGear ? CGFloat(Double.pi * -2) : CGFloat(Double.pi * 2)
            rotateAnimation.isRemovedOnCompletion = false
            rotateAnimation.duration = 3
            rotateAnimation.repeatCount = Float.infinity
            gear.layer.add(rotateAnimation, forKey: nil)
        }
    }

}
