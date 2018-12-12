//
//  Player.swift
//  InClassExercisesStarter
//
//  Created by Joao Rebelo on 2018-12-04.
//  Copyright © 2018 room1. All rights reserved.
//

import Foundation

class Player{
    private var player_id : String?
    private var player_name : String?
    private var player_email : String?
    private var player_pokemon : Pokemon?
    private var player_money : Int?
    
    var Player_id : String?{
        get{
            return self.player_id
        }
        set{
            self.player_id = newValue
        }
    }
    
    var Player_name : String?{
        get{
            return self.player_name
        }
        set{
            self.player_name = newValue
        }
    }
    
    var Player_email : String?{
        get{
            return self.player_email
        }
        set{
            self.player_email = newValue
        }
    }
    
    var Player_pokemon : Pokemon?{
        get{
            return self.player_pokemon
        }
        set{
            self.player_pokemon = newValue
        }
    }
    
    var Player_money : Int?{
        get{
            return self.player_money
        }
        set{
            self.player_money = newValue
        }
    }
    init() {
        self.player_id = "test"
        self.player_name = "test"
        self.player_email = "test@test.com"
        self.player_pokemon = Pokemon()
        self.player_money = 50
    }
    init(player_id : String, player_name : String, player_email : String, player_pokemon : Pokemon, player_money : Int) {
        self.player_id = player_id
        self.player_name = player_name
        self.player_email = player_email
        self.player_pokemon = player_pokemon
        self.player_money = player_money
    }
}
