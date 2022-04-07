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

struct WeatherStr: Codable{
    var main: String?
    var description: String?
}
struct WeatherNum: Codable{
    var temp: Double?
}
struct WeatherMain: Codable{
    let main: WeatherNum
}
struct WeatherW: Codable{
    let weather: WeatherStr
}

func decodeJSONData(JSONData: Data){
    do{
        let weatherNumData = try? JSONDecoder().decode(WeatherMain.self, from: JSONData)
        let weatherStrData = try? JSONDecoder().decode(WeatherW.self, from: JSONData)
        if let weatherNumData = weatherNumData, let weatherStrData = weatherStrData{
            let weatherN = weatherNumData.main
            let weatherS = weatherStrData.weather
            print(weatherN.temp!)
            print(weatherS.main!)
            print(weatherS.description!)
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
        decodeJSONData(JSONData: data)
    }
    task.resume()
}


class WeatherViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let city: String = "Waterloo"
        let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=imperial")
        // Do any additional setup after loading the view.
        loadJSONData(url: url)
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
