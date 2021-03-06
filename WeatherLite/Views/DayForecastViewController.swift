//
//  DayForecastViewController.swift
//  WeatherLite
//
//  Created by Ausianovich Kanstantsin on 27.02.2021.
//

import UIKit



final class DayForecastViewController: UIViewController {
    
    //MARK: - Main properties
    private var cityName: String = ""
    private var presenter: WeatherPresenterProtocol?
    var hourlyForecastController: HourlyForecastViewController?
    private var searchBarIsHidden: Bool = true
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.setSubviews()
        self.activateConstraints()
        
        let presenter = WeatherPresenter(delegate: self)
        self.set(presenter: presenter)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(self.updateCurrentPositionWeatherData))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(self.showSearchBar))
        
        self.updateCurrentPositionWeatherData()
    }
    
    //MARK: - Helpers

    func set(presenter: WeatherPresenterProtocol) {
        self.presenter = presenter
    }
    
    func setCity(name: String) {
        self.cityName = name
        self.navigationItem.title = self.cityName
    }
    
    @objc
    func updateCurrentPositionWeatherData() {
        self.presenter?.fetchCurrentPositionWeather()
    }
    
    @objc
    func showSearchBar() {
        UIView.animate(withDuration: 0.5) {
            if self.searchBarIsHidden {
                self.citySearchBar.frame.origin.y += self.citySearchBar.frame.height
                self.citySearchBar.becomeFirstResponder()
            } else {
                self.citySearchBar.frame.origin.y -= self.citySearchBar.frame.height
                self.citySearchBar.resignFirstResponder()
            }
        } completion: { _ in
            self.searchBarIsHidden.toggle()
        }
    }

    //MARK: - View hierarchy
    
    private func setSubviews() {
        self.view.addSubviews(self.mainContainerView)
        
        self.mainContainerView.addSubviews(self.mainWeatherInformerView, self.additionalWeatherInformerView, self.buttonContainerView)
        
        
        self.mainWeatherInformerView.addSubviews(self.citySearchBar ,self.weatherImage,self.locationLabel, self.weatherDataLabel)
        self.additionalWeatherInformerView.addSubviews(self.firstRowInformerDetailsContainer, self.secondRowInformerDetailsContainer)
        self.buttonContainerView.addSubviews(self.shareButton)
        
        self.firstRowInformerDetailsContainer.addSubviews(self.humidityContainer, self.rainContainer, self.pressureContainer)
        self.secondRowInformerDetailsContainer.addSubviews(self.windSpeedContainer, self.windDirectionContainer)
        
        self.humidityContainer.addSubviews(self.humidityUIImage, self.humidityLabel)
        self.rainContainer.addSubviews(self.rainUIImage, self.rainLabel)
        self.pressureContainer.addSubviews(self.pressureUIImage, self.pressureLabel)
        self.windSpeedContainer.addSubviews(self.windSpeedUIImage, self.windSpeedLabel)
        self.windDirectionContainer.addSubviews(self.windDirectionUIImage, self.windDirectionLabel)
        
    }
    
    //MARK: - Constraints
    
    private func activateConstraints() {
        
        NSLayoutConstraint.activate([
            self.mainContainerView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.mainContainerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.mainContainerView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.mainContainerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
            self.mainWeatherInformerView.topAnchor.constraint(equalTo: self.mainContainerView.safeAreaLayoutGuide.topAnchor),
            self.mainWeatherInformerView.leadingAnchor.constraint(equalTo: self.mainContainerView.leadingAnchor),
            self.mainWeatherInformerView.trailingAnchor.constraint(equalTo: self.mainContainerView.trailingAnchor),
            self.mainWeatherInformerView.heightAnchor.constraint(equalTo: self.mainContainerView.heightAnchor, multiplier: 0.5, constant: 0),
            
            self.additionalWeatherInformerView.topAnchor.constraint(equalTo: self.mainWeatherInformerView.bottomAnchor),
            self.additionalWeatherInformerView.leadingAnchor.constraint(equalTo: self.mainContainerView.leadingAnchor),
            self.additionalWeatherInformerView.trailingAnchor.constraint(equalTo: self.mainContainerView.trailingAnchor),
            self.additionalWeatherInformerView.heightAnchor.constraint(equalTo: self.mainContainerView.heightAnchor, multiplier: 0.35, constant: 0),

            self.buttonContainerView.topAnchor.constraint(equalTo: self.additionalWeatherInformerView.bottomAnchor),
            self.buttonContainerView.leadingAnchor.constraint(equalTo: self.mainContainerView.leadingAnchor),
            self.buttonContainerView.trailingAnchor.constraint(equalTo: self.mainContainerView.trailingAnchor),
            self.buttonContainerView.bottomAnchor.constraint(equalTo: self.mainContainerView.bottomAnchor),
            
            self.citySearchBar.topAnchor.constraint(equalTo: self.mainWeatherInformerView.topAnchor),
            self.citySearchBar.leadingAnchor.constraint(equalTo: self.mainWeatherInformerView.leadingAnchor),
            self.citySearchBar.trailingAnchor.constraint(equalTo: self.mainWeatherInformerView.trailingAnchor),

            self.weatherImage.centerXAnchor.constraint(equalTo: self.mainWeatherInformerView.centerXAnchor),
            self.weatherImage.centerYAnchor.constraint(equalTo: self.mainWeatherInformerView.centerYAnchor),
            
            self.locationLabel.topAnchor.constraint(equalTo: self.weatherImage.bottomAnchor),
            self.locationLabel.centerXAnchor.constraint(equalTo: self.mainWeatherInformerView.centerXAnchor),

            self.weatherDataLabel.topAnchor.constraint(equalTo: self.locationLabel.bottomAnchor),
            self.weatherDataLabel.centerXAnchor.constraint(equalTo: self.mainWeatherInformerView.centerXAnchor),
            
            self.firstRowInformerDetailsContainer.topAnchor.constraint(equalTo: self.additionalWeatherInformerView.topAnchor),
            self.firstRowInformerDetailsContainer.leadingAnchor.constraint(equalTo: self.additionalWeatherInformerView.leadingAnchor),
            self.firstRowInformerDetailsContainer.trailingAnchor.constraint(equalTo: self.additionalWeatherInformerView.trailingAnchor),
            
            self.secondRowInformerDetailsContainer.topAnchor.constraint(equalTo: self.firstRowInformerDetailsContainer.bottomAnchor),
            self.secondRowInformerDetailsContainer.leadingAnchor.constraint(equalTo: self.additionalWeatherInformerView.leadingAnchor),
            self.secondRowInformerDetailsContainer.bottomAnchor.constraint(equalTo: self.additionalWeatherInformerView.bottomAnchor),
            self.secondRowInformerDetailsContainer.trailingAnchor.constraint(equalTo: self.additionalWeatherInformerView.trailingAnchor),
            self.secondRowInformerDetailsContainer.heightAnchor.constraint(equalTo: self.firstRowInformerDetailsContainer.heightAnchor),
            
            self.humidityContainer.topAnchor.constraint(equalTo: self.firstRowInformerDetailsContainer.topAnchor),
            self.humidityContainer.bottomAnchor.constraint(equalTo: self.firstRowInformerDetailsContainer.bottomAnchor),
            self.humidityContainer.leadingAnchor.constraint(equalTo: self.firstRowInformerDetailsContainer.leadingAnchor),
            
            self.rainContainer.topAnchor.constraint(equalTo: self.firstRowInformerDetailsContainer.topAnchor),
            self.rainContainer.leadingAnchor.constraint(equalTo: self.humidityContainer.trailingAnchor),
            self.rainContainer.bottomAnchor.constraint(equalTo: self.firstRowInformerDetailsContainer.bottomAnchor),
            self.rainContainer.widthAnchor.constraint(equalTo: self.humidityContainer.widthAnchor),
            
            self.pressureContainer.topAnchor.constraint(equalTo: self.firstRowInformerDetailsContainer.topAnchor),
            self.pressureContainer.leadingAnchor.constraint(equalTo: self.rainContainer.trailingAnchor),
            self.pressureContainer.bottomAnchor.constraint(equalTo: self.firstRowInformerDetailsContainer.bottomAnchor),
            self.pressureContainer.trailingAnchor.constraint(equalTo: self.firstRowInformerDetailsContainer.trailingAnchor),
            self.pressureContainer.widthAnchor.constraint(equalTo: self.humidityContainer.widthAnchor),
            
            self.windSpeedContainer.topAnchor.constraint(equalTo: self.secondRowInformerDetailsContainer.topAnchor),
            self.windSpeedContainer.leadingAnchor.constraint(equalTo: self.secondRowInformerDetailsContainer.leadingAnchor),
            self.windSpeedContainer.bottomAnchor.constraint(equalTo: self.secondRowInformerDetailsContainer.bottomAnchor),
            
            self.windDirectionContainer.topAnchor.constraint(equalTo: self.secondRowInformerDetailsContainer.topAnchor),
            self.windDirectionContainer.leadingAnchor.constraint(equalTo: self.windSpeedContainer.trailingAnchor),
            self.windDirectionContainer.bottomAnchor.constraint(equalTo: self.secondRowInformerDetailsContainer.bottomAnchor),
            self.windDirectionContainer.trailingAnchor.constraint(equalTo: self.secondRowInformerDetailsContainer.trailingAnchor),
            self.windDirectionContainer.widthAnchor.constraint(equalTo: self.windSpeedContainer.widthAnchor),
            
            self.humidityUIImage.centerYAnchor.constraint(equalTo: self.humidityContainer.centerYAnchor),
            self.humidityUIImage.centerXAnchor.constraint(equalTo: self.humidityContainer.centerXAnchor),
            self.humidityLabel.centerXAnchor.constraint(equalTo: self.humidityContainer.centerXAnchor),
            self.humidityLabel.topAnchor.constraint(equalTo: self.humidityUIImage.bottomAnchor),
            
            self.rainUIImage.centerYAnchor.constraint(equalTo: self.rainContainer.centerYAnchor),
            self.rainUIImage.centerXAnchor.constraint(equalTo: self.rainContainer.centerXAnchor),
            self.rainLabel.centerXAnchor.constraint(equalTo: self.rainContainer.centerXAnchor),
            self.rainLabel.topAnchor.constraint(equalTo: self.rainUIImage.bottomAnchor),
            
            self.pressureUIImage.centerYAnchor.constraint(equalTo: self.pressureContainer.centerYAnchor),
            self.pressureUIImage.centerXAnchor.constraint(equalTo: self.pressureContainer.centerXAnchor),
            self.pressureLabel.centerXAnchor.constraint(equalTo: self.pressureContainer.centerXAnchor),
            self.pressureLabel.topAnchor.constraint(equalTo: self.pressureUIImage.bottomAnchor),
            
            self.windSpeedUIImage.centerYAnchor.constraint(equalTo: self.windSpeedContainer.centerYAnchor),
            self.windSpeedUIImage.centerXAnchor.constraint(equalTo: self.windSpeedContainer.centerXAnchor),
            self.windSpeedLabel.centerXAnchor.constraint(equalTo: self.windSpeedContainer.centerXAnchor),
            self.windSpeedLabel.topAnchor.constraint(equalTo: self.windSpeedUIImage.bottomAnchor),
            
            self.windDirectionUIImage.centerYAnchor.constraint(equalTo: self.windDirectionContainer.centerYAnchor),
            self.windDirectionUIImage.centerXAnchor.constraint(equalTo: self.windDirectionContainer.centerXAnchor),
            self.windDirectionLabel.centerXAnchor.constraint(equalTo: self.windDirectionContainer.centerXAnchor),
            self.windDirectionLabel.topAnchor.constraint(equalTo: self.windDirectionUIImage.bottomAnchor),
            
            
            self.shareButton.centerXAnchor.constraint(equalTo: self.buttonContainerView.centerXAnchor),
            self.shareButton.centerYAnchor.constraint(equalTo: self.buttonContainerView.centerYAnchor)
        ])
    }
    
    //MARK: - View elements
    
    //Main level
    lazy var mainContainerView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //Blocks level
    lazy var mainWeatherInformerView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var additionalWeatherInformerView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var buttonContainerView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MainWeatherInformedView Details level
    
    lazy var citySearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .prominent
        searchBar.placeholder = "Search..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.delegate = self
        searchBar.frame.origin.y -= searchBar.frame.height
        return searchBar
    }()
    
    lazy var weatherImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var locationLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var weatherDataLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(descriptor: UIFontDescriptor(), size: 30)
        return label
    }()
    
    // ButtonContainerView Details level
    
    lazy var shareButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Share", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(shareButtonPressed), for: .touchUpInside)
        return button
    }()
    
    @objc
    func shareButtonPressed(sender: UIButton!) {
        let text = "Today is \(self.weatherDataLabel.text ?? "")"
        
        let textToShare = [text]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    //AdditionalWeatherInformerView Container Level
    
    lazy var firstRowInformerDetailsContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var secondRowInformerDetailsContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //AdditionalWeatherInformerView Containers Level two
    
    lazy var humidityContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var rainContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var pressureContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var windSpeedContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var windDirectionContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //AdditionalWeatherInformerView Containers Level three
    
    
    lazy var humidityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var humidityUIImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "humidity")
        return image
    }()
    
    lazy var rainLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var rainUIImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "rain")
        return image
    }()
    
    lazy var pressureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var pressureUIImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "pressure")
        return image
    }()
    
    lazy var windSpeedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var windSpeedUIImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "windSpeed")
        return image
    }()
    
    lazy var windDirectionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var windDirectionUIImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "windDirection")
        return image
    }()
}

//MARK: - Extension: DayForecastViewDelegate
extension DayForecastViewController: DayForecastViewDelegate {
    
    func updateDayForecastViewController(with model: DayWeatherDTO) {
        self.setCity(name: model.location ?? "")
        self.weatherImage.image = UIImage(named: model.weatherCondition ?? "")
        self.locationLabel.text = model.location
        self.weatherDataLabel.text = (model.temperature ?? "") + "°"
        self.humidityLabel.text = model.humidity
        self.rainLabel.text = model.rain
        self.pressureLabel.text = model.pressure
        self.windSpeedLabel.text = model.windSpeed
        self.windDirectionLabel.text = model.windDirectionString
    }
    
    func show(_ error: Error) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
    }
}

//MARK: - Extension: UISearchBarDelegate
extension DayForecastViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.citySearchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.text = ""
        searchBar.resignFirstResponder()
        self.showSearchBar()
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
        self.showSearchBar()
        guard let cityName = searchBar.text else {return}
        self.presenter?.fetchWeather(with: cityName)
        self.hourlyForecastController?.updayteData(with: cityName)
    }
}
