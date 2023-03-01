//
//  StatisticTableViewCell.swift
//  MyFirstApp_20.02.
//
//  Created by Владислав on 28.02.2023.
//

import UIKit

class StatisticTableViewCell: UITableViewCell {
    enum Constants {
        static let numberTrainingLabelTrailingSpacing: CGFloat = 20.0
        static let numberTrainingWidthSpacing: CGFloat = 50.0
        static let trainingLabelTopSpacing: CGFloat = 0.0
        static let trainingLabelSideSpacing: CGFloat = 20.0
        static let stackViewStatisticLabelsTopSpacing: CGFloat = 5.0
        static let stackViewStatisticLabelsSideSpacing: CGFloat = 20.0
        static let lineViewBottomSpacing: CGFloat = 0.0
        static let lineViewSideSpacing: CGFloat = 20.0
        static let lineViewHeightSpacing: CGFloat = 1.0
    }
    
    //MARK: - Create UI
    
    private lazy var numberTrainingLabel: UILabel = {
        let label = UILabel()
        label.text = "+2"
        label.textColor = .specialGreen
        label.font = .robotoMedium24()
        label.textAlignment = .right
        return label
    }()
    
    private lazy var trainingLabel: UILabel = {
        let label = UILabel()
        label.text = "Biceps"
        label.textColor = .specialGray
        label.font = .robotoMedium24()
        return label
    }()
    
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .specialLine
        return view
    }()
    
    private lazy var beforeLabel = UILabel(text: "Before: 18")
    private lazy var nowLabel = UILabel(text: "Now: 20")
    private lazy var stackViewStatisticLabels = UIStackView()
    
    //MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .clear
        selectionStyle = .none
        
        addSubview(numberTrainingLabel)
        addSubview(trainingLabel)
        stackViewStatisticLabels = UIStackView(arrangedSubviews: [beforeLabel, nowLabel], axis: .horizontal, spacing: 10)
        
        addSubview(stackViewStatisticLabels)
        addSubview(lineView)
    }
}

extension StatisticTableViewCell {
    private func setConstraints() {
        numberTrainingLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            numberTrainingLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            numberTrainingLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.numberTrainingLabelTrailingSpacing),
            numberTrainingLabel.widthAnchor.constraint(equalToConstant: Constants.numberTrainingWidthSpacing)
        ])
        trainingLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            trainingLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constants.trainingLabelTopSpacing),
            trainingLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.trainingLabelSideSpacing),
            trainingLabel.trailingAnchor.constraint(equalTo: numberTrainingLabel.trailingAnchor, constant: -Constants.trainingLabelSideSpacing)
        ])
        stackViewStatisticLabels.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackViewStatisticLabels.topAnchor.constraint(equalTo: trainingLabel.bottomAnchor, constant: Constants.stackViewStatisticLabelsTopSpacing),
            stackViewStatisticLabels.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.stackViewStatisticLabelsSideSpacing)
        ])
        lineView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lineView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constants.lineViewBottomSpacing),
            lineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.lineViewSideSpacing),
            lineView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.lineViewSideSpacing),
            lineView.heightAnchor.constraint(equalToConstant: Constants.lineViewHeightSpacing)
        ])
    }
}
