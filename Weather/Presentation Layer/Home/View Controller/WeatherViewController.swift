//
//  WeatherViewController.swift
//  Weather
//
//  Created by Ahmed Osman on 24/01/2021.
//

import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var enterCityTextView: UITextField!
    @IBOutlet weak private var onlineSwitch: UISwitch!
    @IBOutlet weak private var currentDescLabel: UILabel!
    @IBOutlet weak private var currentTempLabel: UILabel!
    @IBOutlet weak private var currentStatusIcon: UIImageView!
    @IBOutlet weak private var tableView: UITableView!
    private var presenter: WeatherPresenter?
    private var storedOffsets = [Int: CGFloat]()
    private var daysWeatherUIModel: [DayWeatherUIModel]?
    weak private var loaderView :UIActivityIndicatorView?
    private var city: String = K.Weather.München
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = city
        enterCityTextView.delegate = self
        setupNavigationBar()
        addLoader()
        tableView.register(UINib(nibName: K.Nib.dayWeatherNib, bundle: nil), forCellReuseIdentifier: K.CellIdentifiers.dayCellIdentifier)
        onlineSwitch.addTarget(self, action: #selector(toggleNetwork), for: .valueChanged)
        tableView.dataSource = self
        tableView.delegate = self
        presenter = WeatherPresenter(weatherViewControllerDelegate: self)
        presenter?.getForecast(city: city)
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.navigationBar.barTintColor = .clear
        self.navigationController?.navigationBar.tintColor = .clear
    }
    
    private func addLoader() {
        let loader = UIActivityIndicatorView(frame: CGRect(origin: self.view.center, size: CGSize(width: 50, height: 50)))
        loader.hidesWhenStopped = true
        self.view.addSubview(loader)
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        loader.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        self.view.bringSubviewToFront(loader)
        loader.startAnimating()
        self.loaderView = loader
    }
    
    @objc private func toggleNetwork() {
        let isOnline = onlineSwitch.isOn
        presenter?.getForecast(city: city, isOnline: isOnline)
    }
}

extension WeatherViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return daysWeatherUIModel?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? DayWeatherTableViewCell else { return }
        cell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tableViewCell = cell as? DayWeatherTableViewCell else { return }
        storedOffsets[indexPath.row] = tableViewCell.collectionViewOffset
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: K.CellIdentifiers.dayCellIdentifier, for: indexPath) as? DayWeatherTableViewCell else { return UITableViewCell() }
        let date = daysWeatherUIModel?[indexPath.row].date
        cell.setup(date: date, controller: self, row: indexPath.row)
        return cell
    }
}

extension WeatherViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return daysWeatherUIModel?[collectionView.tag].timesWeather?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.CellIdentifiers.timeCellIdentifier, for: indexPath) as? TimeWeatherCollectionCell else { return UICollectionViewCell() }
        let time = daysWeatherUIModel?[collectionView.tag].timesWeather?[indexPath.item].time
        let icon = daysWeatherUIModel?[collectionView.tag].timesWeather?[indexPath.item].icon
        let temp = daysWeatherUIModel?[collectionView.tag].timesWeather?[indexPath.item].temp
        cell.setup(time: time, icon: icon, temp: temp)
        return cell
    }
}

extension WeatherViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        city = textField.text ?? ""
        navigationItem.title = city
        presenter?.getForecast(city: city, isOnline: onlineSwitch.isOn)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

extension WeatherViewController: WeatherViewControllerDelegate {
    
    func updateUI(weatherUIModel: WeatherUIModel?) {
        currentStatusIcon.setImage(url: weatherUIModel?.nowIcon ?? "")
        currentDescLabel.text = weatherUIModel?.nowStatus
        currentTempLabel.text = weatherUIModel?.nowTemp
        self.daysWeatherUIModel = weatherUIModel?.daysWeather
        tableView.reloadData()
    }
    
    func showLoader() {
        self.loaderView?.startAnimating()
    }
    
    func hideLoader() {
        self.loaderView?.stopAnimating()
    }
}
