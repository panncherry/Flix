//
//  Genre.swift
//  Flix
//
//  Created by Pann Cherry on 4/8/22.
//  Copyright © 2022 Pann Cherry. All rights reserved.
//

struct Genre {
    var id: Int
    var type: GenreType?

    init(id: Int) {
        self.id = id
        self.type = GenreType(rawValue: id)
    }
}


enum GenreType: Int {
    case all = 0
    case adventure = 12
    case animation = 16
    case action = 28
    case comedy = 35
    case crime = 80
    case documentary = 99
    case drama = 18
    case family = 10751
    case fantasy = 14
    case history = 36
    case horror = 27
    case music = 10402
    case mystery = 9648
    case romance = 10749
    case scienceFiction = 878
    case tvMovie = 10770
    case thriller = 53
    case war = 10752
    case western = 37

    init?(rawValue: Int) {
        switch (rawValue) {
        case 0:
            self = .all
            
        case 12:
            self = .adventure

        case 16:
            self = .animation

        case 28:
            self = .action

        case 35:
            self = .comedy

        case 80:
            self = .crime

        case 10751:
            self = .family

        case 14:
            self = .fantasy

        case 36:
            self = .history

        case 27:
            self = .horror

        case 10402:
            self = .music

        case 9648:
            self = .mystery

        case 10749:
            self = .romance

        case 878:
            self = .scienceFiction

        case 10770:
            self = .tvMovie

        case 53:
            self = .thriller

        case 10752:
            self = .war

        case 37:
            self = .western

        default:
            return nil
        }
    }
}
