//
//  ViewController.swift
//  BillGraphDemo
//
//  Created by Salma Ashour on 6/13/20.
//  Copyright © 2020 Salma Ashour. All rights reserved.
//

import UIKit
import VFGMVA10Billing

class ViewController: UIViewController {

    @IBOutlet weak var headerView: UIView!
    var chartView: VFGChartView?

    override func viewDidLoad() {
        super.viewDidLoad()

        chartView = VFGChartView.loadXib(bundle: Bundle.mva10Billing)
        chartView?.frame = CGRect(x: 0, y: 0, width: headerView.bounds.size.width, height: 200)
        chartView?.autoresizingMask = .flexibleWidth
        chartView?.delegate = self
        chartView?.minBarsToBeViewed = 6
        self.headerView.addSubview(chartView ?? UIView())
        self.fetchHistoryData { [weak self] (bills) in
        self?.chartView?.configure(dashboardList: bills)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self?.chartView?.selectBarItem(row: 0)
            }
        }
    }


    func fetchHistoryData(completion: @escaping ([HistoryModel]) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(2500)) {
            if let histroyModelPath = Bundle.main.url(forResource: "billing_histroy_stub",
                                                              withExtension: "json") {
                do {
                    let data = try Data(contentsOf: histroyModelPath, options: .mappedIfSafe)
                    let decoder = JSONDecoder()
                    let histroyModel = try decoder.decode([HistoryModel].self, from: data)
                    completion(histroyModel)
                } catch (let error){
                    debugPrint(error)
                }
            }
        }
    }
}

extension ViewController: ChartViewDelegate {
    var billingPeriodFormat: BillingPeriodFormat {
        return .custom(format: "dd.MM")
    }
    
    public func seeBillButtonPressed(selectedRowInRecentBills selectedRow: Int) {
        //Open your view controller
        print("See bills clicked at: \(selectedRow)")
    }
}
