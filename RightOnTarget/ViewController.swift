//
//  ViewController.swift
//  RightOnTarget
//
//  Created by Nataliya Lazouskaya on 25.06.22.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var valueSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 1
        slider.maximumValue = 50
        slider.value = 25
        // slider.maximumTrackTintColor = .systemPink
        slider.minimumTrackTintColor = .systemPink
        slider.thumbTintColor = .systemPink
        slider.minimumValueImage = UIImage(systemName: "01.square.fill")?.withTintColor(.systemPurple, renderingMode: .alwaysOriginal)
        slider.maximumValueImage = UIImage(systemName: "50.square.fill")?.withTintColor(.systemPurple, renderingMode: .alwaysOriginal)
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        return slider
    }()
    
    private lazy var checkButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Check", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.tintColor = .systemIndigo
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let checkLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        //            label.textColor = .specialGray
        //            label.font = .robotoMedium24()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var aboutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("About", for: .normal)
        button.tintColor = .systemIndigo
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(aboutButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var number = 0
    var round = 1
    var points = 0
    
    
    
    override func loadView() {
        super.loadView()
        
        print("Load View")
        
        let versionLabel = UILabel(frame: CGRect(x: 20, y: 10, width: 200, height: 20))
        versionLabel.text = "Version 1.1"
        view.addSubview(versionLabel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        setupViews()
        setConstraints()
        // Do any additional setup after loading the view.
        print("View Did Load")
        number = Int.random(in: 1...50)
        checkLabel.text = String(number)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("View Will Appear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("View Did Appear")
        
        guard let navBar = navigationController?.navigationBar else { return }
        title = "RightOnTarget"
        // navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Restore",
        //                                                   style: .plain,
        //                                                   target: self,
        //                                                    action: #selector(restorePressed))
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        navBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navBar.tintColor = .white
        navBar.standardAppearance = navBarAppearance
        navBar.scrollEdgeAppearance = navBarAppearance
        
        self.navigationController?.navigationBar.setNeedsLayout()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    @objc private func sliderValueChanged() {
        
    }
    
    @objc private func checkButtonTapped() {
        checkNumber()
    }
    
    @objc private func aboutButtonTapped() {
        //  self.show(vc, sender: self)
        let vc = SecondViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setupViews() {
        view.addSubview(valueSlider)
        view.addSubview(checkButton)
        view.addSubview(checkLabel)
        view.addSubview(aboutButton)
    }
    
    func checkNumber() {
        let sliderNum = Int(valueSlider.value.rounded())
        if sliderNum > number {
            points += (50 - sliderNum + number)
        } else {
            points += (50 - number + sliderNum)
        }
        if round == 5 {
            let alert = UIAlertController(title: "Game over", message: "You've earned \(points) points", preferredStyle: .alert)
            let action = UIAlertAction(title: "Start again", style: .default)
            alert.addAction(action)
            present(alert, animated: true)
            round = 1
            points = 0
        }
        number = Int.random(in: 1...50)
        checkLabel.text = String(number)
        round += 1
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            valueSlider.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            valueSlider.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            valueSlider.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            checkButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            checkButton.topAnchor.constraint(equalTo: valueSlider.bottomAnchor, constant: 30),
            checkButton.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            checkLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            checkLabel.topAnchor.constraint(equalTo: checkButton.bottomAnchor, constant: 30),
            checkLabel.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            aboutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            aboutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

