//
//  MoodGraphCell.swift
//  Victory Health
//
//  Created by Glauber Gustavo on 16/03/23.
//  Copyright © 2023 MadeinWeb. All rights reserved.
//

import UIKit
import Charts


protocol MoodChartCellDelegate {
    func showAnimationPopupGraph(_ chartItem: ChartItem)
    func setImageMoodGraph(_ chart: ChartItem) -> UIImage?
}
class MoodGraphCell: UITableViewCell,
                     ChartViewDelegate {
    
    @IBOutlet weak var vwMoodGraph: LineChartView!
    
    var formattedDates: [String] = []
    var mood: [ChartItem] = []
    var date: [Double] = []
    var delegate: MoodChartCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func loadUI(_ mood: [ChartItem]) {
        
        self.mood = mood
        
        vwMoodGraph.delegate = self
        vwMoodGraph.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.0)
        vwMoodGraph.roundCorners([.layerMaxXMaxYCorner, .layerMinXMaxYCorner], radius: 12)
        vwMoodGraph.layer.masksToBounds = true
        
        // Configurando os dados
        var dataEntries: [ChartDataEntry] = []
        let periodIndex: [String: Int] = [
            Constants.Messages.Dawn : 0,
            Constants.Messages.Morning : 1,
            Constants.Messages.Afternoon : 2,
            Constants.Messages.Night : 3
        ]
        self.date.removeAll()
        
        for i in 0..<mood.count {
            let date = mood[i].dateRegister.convertStringToDay() ?? .zero
            let period = mood[i].dateRegister.convertStringToPeriod() ?? Constants.Messages.Empty
            let icon = delegate.setImageMoodGraph(mood[i])
            self.date.append(date)
            let entry = ChartDataEntry(x: date, y: Double(periodIndex[period]!), icon: icon)
            dataEntries.append(entry)
            print(entry)
        }
        
        let dataSet = LineChartDataSet(entries: dataEntries)
        dataSet.colors = [.gray]
        dataSet.circleColors = [.gray]
        dataSet.circleRadius = 3
        dataSet.drawValuesEnabled = false
        dataSet.drawVerticalHighlightIndicatorEnabled = false
        dataSet.drawHorizontalHighlightIndicatorEnabled = false
        
        // Configurando o gráfico
        
        //Linhas
        vwMoodGraph.xAxis.drawAxisLineEnabled = true // ?
        vwMoodGraph.leftAxis.drawAxisLineEnabled = true // Linha exterior esquerda do eixo Y
        vwMoodGraph.rightAxis.drawAxisLineEnabled = false // Linha exterior direita do eixo Y
        vwMoodGraph.xAxis.drawGridLinesEnabled = false // Linhas internas verticais do eixo X
        vwMoodGraph.leftAxis.drawGridLinesEnabled = false // Linhas intenas horizontais do eixo X
        
        //
        vwMoodGraph.legend.enabled = false
        vwMoodGraph.setExtraOffsets(left: 15, top: 0, right: 20, bottom: 20)
        
        // Definindo o zoom padrão
        vwMoodGraph.dragEnabled = false
        vwMoodGraph.setScaleEnabled(false)
        
        // Labels ao redor do gráfico
        
        vwMoodGraph.rightAxis.enabled = false
        
        vwMoodGraph.xAxis.drawLabelsEnabled = true
        vwMoodGraph.xAxis.forceLabelsEnabled = true
        vwMoodGraph.xAxis.labelPosition = .bottom
        vwMoodGraph.xAxis.yOffset = 15
        vwMoodGraph.xAxis.labelFont = UIFont.systemFont(ofSize: 8.0)
        vwMoodGraph.xAxis.labelTextColor = .black
        vwMoodGraph.xAxis.granularityEnabled = true
        vwMoodGraph.xAxis.granularity = 1
        formatDateArray(chartList: mood)
        vwMoodGraph.xAxis.valueFormatter = xAxisValueFormatter(formattedDates: formattedDates, date: date)
        vwMoodGraph.xAxis.labelCount = date.count
        print(formattedDates)
        
        let timesOfDay = [
            Constants.Messages.Dawn,
            Constants.Messages.Morning,
            Constants.Messages.Afternoon,
            Constants.Messages.Night
        ]
        vwMoodGraph.leftAxis.drawLabelsEnabled = true
        vwMoodGraph.leftAxis.forceLabelsEnabled = true
        vwMoodGraph.leftAxis.labelPosition = .outsideChart
        vwMoodGraph.leftAxis.labelFont = UIFont.systemFont(ofSize: 12.0)
        vwMoodGraph.leftAxis.labelTextColor = .black
        vwMoodGraph.leftAxis.labelXOffset = -10
        vwMoodGraph.leftAxis.valueFormatter = IndexAxisValueFormatter(values: timesOfDay)
        vwMoodGraph.leftAxis.labelCount = timesOfDay.count
        vwMoodGraph.leftAxis.axisMinimum = 0
        vwMoodGraph.leftAxis.axisMaximum = 4
        
        // Adicionando o dataSet ao gráfico
        let data = LineChartData(dataSets: [dataSet])
        vwMoodGraph.data = data
        vwMoodGraph.notifyDataSetChanged()
    }
    
    private func formatDateArray(chartList: [ChartItem]) {
        formattedDates.removeAll()
        chartList.forEach { chart in
            formattedDates.append(chart.dateRegister.convertStringToDayAndMonth() ?? Constants.Messages.Empty)
        }
    }
    
    //-----------------------------------------------------------------------
    // MARK: ChartView Delegate
    //-----------------------------------------------------------------------
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        for chartItem in self.mood {
            if entry.x == chartItem.dateRegister.convertStringToDay() {
                delegate.showAnimationPopupGraph(chartItem)
            }
        }
    }
    
}
