//
//  ViewController.swift
//  CryptoWallet
//
//  Created by Kirill Khudiakov on 21/03/2019.
//  Copyright © 2019 Kirill Khudiakov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import KKExtensions
import Charts


struct Pair {
    var from: String
    var to: String
}

class CryptoListViewModel {
    
    let items = ReplaySubject<[Pair]>.create(bufferSize: 1)
    
    var instruments: [Pair] = [
        Pair(from: "BTC", to: "USD"),
        Pair(from: "ETH", to: "USD"),
        Pair(from: "GBP", to: "USD"),
        Pair(from: "EUR", to: "USD"),
    ]
    
    var gradientColors: [String: [CGColor]] = [
        "BTC": [UIColor(hex: "F5317F").cgColor, UIColor(hex: "FF7C6E").cgColor],
        "ETH": [UIColor(hex: "8739E5").cgColor,
                  UIColor(hex: "5496FF").cgColor],
        "GBP": [UIColor(hex: "E56336").cgColor,
                   UIColor(hex: "FFDF40").cgColor],
        "EUR": [UIColor(hex: "A5E94A").cgColor,
                  UIColor(hex: "429321").cgColor]
        ]

    
    init() {
        items.onNext(instruments)
    }
    
}

class ViewController: UIViewController {

    let bag = DisposeBag()
    
    var lineChartView = LineChartView(frame: .zero)
    var pairsPickerView = PairsPickersView(frame: .zero)
    var values: [ChartDataEntry] = []
    var updateButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Crypto Wallet"
        view.addGradient(cgColors: Config.Gradients.dark,
                         startPoint: CGPoint(x: 0, y: 0),
                         endPoint: CGPoint(x: 0, y: 1))
        view.addSubview(lineChartView)
        view.addSubview(pairsPickerView)
        setupChart()
        setupConstraints()
        
        pairsPickerView.rx.selectedPair.subscribe(onNext: {
            [weak self] selectedPair in
                self?.updateValues(for: selectedPair)
            })
            .disposed(by: bag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func updateChart() {
        let data = chartData(values: values)
        DispatchQueue.main.async {
            self.lineChartView.data = LineChartData(dataSet: data)
            self.lineChartView.animate(xAxisDuration: 3)
        }
    }
    
    func updateValues(for pair: Pair) {
        self.values.removeAll()
        CryptoService.shared.get(from: pair.from, to: pair.to, limit: 40) { a in
            for bar in a.Data.enumerated() {
                let entry = ChartDataEntry(x: Double(bar.offset) , y: Double(bar.element.close))
                self.values.append(entry)
            }
            self.updateChart()
        }
    }
    
    func setupConstraints() {

        lineChartView.translatesAutoresizingMaskIntoConstraints = false
        lineChartView.topAnchor
            .constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40)
            .isActive = true
        lineChartView.leftAnchor
            .constraint(equalTo: view.leftAnchor)
            .isActive = true
        lineChartView.rightAnchor
            .constraint(equalTo: view.rightAnchor)
            .isActive = true
        lineChartView.heightAnchor
            .constraint(equalToConstant: 200)
            .isActive = true
        
        pairsPickerView.translatesAutoresizingMaskIntoConstraints = false
        pairsPickerView.centerXAnchor
            .constraint(equalTo: view.centerXAnchor)
            .isActive = true
        pairsPickerView.widthAnchor
            .constraint(equalTo: view.widthAnchor, constant: -20)
            .isActive = true
        
        pairsPickerView.topAnchor
            .constraint(equalTo: lineChartView.bottomAnchor, constant: 10)
            .isActive = true
        pairsPickerView.bottomAnchor
            .constraint(equalTo: view.bottomAnchor, constant: -10)
            .isActive = true
        
    }
    
    func chartData(values: [ChartDataEntry]) -> LineChartDataSet {
        let dataSet = LineChartDataSet(values: values, label: "Alfa")
        dataSet.mode = .cubicBezier
        dataSet.fillAlpha = 0.5
        dataSet.circleRadius = 2
        dataSet.circleHoleRadius = 0
        dataSet.setCircleColor(.white)
        dataSet.drawCirclesEnabled = false
        dataSet.valueColors = [UIColor.white]
        dataSet.drawValuesEnabled = false
        dataSet.lineWidth = 3
        
        // Gradient line
        dataSet.drawGradientEnabled = true
        dataSet.gradientPositions = [1, 29]
        
        // colors
        dataSet.setColors(
        UIColor(hex: "6A3FBE"),
        UIColor(hex: "B04FE9")
        )
        
        
        let colors: [CGColor] = Config.Gradients.dark.reversed()
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        if let gradient = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: nil) {
            dataSet.fill = Fill(linearGradient: gradient, angle: 90)
        }
        dataSet.drawFilledEnabled = false
        return dataSet
    }
    
    func setupChart() {
        
        lineChartView.drawBordersEnabled = false
        lineChartView.drawGridBackgroundEnabled = false
        lineChartView.noDataText = "No data"
        lineChartView.noDataTextColor = .white
        lineChartView.borderColor = .white
        lineChartView.legend.textColor = .white
        
        lineChartView.xAxis.enabled = false
        lineChartView.leftAxis.enabled = false
        lineChartView.rightAxis.enabled = false
        lineChartView.xAxis.gridColor = .white
        lineChartView.xAxis.labelTextColor = .white
        lineChartView.rightAxis.gridColor = .white
        lineChartView.leftAxis.labelTextColor = .white
        lineChartView.leftAxis.drawLabelsEnabled = false
        lineChartView.rightAxis.labelTextColor = .white
        lineChartView.highlightPerTapEnabled = false
        lineChartView.highlightPerDragEnabled = false
        lineChartView.legend.enabled = false
        
    }
}

