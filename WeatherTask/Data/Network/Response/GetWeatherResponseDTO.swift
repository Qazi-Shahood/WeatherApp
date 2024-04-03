//
//  GetWeatherResponseDTO.swift
//  WeatherTask
//
//  Created by qms on 22/03/2024.
//

import Foundation

struct GetWeatherResponseDTO: DTO {
    let weather: [GetWeatherDetailResponseDTO]
    let main: GetWeatherMainResponseDTO
    let name: String
}

struct GetWeatherDetailResponseDTO: DTO {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct GetWeatherMainResponseDTO: DTO {
    let temp: Float
}
