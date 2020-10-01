//
//  VFGStepControl.swift
//  VFGFoundation
//
//  Created by Yahya Saddiq on 8/25/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

open class VFGStepControl: UIView {
    private(set) var currentStep = 0
    private let maximumNumberOfSteps = 5
    lazy private var steps: [String] = {
        loadStepsData()
    }()

    lazy private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually

        return stackView
    }()

    public weak var delegate: VFGStepControlDelegate?
    public weak var dataSource: VFGStepControlDataSource? {
        didSet {
            load()
        }
    }

    @IBAction public func complete() {
        guard currentStep < stackView.subviews.count else {
            return
        }

        var stepView = (stackView.subviews[currentStep] as? VFGStepView)
        stepView?.updateUI(with: .complete)

        delegate?.stepControl(self, didCompleteStepAt: currentStep)

        guard currentStep + 1 < stackView.subviews.count else {
            return
        }

        currentStep += 1

        stepView = (stackView.subviews[currentStep] as? VFGStepView)
        stepView?.previousStepAction = .complete
        stepView?.updateUI(with: .inProgress)

        delegate?.stepControl(self, didMoveToStepAt: currentStep)
    }

    @IBAction public func skip() {
        guard currentStep < stackView.subviews.count else {
            return
        }

        var stepView = (stackView.subviews[currentStep] as? VFGStepView)
        stepView?.updateUI(with: .skip)

        delegate?.stepControl(self, didSkipStepAt: currentStep)

        guard currentStep + 1 < stackView.subviews.count else {
            return
        }

        currentStep += 1

        stepView = (stackView.subviews[currentStep] as? VFGStepView)
        stepView?.previousStepAction = .skip
        stepView?.updateUI(with: .inProgress)

        delegate?.stepControl(self, didMoveToStepAt: currentStep)
    }

    @IBAction public func previous() {
        guard currentStep - 1 >= 0 else {
            return
        }

        var stepView = (stackView.subviews[currentStep] as? VFGStepView)
        stepView?.updateUI(with: .pending)

        currentStep -= 1

        stepView = (stackView.subviews[currentStep] as? VFGStepView)
        stepView?.updateUI(with: .inProgress)

        delegate?.stepControl(self, didReturnToStepAt: currentStep)
    }
}

extension VFGStepControl {
    public func reload() {
        guard numberOfSteps() <= maximumNumberOfSteps else {
            return
        }

        if !stackView.subviews.isEmpty,
            stackView.subviews.count < numberOfSteps() {
            (stackView.subviews[stackView.subviews.count - 1] as? VFGStepView)?.updateUI(with: .link)
        }

        load()
    }

    private func load() {
        embed(view: stackView)

        for index in stackView.subviews.count..<numberOfSteps() {
            guard let stepView: VFGStepView = VFGStepView.loadXib(bundle: .foundation) else {
                return
            }

            stepView.setup(
                with: stepTitle(at: index),
                isFirstStep: index == 0,
                isLastStep: index == numberOfSteps() - 1)

            stackView.addArrangedSubview(stepView)

            delegate?.stepControl(self, didAddStepAt: index)
        }

        stackView.layoutIfNeeded()
    }

    private func numberOfSteps() -> Int {
        if dataSource != nil,
            let dataSource = dataSource {
            return dataSource.numberOfSteps(self)
        } else {
            return steps.count
        }
    }

    private func stepTitle(at index: Int) -> String {
        if dataSource != nil,
            let dataSource = dataSource {
            return dataSource.title(self, forStepAt: index)
        } else {
            return steps[index]
        }
    }

    private func loadStepsData() -> [String] {
        if let stepsFileURL = dataSource?.stepsDataURL(self) {
            do {
                let data = try Data(contentsOf: stepsFileURL, options: .mappedIfSafe)
                let decoder = JSONDecoder()
                guard let result = try? decoder.decode([String: [String]].self, from: data),
                    let steps = result["steps"] else {
                        VFGErrorLog("Failed to load steps from JSON file")
                        return []
                }

                return steps
            } catch {
                VFGErrorLog(error.localizedDescription)
            }
        }

        return []
    }
}
