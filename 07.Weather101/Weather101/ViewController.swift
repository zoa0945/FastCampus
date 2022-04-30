//
//  ViewController.swift
//  Weather101
//
//  Created by Mac on 2022/01/03.
//

/*
 Codable
    - 자신을 변환하거나 외부 타입을 변환 가능하게 해주는 프로토콜
    - 객체에서 Codable을 채택하게 되면 JSON객체를 변환하거나 JSON객체로 변환가능
 */

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var cityNameTextView: UITextField!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var weatherStackView: UIStackView!
    
    let apiKey = "5c756784368aff43ab330c87a2546be1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func configureView(weatherInfo: WeatherInfo) {
        self.cityNameLabel.text = weatherInfo.cityName
        if let weather = weatherInfo.weather.first {
            self.weatherDescriptionLabel.text = weather.description
        }
        self.tempLabel.text = "\(Int(weatherInfo.temparature.temp - 273.15))℃"
        self.minTempLabel.text = "최저: \(Int(weatherInfo.temparature.minTemp - 273.15))℃"
        self.maxTempLabel.text = "최고: \(Int(weatherInfo.temparature.maxTemp - 273.15))℃"
    }

    @IBAction func tapWeatherDescriptionButton(_ sender: UIButton) {
        if let cityName = self.cityNameTextView.text {
            self.getWeatherDescription(cityName: cityName)
            self.view.endEditing(true)
        }
    }
    
    func showAlert(errorMessage: String) {
        let alert = UIAlertController(title: "도시를 찾을 수 없습니다.", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func getWeatherDescription(cityName: String) {
        guard let url = URL(
            string: "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=\(apiKey)"
        ) else { return }
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: url) { [weak self] data, response, error in
            let statusRange = 200..<300
            guard let data = data, error == nil else { return }
            let decoder = JSONDecoder()
            if let response = response as? HTTPURLResponse, statusRange.contains(response.statusCode) {
                guard let info = try? decoder.decode(WeatherInfo.self, from: data) else { return }
                DispatchQueue.main.async {
                    self?.weatherStackView.isHidden = false
                    self?.configureView(weatherInfo: info)
                }
            } else {
                guard let errorMessage = try? decoder.decode(ErrorMessage.self, from: data) else { return }
                DispatchQueue.main.async {
                    self?.showAlert(errorMessage: errorMessage.message)
                }
            }
        }
        dataTask.resume()
    }
}

