//
//  GCChartView.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/17.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import Charts
import Reusable
class GCChartView: UITableViewCell, Reusable {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initUI()
    }
    
}

extension GCChartView {
    
    private func initUI() {
        
        let chartView = LineChartView()
        chartView.backgroundColor = MetricGlobal.mainCellBgColor
        chartView.noDataText = "暂无数据"
        
        //x轴设置
        let xValues = ["今天", "3天", "7天", "30天", "60天"]
        chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: xValues)
        chartView.xAxis.labelTextColor = MetricGlobal.mainGray //x轴字体颜色
        chartView.xAxis.labelFont = kFont(adaptW(12.0))//x轴字体font
        chartView.xAxis.labelPosition = .bottom //x轴在下方
        chartView.xAxis.labelCount = xValues.count
        chartView.xAxis.granularity = 1
        chartView.xAxis.axisMinimum = -0.1 //x轴数据右移0.5（防止线条从0开始，和y轴重叠）
        chartView.xAxis.axisMaximum = Double(xValues.count) - 0.8
        //chartView.xAxis.forceLabelsEnabled = true
        chartView.xAxis.drawAxisLineEnabled = false//不绘制x轴
        chartView.xAxis.drawGridLinesEnabled = false//不绘制网格
        //chartView.xAxis.gridColor = .clear//设置网格颜色（是x轴对应的竖轴颜色）
       // chartView.xAxis.drawGridLinesEnabled = false
        
        
        //y轴设置
        chartView.rightAxis.enabled = false
        
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 2 //小数点后最多2位
        formatter.minimumFractionDigits = 2 //小数点后最少2位
        formatter.positiveSuffix = "ETH"
        chartView.leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: formatter)
        chartView.leftAxis.labelTextColor = MetricGlobal.mainGray //x轴字体颜色
        chartView.leftAxis.labelFont = kFont(adaptW(12.0))//x轴字体font
        chartView.leftAxis.gridColor = kRGB(r: 53, g: 51, b: 81)
        chartView.leftAxis.gridLineDashLengths = [4.0, 2.0]
        chartView.leftAxis.gridLineWidth = 0.5
        chartView.leftAxis.drawAxisLineEnabled = false
        chartView.leftAxis.axisMinimum = 0.20
        chartView.leftAxis.axisMaximum = 0.50
        chartView.leftAxis.labelCount = 5
        
        
        self.addSubview(chartView)
        chartView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.height.equalTo(adaptW(216.0))
        }
        
        //生成20条随机数据
        var dataEntries = [ChartDataEntry]()
        for i in 0..<15 {
           
            let y = arc4random()%20 + 25
            let yNum = Double("0.\(y)")!
            let entry = ChartDataEntry.init(x: Double(i)/3.0, y: yNum)
            dataEntries.append(entry)
        }
        //这50条数据作为1根折线里的所有数据
        let chartDataSet = LineChartDataSet(entries: dataEntries, label: "ETH走势")
        chartDataSet.colors = [.orange]
        chartDataSet.lineWidth = 2.0
        chartDataSet.mode = .horizontalBezier //平滑
        chartDataSet.drawValuesEnabled = false //不绘制拐点上的文字
        chartDataSet.drawCirclesEnabled = false //不绘制拐点
        chartDataSet.highlightEnabled = false //不显示十字线
        
        chartDataSet.drawFilledEnabled = true //可以绘制线条填充（只有先设置这个，才能设置填充色）
        //渐变颜色数组
        let gradientColors = [UIColor.orange.cgColor, MetricGlobal.mainCellBgColor.cgColor] as CFArray
        //每组颜色所在位置（范围0~1)
        let colorLocations:[CGFloat] = [1.0, 0.0]
        //生成渐变色
        let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(),
                                       colors: gradientColors, locations: colorLocations)
        //将渐变色作为填充对象s
        chartDataSet.fill = Fill.fillWithLinearGradient(gradient!, angle: 90.0)
        
        //目前折线图只包括1根折线
        let chartData = LineChartData(dataSets: [chartDataSet])
        //设置折现图数据
        chartView.data = chartData
        
    }
}
