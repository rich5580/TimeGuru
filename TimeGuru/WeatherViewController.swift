//
//  WeatherViewController.swift
//  TimeGuru
//
//  Created by Samuel Turschic on 2022-04-06.
//
import Foundation
import UIKit

let apiKey = "8741296de0b3a921b78384ba552a3995"
// Website where images were created, attribute
// "https://www.flaticon.com/free-icons"

var JSONData: Data?

private struct WeatherResult: Codable{
    var weather: [weather]
    var main: main
    var dt: Double
    var sys: sys
}
private struct main: Codable{
    var temp: Double
}
private struct weather: Codable{
    var main: String
    var description: String
}
private struct sys: Codable{
    var sunrise: Double
    var sunset: Double
}

class WeatherViewController: UIViewController {

    @IBOutlet weak var dotw: UILabel!
    @IBOutlet weak var weatherImg: UIImageView!
    @IBOutlet weak var weatherDescLbl: UILabel!
    @IBOutlet weak var tempLbl: UILabel!
    @IBOutlet weak var bgrnd: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let city: String = "Waterloo"
        let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=imperial")
        // Do any additional setup after loading the view.
        loadJSONData(url: url)
        
    }
    
    func dayBackground(){
        self.bgrnd.backgroundColor = UIColor(red: 100.0/255.0, green: 170.0/255.0, blue: 1.0, alpha: 1.0)
    }
    func nightBackground(){
        self.bgrnd.backgroundColor = UIColor(red: 70.0/255.0, green: 70.0/255.0, blue: 70.0/255.0, alpha: 1.0)
    }
    func decodeJSONData(JSONData: Data){
        do{
            let weatherData = try? JSONDecoder().decode(WeatherResult.self, from: JSONData)
            if let weatherData = weatherData{
                DispatchQueue.main.async {
                    let weatherN = weatherData.main
                    print("Temp:")
                    let temp = self.calculateCelsius(fahrenheit: weatherN.temp)
                    print(temp)
                    self.tempLbl.text = temp
                    let WeatherSun = weatherData.sys
                    print("Current sun value:")
                    print(weatherData.dt)
                    print("Sunrise value:")
                    print(WeatherSun.sunrise)
                    print("Sunset value:")
                    print(WeatherSun.sunset)
                    let weatherS = weatherData.weather
                    print("Weather:")
                    let imgPicker = weatherS[0].main
                    print(imgPicker)
                    var timeCheck = ""
                    if (weatherData.dt >= WeatherSun.sunrise && weatherData.dt < WeatherSun.sunset){
                        self.dayBackground()
                        timeCheck = "day"
                    } else {
                        self.nightBackground()
                        
                    }
                    if (imgPicker == "Clear" && timeCheck == "day"){
                        self.weatherImg.image = UIImage(named: "sun.png")
                    }
                    else if (imgPicker == "Clouds" && timeCheck == "day"){
                        
                        self.weatherImg.image = UIImage(named: "cloud.png")
                        print("HERRRRRREEE")
                    }
                    else if (imgPicker == "Clear"){
                        self.weatherImg.image = UIImage(named: "moon.png")
                    }
                    else if (imgPicker == "Clouds"){
                        self.weatherImg.image = UIImage(named: "night.png")
                    }
                    else if (imgPicker == "Snow"){
                        self.weatherImg.image = UIImage(named: "snow.png")
                    }
                    else if (imgPicker == "Rain" || imgPicker == "Drizzle"){
                        self.weatherImg.image = UIImage(named: "rain.png")
                    }
                    else if (imgPicker == "Thunderstorm"){
                        self.weatherImg.image = UIImage(named: "storm.png")
                    }
                    else {
                        self.weatherImg.image = UIImage(named: "tornado.png")
                    }
                    
                    
                    print("Description:")
                    print(weatherS[0].description)
                    self.weatherDescLbl.text = weatherS[0].description
                    print("Hour:")
                    let currentDateTime = Date()
                // get the user's calendar
                    let userCalendar = Calendar.current
                // choose which date and time components are needed
                    let requestedComponents: Set<Calendar.Component> = [.hour, .weekday]
                // get the components
                    let dateTimeComponents = userCalendar.dateComponents(requestedComponents, from: currentDateTime)
                // now the components are available
                    print(dateTimeComponents.hour!)
                    let day = dateTimeComponents.weekday
                    if (day == 1){
                        self.dotw.text = "Sunday"
                    }
                    else if (day == 2){
                        self.dotw.text = "Monday"
                    }
                    else if (day == 3){
                        self.dotw.text = "Tuesday"
                    }
                    else if (day == 4){
                        self.dotw.text = "Wednesday"
                    }
                    else if (day == 5){
                        self.dotw.text = "Thursday"
                    }
                    else if (day == 6){
                        self.dotw.text = "Friday"
                    }
                    else if (day == 7){
                        self.dotw.text = "Saturday"
                    }
                    
                   
                }
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
    func calculateCelsius(fahrenheit: Double) -> String {
        var celsius: String
        let myDouble = (fahrenheit - 32) * 5 / 9
        celsius = String(format: "%.2f", myDouble)
        return celsius
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
