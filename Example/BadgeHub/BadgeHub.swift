//
//  BadgeHub.swift
//
//  Created by Jogendra on 31/05/19.
//  Copyright © 2019 Jogendra. All rights reserved.
//

import UIKit
import QuartzCore

class BadgeView: UIView {
    
    func setBackgroundColor(_ backgroundColor: UIColor?) {
        super.backgroundColor = backgroundColor
    }
}

public class BadgeHub: NSObject {
    var count: Int = 0 {
        didSet {
            countLabel?.text = "\(count)"
            checkZero()
            resizeToFitDigits()
        }
    }
    var maxCount: Int = 0
    var hubView: UIView?
    
    private var curOrderMagnitude: Int = 0
    private var countLabel: UILabel? {
        didSet {
            countLabel?.text = "\(count)"
            checkZero()
        }
    }
    
    private var redCircle: BadgeView!
    private var initialCenter = CGPoint.zero
    private var baseFrame = CGRect.zero
    private var initialFrame = CGRect.zero
    
    private struct Constants {
        static let notificHubDefaultDiameter: CGFloat = 30
        static let countMagnitudeAdaptationRatio: CGFloat = 0.3
        // Pop values
        static let popStartRatio: CGFloat = 0.85
        static let popOutRatio: CGFloat = 1.05
        static let popInRatio: CGFloat = 0.95
        // Blink values
        static let blinkDuration: CGFloat = 0.1
        static let blinkAlpha: CGFloat = 0.1
        // Bump values
        static let firstBumpDistance: CGFloat = 8.0
        static let bumpTimeSeconds: CGFloat = 0.13
        static let secondBumpDist: CGFloat = 4.0
        static let bumpTimeSeconds2: CGFloat = 0.1
    }
    
    // MARK: - SETUP
    public init(view: UIView) {
        super.init()
        
        maxCount = 100000
        setView(view, andCount: 0)
    }
    
    public convenience init?(barButtonItem: UIBarButtonItem) {
        if let value = barButtonItem.value(forKey: "view") as? UIView {
            self.init(view: value)
            scaleCircleSize(by: 0.7)
            moveCircleBy(x: -5.0, y: 0)
        } else if let value = barButtonItem.customView {
            self.init(view: value)
            scaleCircleSize(by: 0.7)
            moveCircleBy(x: -5.0, y: 0)
        } else {
            return nil
        }
    }
    
    // Adjustment methods
    public func setView(_ view: UIView?, andCount startCount: Int) {
        curOrderMagnitude = 0
        
        let frame: CGRect? = view?.frame
        
        redCircle = BadgeView()
        redCircle?.isUserInteractionEnabled = false
        redCircle.backgroundColor = UIColor.red
        
        countLabel = UILabel(frame: redCircle.frame)
        countLabel?.isUserInteractionEnabled = false
        count = startCount
        countLabel?.textAlignment = .center
        countLabel?.textColor = UIColor.white
        countLabel?.backgroundColor = UIColor.clear
        
        setCircleAtFrame(CGRect(x: (frame?.size.width ?? 0.0) - ((Constants.notificHubDefaultDiameter) * 2 / 3),
                                y: (-Constants.notificHubDefaultDiameter) / 3,
                                width: CGFloat(Constants.notificHubDefaultDiameter),
                                height: CGFloat(Constants.notificHubDefaultDiameter)))
        
        view?.addSubview(redCircle)
        view?.addSubview(countLabel!)
        view?.bringSubviewToFront(redCircle)
        view?.bringSubviewToFront(countLabel!)
        hubView = view
        checkZero()
    }
    
    // Set the frame of the notification circle relative to the button
    public func setCircleAtFrame(_ frame: CGRect) {
        redCircle.frame = frame
        initialCenter = CGPoint(x: frame.origin.x + frame.size.width / 2,
                                y: frame.origin.y + frame.size.height / 2)
        baseFrame = frame
        initialFrame = frame
        countLabel?.frame = redCircle.frame
        redCircle.layer.cornerRadius = frame.size.height / 2
        countLabel?.font = UIFont.systemFont(ofSize: frame.size.width / 2)
    }
    
    // Change the color of the notification circle
    public func setCircleColor(_ circleColor: UIColor?, label labelColor: UIColor?) {
        redCircle.backgroundColor = circleColor
        if let labelColor = labelColor {
            countLabel?.textColor = labelColor
        }
    }
    
    public func setCircleBorderColor(_ color: UIColor?, borderWidth width: CGFloat) {
        redCircle.layer.borderColor = color?.cgColor
        redCircle.layer.borderWidth = width
    }
    
    public func moveCircleBy(x: CGFloat, y: CGFloat) {
        var frame: CGRect = redCircle.frame
        frame.origin.x += x
        frame.origin.y += y
        self.setCircleAtFrame(frame)
    }
    
    // Changes the size of the circle. setting a scale of 1 has no effect
    public func scaleCircleSize(by scale: CGFloat) {
        let fr: CGRect = initialFrame
        let width: CGFloat = fr.size.width * scale
        let height: CGFloat = fr.size.height * scale
        let wdiff: CGFloat = (fr.size.width - width) / 2
        let hdiff: CGFloat = (fr.size.height - height) / 2
        
        let frame = CGRect(x: fr.origin.x + wdiff, y: fr.origin.y + hdiff, width: width, height: height)
        self.setCircleAtFrame(frame)
    }
    
    // Increases count by 1
    public func increment() {
        increment(by: 1)
    }
    
    // Increases count by amount
    public func increment(by amount: Int) {
        count += amount
    }
    
    // Decreases count
    public func decrement() {
        decrement(by: 1)
    }
    
    // Decreases count by amount
    public func decrement(by amount: Int) {
        if amount >= count {
            count = 0
            return
        }
        count -= amount
        checkZero()
    }
    
    public func hideCount() {
        redCircle.isHidden = true
        countLabel?.isHidden = true
    }
    
    public func showCount() {
        checkZero()
    }
    
    // Animations
    public func pop() {
        let height = baseFrame.size.height
        let width = baseFrame.size.width
        let popStartHeight: Float = Float(height * Constants.popStartRatio)
        let popStartWidth: Float = Float(width * Constants.popStartRatio)
        let timeStart: Float = 0.05
        let popOutHeight: Float = Float(height * Constants.popOutRatio)
        let popOutWidth: Float = Float(width * Constants.popOutRatio)
        let timeOut: Float = 0.2
        let popInHeight: Float = Float(height * Constants.popInRatio)
        let popInWidth: Float = Float(width * Constants.popInRatio)
        let timeIn: Float = 0.05
        let popEndHeight: Float = Float(height)
        let popEndWidth: Float = Float(width)
        let timeEnd: Float = 0.05
        
        let startSize = CABasicAnimation(keyPath: "cornerRadius")
        startSize.duration = CFTimeInterval(timeStart)
        startSize.beginTime = 0
        startSize.fromValue = NSNumber(value: popEndHeight / 2)
        startSize.toValue = NSNumber(value: popStartHeight / 2)
        startSize.isRemovedOnCompletion = false
        
        let outSize = CABasicAnimation(keyPath: "cornerRadius")
        outSize.duration = CFTimeInterval(timeOut)
        outSize.beginTime = CFTimeInterval(timeStart)
        outSize.fromValue = startSize.toValue
        outSize.toValue = NSNumber(value: popOutHeight / 2)
        outSize.isRemovedOnCompletion = false
        
        let inSize = CABasicAnimation(keyPath: "cornerRadius")
        inSize.duration = CFTimeInterval(timeIn)
        inSize.beginTime = CFTimeInterval(timeStart + timeOut)
        inSize.fromValue = outSize.toValue
        inSize.toValue = NSNumber(value: popInHeight / 2)
        inSize.isRemovedOnCompletion = false
        
        let endSize = CABasicAnimation(keyPath: "cornerRadius")
        endSize.duration = CFTimeInterval(timeEnd)
        endSize.beginTime = CFTimeInterval(timeIn + timeOut + timeStart)
        endSize.fromValue = inSize.toValue
        endSize.toValue = NSNumber(value: popEndHeight / 2)
        endSize.isRemovedOnCompletion = false
        
        let group = CAAnimationGroup()
        group.duration = CFTimeInterval(timeStart + timeOut + timeIn + timeEnd)
        group.animations = [startSize, outSize, inSize, endSize]
        
        redCircle.layer.add(group, forKey: nil)
        
        UIView.animate(withDuration: TimeInterval(timeStart), animations: {
            var frame: CGRect = self.redCircle.frame
            let center: CGPoint = self.redCircle.center
            frame.size.height = CGFloat(popStartHeight)
            frame.size.width = CGFloat(popStartWidth)
            self.redCircle.frame = frame
            self.redCircle.center = center
        }) { complete in
            UIView.animate(withDuration: TimeInterval(timeOut), animations: {
                var frame: CGRect = self.redCircle.frame
                let center: CGPoint = self.redCircle.center
                frame.size.height = CGFloat(popOutHeight)
                frame.size.width = CGFloat(popOutWidth)
                self.redCircle.frame = frame
                self.redCircle.center = center
            }) { complete in
                UIView.animate(withDuration: TimeInterval(timeIn), animations: {
                    var frame: CGRect = self.redCircle.frame
                    let center: CGPoint = self.redCircle.center
                    frame.size.height = CGFloat(popInHeight)
                    frame.size.width = CGFloat(popInWidth)
                    self.redCircle.frame = frame
                    self.redCircle.center = center
                }) { complete in
                    UIView.animate(withDuration: TimeInterval(timeEnd), animations: {
                        var frame: CGRect = self.redCircle.frame
                        let center: CGPoint = self.redCircle.center
                        frame.size.height = CGFloat(popEndHeight)
                        frame.size.width = CGFloat(popEndWidth)
                        self.redCircle.frame = frame
                        self.redCircle.center = center
                    })
                }
            }
        }
    }
    
    public func blink() {
        self.setAlpha(alpha: Constants.blinkAlpha)
        
        UIView.animate(withDuration: TimeInterval(Constants.blinkDuration), animations: {
            self.setAlpha(alpha: 1)
        }) { complete in
            UIView.animate(withDuration: TimeInterval(Constants.blinkDuration), animations: {
                self.setAlpha(alpha: Constants.blinkAlpha)
            }) { complete in
                UIView.animate(withDuration: TimeInterval(Constants.blinkDuration), animations: {
                    self.setAlpha(alpha: 1)
                })
            }
        }
    }
    
    // Animation that jumps similar to OSX dock icons
    public func bump() {
        if !initialCenter.equalTo(redCircle.center) {
            // canel previous animation
        }
        
        bumpCenterY(yVal: 0)
        UIView.animate(withDuration: TimeInterval(Constants.bumpTimeSeconds), animations: {
            self.bumpCenterY(yVal: Float(Constants.firstBumpDistance))
        }) { complete in
            UIView.animate(withDuration: TimeInterval(Constants.bumpTimeSeconds), animations: {
                self.bumpCenterY(yVal: 0)
            }) { complete in
                UIView.animate(withDuration: TimeInterval(Constants.bumpTimeSeconds2), animations: {
                    self.bumpCenterY(yVal: Float(Constants.secondBumpDist))
                }) { complete in
                    UIView.animate(withDuration: TimeInterval(Constants.bumpTimeSeconds2), animations: {
                        self.bumpCenterY(yVal: 0)
                    })
                }
            }
        }
    }
    
    // Set the count yourself
    public func setCount(_ newCount: Int) {
        self.count = newCount
        let labelText = count > maxCount ? "\(maxCount)+" : "\(count)"
        countLabel?.text = labelText
        checkZero()
    }
    
    // Set the font of the label
    public func setCountLabelFont(_ font: UIFont?) {
        countLabel?.font = font
    }
    
    
    /// Get current set label font for count label
    /// - Returns: current set font
    public func getCountLabelFont() -> UIFont? {
        return countLabel?.font
    }
    
    
    public func bumpCenterY(yVal: Float) {
        var center: CGPoint = redCircle.center
        center.y = initialCenter.y - CGFloat(yVal)
        redCircle.center = center
        countLabel?.center = center
    }
    
    public func setAlpha(alpha: CGFloat) {
        redCircle.alpha = alpha
        countLabel?.alpha = alpha
    }
    
    public func checkZero() {
        if count <= 0 {
            redCircle.isHidden = true
            countLabel?.isHidden = true
        } else {
            redCircle.isHidden = false
            countLabel?.isHidden = false
        }
    }
    
    func resizeToFitDigits() {
        guard count > 0 else { return }
        var orderOfMagnitude: Int = Int(log10(Double(count)))
        orderOfMagnitude = (orderOfMagnitude >= 2) ? orderOfMagnitude : 1
        var frame: CGRect = initialFrame
        frame.size.width = CGFloat(initialFrame.size.width * (1 + 0.3 * CGFloat(orderOfMagnitude - 1)))
        frame.origin.x = initialFrame.origin.x - (frame.size.width - initialFrame.size.width) / 2
        
        redCircle.frame = frame
        initialCenter = CGPoint(x: frame.origin.x + frame.size.width / 2,
                                y: frame.origin.y + frame.size.height / 2)
        baseFrame = frame
        countLabel?.frame = redCircle.frame
        curOrderMagnitude = orderOfMagnitude
    }
}
