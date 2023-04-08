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
}
class MoodGraphCell: UITableViewCell,
                     ChartViewDelegate,
                     AxisValueFormatter {
    
    @IBOutlet weak var vwMoodGraph: LineChartView!
    
    var hour: [Double] = []
    var yAxisLabels: [String] = []
    var formattedDates: [String] = []
    var formattedHours: [String] = []
    var mood: [ChartItem] = []
    var date: [String] = []
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
        self.hour.removeAll()
        
        for i in 0..<mood.count {
            let date = mood[i].dateRegister.convertStringToDay() ?? .zero
            let hourMood = Double(mood[i].dateRegister.convertStringToHourMood()) ?? .zero
            let icon = self.setImageMoodGraph(mood[i])
            self.date.append(String(date))
            self.hour.append(hourMood)
            let entry = ChartDataEntry(x: date, y: Double(i), icon: icon)
            dataEntries.append(entry)
            print(entry)
        }
        
        let dataSet = LineChartDataSet(entries: dataEntries, label: "Emoções")
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
        vwMoodGraph.leftAxis.drawLabelsEnabled = true
        vwMoodGraph.leftAxis.forceLabelsEnabled = true
        vwMoodGraph.leftAxis.labelPosition = .outsideChart
        vwMoodGraph.leftAxis.labelFont = UIFont.systemFont(ofSize: 12.0)
        vwMoodGraph.leftAxis.labelTextColor = .black
        vwMoodGraph.leftAxis.labelXOffset = -10
        vwMoodGraph.leftAxis.labelCount = mood.count
        formatDateArray(chartList: mood)
        vwMoodGraph.leftAxis.valueFormatter = IndexAxisValueFormatter(values: formattedHours)
        vwMoodGraph.leftAxis.valueFormatter = self
        print(formattedHours)
        
        vwMoodGraph.xAxis.drawLabelsEnabled = true
        vwMoodGraph.xAxis.forceLabelsEnabled = true
        vwMoodGraph.xAxis.labelPosition = .bottom
        vwMoodGraph.xAxis.labelFont = UIFont.systemFont(ofSize: 12.0)
        vwMoodGraph.xAxis.labelTextColor = .black
        vwMoodGraph.xAxis.granularityEnabled = true
        vwMoodGraph.xAxis.granularity = 1
        vwMoodGraph.xAxis.labelCount = mood.count
//        formatDateArray(chartList: mood)
//        vwMoodGraph.xAxis.valueFormatter = IndexAxisValueFormatter(values: formattedDates)
//        print(formattedDates)
        
        vwMoodGraph.rightAxis.enabled = false
        
        // Adicionando o dataSet ao gráfico
        let data = LineChartData(dataSets: [dataSet])
        vwMoodGraph.data = data
        vwMoodGraph.notifyDataSetChanged()
    }
    
    func findIndex( list: [Double],  value: Double) -> Int? {
        for (index, item) in list.enumerated() {
            if item == value {
                return index
            }
        }
        return nil
    }
    
    @objc func stringForValue(_ value: Double, axis: Charts.AxisBase?) -> String {
        return formattedHours[Int(value)]
    }

    
    func formatDateArray(chartList: [ChartItem]) {
        formattedHours.removeAll()
        chartList.forEach { chart in
            formattedHours.append(chart.dateRegister.convertStringToPeriod() ?? "")
        }
    }
    
    private func setImageMoodGraph(_ chart: ChartItem) -> UIImage? {
        
        switch chart.codHumor {
        case 1:
            return UIImage(named: "ic_apaixonado")?.resized(to: CGSize(width: 30, height: 30)) ?? UIImage()
        case 4:
            return UIImage(named: "ic_feliz")?.resized(to: CGSize(width: 30, height: 30)) ?? UIImage()
        case 7:
            return UIImage(named: "ic_triste")?.resized(to: CGSize(width: 30, height: 30)) ?? UIImage()
        case 5:
            return UIImage(named: "ic_espantado")?.resized(to: CGSize(width: 30, height: 30)) ?? UIImage()
        case 8:
            return UIImage(named: "ic_raiva")?.resized(to: CGSize(width: 30, height: 30)) ?? UIImage()
        case 6:
            return UIImage(named: "ic_entediado")?.resized(to: CGSize(width: 30, height: 30)) ?? UIImage()
        case 3:
            return UIImage(named: "ic_engracado")?.resized(to: CGSize(width: 30, height: 30)) ?? UIImage()
        case 10:
            return UIImage(named: "ic_doente")?.resized(to: CGSize(width: 30, height: 30)) ?? UIImage()
        case 9:
            return UIImage(named: "ic_frustrado")?.resized(to: CGSize(width: 30, height: 30)) ?? UIImage()
        case 2:
            return UIImage(named: "ic_sono")?.resized(to: CGSize(width: 30, height: 30)) ?? UIImage()
        default:
            break
        }
        
        return nil
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
