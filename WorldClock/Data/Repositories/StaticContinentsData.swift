//
//  StaticContinentsData.swift
//  WorldClock
//
//  Created by Nemanja Ignjatovic on 1/21/26.
//

public enum StaticContinentsData {
    public static let continents: [Continent] = [
        .init(name: "America", locations: [
            .init(name: "New York", timezoneId: "America/New_York"),
            .init(name: "São Paulo", timezoneId: "America/Sao_Paulo"),
            .init(name: "Denver", timezoneId: "America/Denver"),
            .init(name: "Buenos Aires", timezoneId: "America/Argentina/Buenos_Aires"),
        ]),
        .init(name: "Europe", locations: [
            .init(name: "London", timezoneId: "Europe/London"),
            .init(name: "Paris", timezoneId: "Europe/Paris"),
            .init(name: "Moscow", timezoneId: "Europe/Moscow"),
            .init(name: "Lisbon", timezoneId: "Europe/Lisbon"),
        ]),
        .init(name: "Asia", locations: [
            .init(name: "Dubai", timezoneId: "Asia/Dubai"),
            .init(name: "Tokyo", timezoneId: "Asia/Tokyo"),
            .init(name: "Seoul", timezoneId: "Asia/Seoul"),
            .init(name: "Singapore", timezoneId: "Asia/Singapore"),
        ]),
        .init(name: "Oceania", locations: [
            .init(name: "Auckland", timezoneId: "Pacific/Auckland"),
        ])
    ]
}
