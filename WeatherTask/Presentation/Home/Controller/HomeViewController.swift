//
//  HomeViewController.swift
//  WeatherTask
//
//  Created by qms on 22/03/2024.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController {

    let viewModel: HomeViewModel
    let locationManager = CLLocationManager()
    private let navigator: HomeCordinatorNavigator?
    let loaderView = UIActivityIndicatorView(style: .large)
    
    // MARK: - IBOUTLETS
    
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var locationButton: UIButton!
    
    // MARK: - Inits
    init(viewModel: HomeViewModel, navigator: HomeCordinatorNavigator) {
        self.viewModel = viewModel
        self.navigator = navigator
        super.init(nibName: "HomeViewController", bundle: nil)
        viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocationManager()
        // Do any additional setup after loading the view.
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    func getWeatherDetails(for lat: String, long: String) {
        showLoader()
        viewModel.getWeatherDetails(lat: lat, long: long)
    }
    
    func showLoader() {
        view.alpha = 0.5
        loaderView.color = .black
        loaderView.translatesAutoresizingMaskIntoConstraints = false
        loaderView.startAnimating()
        view.addSubview(loaderView)
        loaderView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loaderView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func hideLoader() {
        view.alpha = 1
        loaderView.removeFromSuperview()
    }
    
    // MARK: - IBActions
    
    @IBAction func locationTapped(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    @IBAction func searchTapped(_ sender: UIButton) {
        navigator?.searchTapped()
    }
    
}

// MARK: - HomeViewModel Delegate
extension HomeViewController: HomeViewModelDelegate {
    func updateWeatherDetails(result: GetWeatherResponseDTO) {
        hideLoader()
        temperatureLabel.text = "\(Int(result.main.temp))"
        cityLabel.text = result.name
        if let urlString = URL(string: Constants.imageBaseUrl + result.weather.first!.icon + Constants.weatherIconSize) {
            weatherIcon.loadImage(from: urlString)
        }
    }
   
    func showError(errorString: String) {
        hideLoader()
        showAlert(message: errorString)
    }
    
}

// MARK: - Location Manager Delegate
extension HomeViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let lat = location.coordinate.latitude
            let long = location.coordinate.longitude
            getWeatherDetails(for: "\(lat)", long: "\(long)")
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        guard locationManager.authorizationStatus != .notDetermined else { return }
        if let err = error as? CLError {
            switch err.errorCode {
            case 1:
                showAlert(message: "Please enable location services from settings")
            default:
                showAlert(message: error.localizedDescription)
            }
        } else {
            showAlert(message: error.localizedDescription)
        }
    }
    
}
