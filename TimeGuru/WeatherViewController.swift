//
//  WeatherViewController.swift
//  TimeGuru
//
//  Created by Samuel Turschic on 2022-04-06.
//
import Foundation
import UIKit

let apiKey = "8741296de0b3a921b78384ba552a3995"

var JSONData: Data?

private struct WeatherResult: Codable{
    var weather: [weather]
    var main: main
}
private struct main: Codable{
    var temp: Double
}
private struct weather: Codable{
    var main: String
    var description: String
}

class WeatherViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let city: String = "Waterloo"
        let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=imperial")
        // Do any additional setup after loading the view.
        loadJSONData(url: url)
    }
    
    func decodeJSONData(JSONData: Data){
        do{
            let weatherData = try? JSONDecoder().decode(WeatherResult.self, from: JSONData)
            if let weatherData = weatherData{
                let weatherN = weatherData.main
                print(weatherN.temp)
                let weatherS = weatherData.weather
                print(weatherS[0].main)
                print(weatherS[0].description)
                
                let currentDateTime = Date()
                // get the user's calendar
                let userCalendar = Calendar.current
                // choose which date and time components are needed
                let requestedComponents: Set<Calendar.Component> = [.hour]
                // get the components
                let dateTimeComponents = userCalendar.dateComponents(requestedComponents, from: currentDateTime)
                // now the components are available
                print(dateTimeComponents.hour!)
            }

        }
    }

    func loadJSONData(url: URL?){
        
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            if let error = error{
                print("Error : \(error.localizedDescription)")
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("Error : HTTP Response Code Error")
                return
            }
            guard let data = data else {
                print("Error : No Response")
                return
            }
            self.decodeJSONData(JSONData: data)
        }
        task.resume()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
