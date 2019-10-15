//
//  JYHanabiView.swift
//  SwiftBaseDemo
//
//  Created by APP on 2019/9/7.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import Foundation

//存储一个原点和数个原点周围随机点
struct RoundPoints: CustomStringConvertible{
    var origin: CGPoint
    var rounds: [CGPoint]
    
    var description: String {
        return "origin : \(origin), \nrounds : \(rounds)\n"
    }
    
}

//烟花视图
class JYHanabiView: UIView {
    
    /// 存放放烟花的位置
    var points: [CGPoint] = []
    
    /// 烟花位置的具体数据
    private var hanabis: [RoundPoints] = []
    
//    private var animationPath: UIBezierPath?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        isUserInteractionEnabled = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        isUserInteractionEnabled = false
    }
    
    /// 调用这个方法就能放烟花了
    func blossom() {
        
        //如果points为空数组，则默认选取视图4个角中的1-3个作为烟花绽放点
        if self.points.count == 0 {
            let sBounds = bounds
            //获取视图的4个角
            let pointTopLeft = CGPoint(x: sBounds.minX, y: sBounds.minY)
            let pointTopRight = CGPoint(x: sBounds.minX, y: sBounds.maxY)
            let pointBottomLeft = CGPoint(x: sBounds.maxX, y: sBounds.minY)
            let pointBottomRight = CGPoint(x: sBounds.maxX, y: sBounds.maxY)
            let points = [pointTopLeft, pointTopRight, pointBottomLeft, pointBottomRight]
            self.points = points

        }
        
        //随机获取1-4个角
        var cornerPoints: [CGPoint] = []
        repeat {
            cornerPoints = points.filter {_ in
                let random = arc4random()%2
                print("random = \(random)")
                return random == 0
            }
            var pointsSet: [CGPoint] = []
            for point in cornerPoints {
                if !pointsSet.contains(point) {
                    pointsSet.append(point)
                }
            }
            cornerPoints = pointsSet
            
        }while (cornerPoints.count == 0)

        //获取每个角周围的8个随机爆炸点
        for point in cornerPoints {
            let round = getRounds(origin: point)
            hanabis.append(round)
            //画出爆炸点烟花并把角和爆炸点连线
            self.drawHanabi(at: round)
        }
//        JYLog(hanabis)
    
    }
    
    ///获取放烟花位置的周围8个随机烟花散开的点
    private func getRounds(origin: CGPoint) -> RoundPoints {
        var points: [CGPoint] = []
        for i in 0..<8 {
            let angleRandom = Double(Double((arc4random()%6 + 3))/10.0)
            let angleTransfrom = (Double.pi / 2) * angleRandom + Double(i / 2) * Double.pi / 2
            let length = CGFloat(arc4random()%10 + 40)
            let point = origin.getPointWith(angle: angleTransfrom, length: length)
            points.append(point)
        }
        return RoundPoints(origin: origin, rounds: points)
    }
    
    
    /// 放烟花的动画
    ///
    /// - Parameters:
    ///   - round: 烟花的具体位置
    private func drawHanabi(at round: RoundPoints) {
        let originPoint = round.origin
        for point in round.rounds {
            //在相应位置生成随机大小分散开的烟花
            let randomW = CGFloat(arc4random()%11 + 5)
            let subHanabi = UIView(frame: CGRect(origin: .zero, size: CGSize(width: randomW, height: randomW)))
            subHanabi.center = point
            
            //设置分散开烟花的颜色
            let r = CGFloat(arc4random()%256)
            let g = CGFloat(arc4random()%256)
            let b = CGFloat(arc4random()%256)
            subHanabi.backgroundColor = kRGB(r: r, g: g, b: b)
            self.addSubview(subHanabi)
            
            //设置分散开烟花为圆形
            let sLayer = CAShapeLayer()
            sLayer.frame = subHanabi.bounds
            let path = UIBezierPath(roundedRect: subHanabi.bounds, cornerRadius: randomW / 2)
            sLayer.path = path.cgPath
            subHanabi.layer.mask = sLayer
            
            
            //设置动画的路径为从origin到rounds中的每一个点，曲线的控制点在曲线上方，这样会指出的曲线就是一个倒U形
            let aniPath = UIBezierPath()
            aniPath.move(to: originPoint)
            
            let lengX = point.x - originPoint.x
            let lengY = point.y - originPoint.y
            
            let slope = lengY / lengX
            JYLog("斜率: \(slope)")
            let cPointX = point.x - lengX*0.3
            let cPointY = lengY > 0 ? slope * (cPointX - originPoint.x) + originPoint.y - (lengY * 1.5) : slope * (cPointX - originPoint.x) + originPoint.y + (lengY * 1.5)
            
            JYLog("x: \(cPointX), y: \(cPointY)")
            aniPath.addQuadCurve(to: point, controlPoint: CGPoint(x: cPointX, y: cPointY))
            aniPath.lineWidth = 1.0
//            self.animationPath = aniPath
            
            //先设置缩放为0.01，防止动画结束后恢复原来的大小
            subHanabi.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
            
            //添加组动画
            let aniGroup = CAAnimationGroup()
            aniGroup.isRemovedOnCompletion = false
            aniGroup.delegate = self
            
            //位移动画
            let moveAni = CAKeyframeAnimation(keyPath: "position")
            moveAni.path = aniPath.cgPath
            moveAni.timingFunctions = [.init(name: .easeOut)]
            moveAni.isRemovedOnCompletion = false
            
            //缩放动画
            let scaleAni = CAKeyframeAnimation(keyPath: "transform.scale")
            scaleAni.values = [0.3, 1, 0.8]
            scaleAni.keyTimes = [0.1, 0.2, 0.25]
            scaleAni.isRemovedOnCompletion = false
            scaleAni.fillMode = .backwards
            
            aniGroup.animations = [scaleAni, moveAni]
            subHanabi.layer.add(aniGroup, forKey: nil)
            
            
//            let aniLayer = CAShapeLayer()
//            aniLayer.strokeColor = kRGB(r: r, g: g, b: b).cgColor
//            aniLayer.fillColor = UIColor.clear.cgColor
//            aniLayer.frame = bounds
//            aniLayer.path = aniPath.cgPath
//            self.layer.addSublayer(aniLayer)
            
        }
    }
    
//    override func draw(_ rect: CGRect) {
//
//        self.animationPath?.stroke()
//    }
}
extension JYHanabiView: CAAnimationDelegate {
    
    //动画结束后移除
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        for subV in self.subviews {
            subV.removeFromSuperview()
        }
    }
}


extension CGPoint {
    //根据角度和距离计算对应的点的坐标
    func getPointWith(angle: Double, length: CGFloat) ->CGPoint {
        let x = length * CGFloat(sin(angle)) + self.x
        let y = length * CGFloat(cos(angle)) + self.y
        return CGPoint(x: x, y: y)
    }
}
