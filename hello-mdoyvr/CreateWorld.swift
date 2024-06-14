//
//  GreetWpr;d.swift
//  hello-mdoyvr
//
//  Created by Patrick Kelleher on 6/7/24.
//  

import AppIntents

struct World: TransientAppEntity {
    static let typeDisplayRepresentation = TypeDisplayRepresentation(
        name: LocalizedStringResource("World")
    )

    @Property(title: "Name")
    var name: String
    
    @Property(title: "Greeting")
    var greeting: Greeting?
    
    @Property(title: "Climate")
    var climate: String
    
    @Property(title: "Distance")
    var distance: Int
    
    @Property(title: "Gravity")
    var gravity: Double
    
    @Property(title: "Moons")
    var moons: [String]?
    
    @Property(title: "Supports Life")
    var supportsLife: Bool
    
    @Property(title: "Population")
    var population: Int?
    
    var displayRepresentation: DisplayRepresentation {
        .init(
            title: "\(name)",
            subtitle: "\(distance) Light-years",
            image: DisplayRepresentation.Image(systemName: "globe")
        )
    }
}

enum Greeting: String, AppEnum {
    case hello
    case goodMorning
    case goodAfternoon
    case goodEvening
    case goodNight

    static let typeDisplayRepresentation = TypeDisplayRepresentation(name: "Greeting")

    static let caseDisplayRepresentations: [Self: DisplayRepresentation] = [
        .hello: "Hello",
        .goodMorning: "Good Morning",
        .goodAfternoon: "Good Afternoon",
        .goodEvening: "Good Evening",
        .goodNight: "Good Night"
    ]
}

struct CreateWorld: AppIntent {
    static let intentClassName = "Create a World"

    static let title: LocalizedStringResource = "Create World"

    static let description = IntentDescription(
        "Creates a new world.",
        categoryName: "World Building"
    )
    
    @Parameter(
        title: "World Name",
        description: "Name of the world.",
        default: "World"
    )
    var worldName: String
    
    @Parameter(
        title: "Climate",
        description: "Description of the world climate."
    )
    var climate: String
    
    @Parameter(
        title: "Greeting",
        description: "The greeting type.",
        default: Greeting.hello
    )
    var greeting: Greeting?
    
    @Parameter(
        title: "Distance",
        description: "Distance to the world in light-years.",
        controlStyle: .stepper
    )
    var distance: Int
    
    @Parameter(
        title: "Gravity",
        description: "Gravity strength of the world.",
        controlStyle: .slider,
        inclusiveRange: (0, 1)
    )
    var gravity: Double
    
    @Parameter(
        title: "Moons",
        description: "List of moons."
    )
    var moons: [String]?
    
    @Parameter(
        title: "Supports Life",
        description: "If true, the world supports life."
    )
    var supportsLife: Bool
    
    @Parameter(
        title: "Population",
        description: "Population of the world.",
        default: 0
    )
    var population: Int?

    static var parameterSummary: some ParameterSummary {
        When(\.$supportsLife, .equalTo, false) {
            Summary("Create \(\.$worldName)") {
                \.$climate
                \.$distance
                \.$gravity
                \.$moons
                \.$supportsLife
            }
        } otherwise: {
            Summary("Create \(\.$worldName) with life and say \(\.$greeting)") {
                \.$climate
                \.$distance
                \.$gravity
                \.$moons
                \.$supportsLife
                \.$population
            }
        }
    }

    func perform() async throws -> some IntentResult & ReturnsValue<World> {
        var entity = World()
        entity.name = worldName
        entity.climate = climate
        entity.distance = distance
        entity.gravity = gravity
        entity.moons = moons
        entity.supportsLife = supportsLife
        if supportsLife {
            entity.population = population
            entity.greeting = greeting
        }
        
        return .result(value: entity)
    }
}
