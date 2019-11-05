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
        chartView.xAxis.granularity = 3
        chartView.xAxis.forceLabelsEnabled = true
        chartView.xAxis.drawAxisLineEnabled = false
        chartView.xAxis.drawGridLinesEnabled = false
        
        //y轴设置
        chartView.rightAxis.enabled = false
        
        chartView.leftAxis.labelTextColor = MetricGlobal.mainGray //x轴字体颜色
        chartView.leftAxis.labelFont = kFont(adaptW(12.0))//x轴字体font
        chartView.leftAxis.gridColor = MetricGlobal.mainGray
        chartView.leftAxis.gridLineDashLengths = [4.0, 2.0]
        chartView.leftAxis.gridLineWidth = 0.5
        chartView.leftAxis.drawAxisLineEnabled = false
//        chartView.leftAxis.axisMinimum = 0.5
//        chartView.leftAxis.axisMaximum = 0.20
        chartView.xAxis.labelCount = 5
        
        
        self.addSubview(chartView)
        chartView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.height.equalTo(adaptW(216.0))
        }
        
        //生成20条随机数据
        var dataEntries = [ChartDataEntry]()
        for i in 0..<18 {
            let y = arc4random()%100
            let entry = ChartDataEntry.init(x: Double(i), y: Double(y))
            dataEntries.append(entry)
        }
        //这50条数据作为1根折线里的所有数据
        let chartDataSet = LineChartDataSet(entries: dataEntries, label: "图例1")
        chartDataSet.colors = [.orange]
        chartDataSet.lineWidth = 2.0
        chartDataSet.mode = .horizontalBezier //平滑
        chartDataSet.drawValuesEnabled = false //不绘制拐点上的文字
        chartDataSet.drawCirclesEnabled = false //不绘制拐点
       // chartDataSet.highlightEnabled = false //不显示十字线
        
        chartDataSet.drawFilledEnabled = true
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
