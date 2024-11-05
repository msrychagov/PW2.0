//
//  ViewController.swift
//  msrychagovPW2
//
//  Created by Михаил Рычагов on 05.11.2024.
//

import UIKit

final class WishMakerViewController: UIViewController {
    //MARK: - Constants
    private enum Constants {
        static let title: String = "WishMaker"
        static let description: String = "Enter the color components of your wish"
        static let redSliderTitle: String = "Red"
        static let greenSliderTitle: String = "Green"
        static let blueSliderTitle: String = "Blue"
        static let titleFontSize: CGFloat = 32
        static let descriptionFontSize: CGFloat = 16
        static let descriptionLineHeight: Int = 24
        static let topConstraint: CGFloat = 10
        static let leftContraint: CGFloat = 20
        static let bottomConstraint: CGFloat = 40
        static let minSliderValue: Double = 0.0
        static let maxSliderValue: Double = 255.0
        static let stackCornerRadius: CGFloat = 20
        static let alphaValue: CGFloat = 1
        static let titleHeight: CGFloat = 110
        static let titleWidth: CGFloat = 350
        static let descriptionHeight: CGFloat = 50
        static let descriptionWidth: CGFloat = 350
        static let pinTopDescription: CGFloat = 80
        static let toggleButtonTitle: String = "Toggle Sliders"
        static let toggleButtonHeight: CGFloat = 50
        static let toggleButtonWidth: CGFloat = 350
        static let stackWidth: CGFloat = 350
        static let toggleButtonBottomConstraint: CGFloat = 20
    }
    
    //MARK: - Variables
    private var titleView = UILabel()
    private var descriptionView = UILabel()
    private var toggleButton = UIButton(type: .system)
    private var stack = UIStackView()
    private var redComponent = 0.0
    private var greenComponent = 0.0
    private var blueComponent = 0.0
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Configures
    private func configureUI() {
        configureTitle()
        configureDescription()
        configureSliders()
        configureToggleButton()
    }

    private func configureTitle() {
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.text = Constants.title
        titleView.font = UIFont.systemFont(ofSize: Constants.titleFontSize)
        titleView.textAlignment = .center
        titleView.backgroundColor = .white
        titleView.layer.cornerRadius = Constants.stackCornerRadius
        titleView.layer.masksToBounds = true


        view.addSubview(titleView)
        titleView.pinCenterX(to: view.safeAreaLayoutGuide.centerXAnchor)
        titleView.setHeight(Constants.titleHeight)
        titleView.setWidth(Constants.titleWidth)
        titleView.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Constants.topConstraint)
    }
    
    private func configureDescription() {
        descriptionView.translatesAutoresizingMaskIntoConstraints = false
        descriptionView.text = Constants.description
        descriptionView.font = UIFont.systemFont(ofSize: Constants.descriptionFontSize)
        descriptionView.textAlignment = .center
        descriptionView.backgroundColor = .white
        descriptionView.layer.cornerRadius = Constants.stackCornerRadius
        descriptionView.layer.masksToBounds = true
        
        view.addSubview(descriptionView)
        descriptionView.pinCenterX(to: titleView)
        descriptionView.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Constants.pinTopDescription)
        descriptionView.setHeight(Constants.descriptionHeight)
        descriptionView.setWidth(Constants.descriptionWidth)
    }

    private func configureSliders() {
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        view.addSubview(stack)
        
        stack.layer.cornerRadius = Constants.stackCornerRadius
        stack.clipsToBounds = true
        
        let sliderRed = CustomSlider(title: Constants.redSliderTitle, min: Constants.minSliderValue, max: Constants.maxSliderValue)
        let sliderGreen = CustomSlider(title: Constants.greenSliderTitle, min: Constants.minSliderValue, max: Constants.maxSliderValue)
        let sliderBlue = CustomSlider(title: Constants.blueSliderTitle, min: Constants.minSliderValue, max: Constants.maxSliderValue)
        
        stack.pinCenterX(to: view.centerXAnchor)
        stack.pinLeft(to: view.leadingAnchor, Constants.leftContraint)
        stack.pinBottom(to: view.bottomAnchor, Constants.bottomConstraint)
        stack.setWidth(Constants.stackWidth)
        
        for slider in [sliderRed, sliderBlue, sliderGreen] {
            stack.addArrangedSubview(slider)
            slider.valueChanged = { [weak self] value in
                guard let self = self else { return }
                
                switch slider {
                case sliderRed:
                    self.redComponent = value
                case sliderGreen:
                    self.greenComponent = value
                case sliderBlue:
                    self.blueComponent = value
                default: break
                }
                
                self.view.backgroundColor = UIColor(
                    red: CGFloat(self.redComponent / Constants.maxSliderValue),
                    green: CGFloat(self.greenComponent / Constants.maxSliderValue),
                    blue: CGFloat(self.blueComponent / Constants.maxSliderValue),
                    alpha: Constants.alphaValue
                )
            }
        }
    }
    
    private func configureToggleButton() {
            toggleButton.translatesAutoresizingMaskIntoConstraints = false
            toggleButton.setTitle(Constants.toggleButtonTitle, for: .normal)
            toggleButton.titleLabel?.font = UIFont.systemFont(ofSize: Constants.descriptionFontSize)
            toggleButton.backgroundColor = .white
            toggleButton.setTitleColor(.black, for: .normal)
            toggleButton.layer.cornerRadius = Constants.stackCornerRadius
            toggleButton.addTarget(self, action: #selector(toggleSlidersVisibility), for: .touchUpInside)
        
        
            view.addSubview(toggleButton)
            toggleButton.pinCenterX(to: view.centerXAnchor)
            toggleButton.setHeight(Constants.toggleButtonHeight)
            toggleButton.setWidth(Constants.toggleButtonWidth)
            toggleButton.pinBottom(to: stack.topAnchor, Constants.toggleButtonBottomConstraint)
        }

    // MARK: - Actions
    @objc private func toggleSlidersVisibility() {
            stack.isHidden.toggle()
        }
}

