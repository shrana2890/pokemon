//
//  Pokemon.swift
//  InClassExercisesStarter
//
//  Created by Joao Rebelo on 2018-12-04.
//  Copyright © 2018 room1. All rights reserved.
//

import Foundation

class Pokemon{
    private var pokemon_id : String?
    private var pokemon_name : String?
    private var pokemon_attack : Int?
    private var pokemon_defence : Int?
    private var pokemon_hp : Int?
    private var pokemon_current_hp : Int?
    private var pokemon_exp : Int?
    private var pokemon_level : Int?
    private var pokemon_image : String?
    private var pokemon_attacks : [PokemonAttacks]?
    
    var Pokemon_id : String?{
        get{
            return self.pokemon_id
        }
        set{
            self.pokemon_id = newValue
        }
    }
    
    var Pokemon_name : String?{
        get{
            return self.pokemon_name
        }
        set{
            self.pokemon_name = newValue
        }
    }
    
    var Pokemon_attack : Int?{
        get{
            return self.pokemon_attack
        }
        set{
            self.pokemon_attack = newValue
        }
    }
    
    var Pokemon_defence : Int?{
        get{
            return self.pokemon_defence
        }
        set{
            self.pokemon_defence = newValue
        }
    }
    
    var Pokemon_hp : Int?{
        get{
            return self.pokemon_hp
        }
        set{
            self.pokemon_hp = newValue
        }
    }
    
    var Pokemon_current_hp : Int?{
        get{
            return self.pokemon_current_hp
        }
        set{
            self.pokemon_current_hp = newValue
        }
    }
    
    var Pokemon_exp : Int?{
        get{
            return self.pokemon_exp
        }
        set{
            self.pokemon_exp = newValue
        }
    }
    
    var Pokemon_level : Int?{
        get{
            return self.pokemon_level
        }
        set{
            self.pokemon_level = newValue
        }
    }
    
    var Pokemon_attacks: [PokemonAttacks]?{
        get{
            return self.pokemon_attacks
        }
        set{
            self.pokemon_attacks = newValue
        }
    }
    
    var Pokemon_image: String?{
        get{
            return self.pokemon_image
        }
        set{
            self.pokemon_image = newValue
        }
    }
    
    init() {
        self.pokemon_id = "1"
        self.pokemon_name = "pokemon_name"
        self.pokemon_attack = 20
        self.pokemon_defence = 20
        self.pokemon_hp = 20
        self.pokemon_current_hp = 20
        self.pokemon_level = 1
        self.pokemon_exp = 20
        self.pokemon_image = "newPokemon"
        
        let p1 = PokemonAttacks()
        var pArray : [PokemonAttacks] = []
        pArray.append(p1)
        self.pokemon_attacks = pArray
    }
    
    init(pokemon_id : String, pokemon_name : String, pokemon_attack : Int, pokemon_defence : Int, pokemon_hp : Int, pokemon_exp : Int, pokemon_attacks : [PokemonAttacks]?) {
        self.pokemon_id = pokemon_id
        self.pokemon_name = pokemon_name
        self.pokemon_attack = pokemon_attack
        self.pokemon_defence = pokemon_defence
        self.pokemon_hp = pokemon_hp
        self.pokemon_current_hp = pokemon_hp
        self.pokemon_level = 1
        self.pokemon_exp = pokemon_exp
        self.pokemon_attacks = pokemon_attacks
    }
    
    init(pokemon_id : String, pokemon_name : String, pokemon_attack : Int, pokemon_defence : Int, pokemon_hp : Int, pokemon_current_hp : Int, pokemon_level : Int, pokemon_exp : Int, pokemon_image : String, pokemon_attacks : [PokemonAttacks]?) {
        self.pokemon_id = pokemon_id
        self.pokemon_name = pokemon_name
        self.pokemon_attack = pokemon_attack
        self.pokemon_defence = pokemon_defence
        self.pokemon_hp = pokemon_hp
        self.pokemon_current_hp = pokemon_current_hp
        self.pokemon_level = pokemon_level
        self.pokemon_exp = pokemon_exp
        self.pokemon_image = pokemon_image
        self.pokemon_attacks = pokemon_attacks
    }
 
}
