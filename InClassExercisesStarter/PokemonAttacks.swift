//
//  PokemonAttacks.swift
//  InClassExercisesStarter
//
//  Created by Joao Rebelo on 2018-12-04.
//  Copyright © 2018 room1. All rights reserved.
//

import Foundation

class PokemonAttacks{
    private var attackName : String?
    private var attackDamage : Int?
    
    var AttackName : String?{
        get{
            return self.attackName
        }
        set{
            self.attackName = newValue
        }
    }
    
    var AttackDamage : Int?{
        get{
            return self.attackDamage
        }
        set{
            self.attackDamage = newValue
        }
    }
    
    init() {
        self.attackName = "attackName"
        self.attackDamage = 20
    }
    
    init(attackName : String, attackDamage : Int) {
        self.attackName = attackName
        self.attackDamage = attackDamage
    }
}
