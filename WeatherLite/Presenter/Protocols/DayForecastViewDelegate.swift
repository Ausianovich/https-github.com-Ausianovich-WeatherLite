//
//  DayForecatsViewDelegate.swift
//  WeatherLite
//
//  Created by Ausianovich Kanstantsin on 01.03.2021.
//

import Foundation

protocol DayForecastViewDelegate: class {
    func updateDayForecastViewController(with: DayWeatherDTO)
    func show(_ error: Error)
}
