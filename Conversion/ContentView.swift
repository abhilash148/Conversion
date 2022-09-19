//
//  ContentView.swift
//  Conversion
//
//  Created by Sai Abhilash Gudavalli on 18/09/22.
//

import SwiftUI

enum ConversionType {
    case temperature
    case length
    case time
    case volume
    case none
}

enum TemperatureUnits: String {
    case celsius = "celsius"
    case fahrenheit = "fahrenheit"
    case kelvin = "kelvin"
}

enum LengthUnits: String {
    case meters = "meters"
    case centimeters = "centimeters"
    case feet = "feet"
    case yards = "yards"
    case miles = "miles"
}

enum TimeUnits: String {
    case seconds = "seconds"
    case minutes = "minutes"
    case hours = "hours"
    case days = "days"
}

enum VolumeUnits: String {
    case milliliters = "milliliters"
    case liters = "liters"
    case cups = "cups"
    case pints = "pints"
    case gallons = "gallons"
}

struct ContentView: View {
    var type: ConversionType {
        switch conversionType {
        case "Temperature":
            return .temperature
        case "Length":
            return .length
        case "Time":
            return .time
        case "Volume":
            return .volume
        default:
            return .none
        }
    }
    @State private var conversionType = "Temperature"
    var conversionUnits: [String] = ["Temperature", "Length", "Time", "Volume"]
    
    var fromUnits: [String] {
        switch type {
        case .temperature:
            return [TemperatureUnits.celsius.rawValue, TemperatureUnits.fahrenheit.rawValue, TemperatureUnits.kelvin.rawValue]
        case .length:
            return [LengthUnits.meters.rawValue,
                    LengthUnits.centimeters.rawValue,
                    LengthUnits.feet.rawValue,
                    LengthUnits.miles.rawValue,
                    LengthUnits.yards.rawValue]
        case .time:
            return [TimeUnits.days.rawValue,
                    TimeUnits.hours.rawValue,
                    TimeUnits.minutes.rawValue,
                    TimeUnits.seconds.rawValue]
        case .volume:
            return [VolumeUnits.cups.rawValue,
                    VolumeUnits.gallons.rawValue,
                    VolumeUnits.liters.rawValue,
                    VolumeUnits.milliliters.rawValue,
                    VolumeUnits.pints.rawValue]
        default:
            return []
        }
    }
    
    @State private var fromUnit: String = ""
    @State private var toUnit: String = ""
    
    @State private var value = ""
    
    var convertedValue: String {
        switch type {
        case .temperature:
            return String(temperatureConvertedValue)
        default:
            return ""
        }
    }
    
    var temperatureConvertedValue: Double {
        let doubleValue = Double(value) ?? 0.0
        var cValue = 0.0
        switch (fromUnit, toUnit) {
        case (TemperatureUnits.celsius.rawValue, TemperatureUnits.fahrenheit.rawValue):
            cValue = ((doubleValue * 9) / 5) + 32
        case (TemperatureUnits.celsius.rawValue, TemperatureUnits.kelvin.rawValue):
            cValue = doubleValue + 273.15
        case (TemperatureUnits.fahrenheit.rawValue, TemperatureUnits.celsius.rawValue):
            cValue = (doubleValue - 32) * (5/9)
        case (TemperatureUnits.fahrenheit.rawValue, TemperatureUnits.kelvin.rawValue):
            cValue = ((doubleValue - 32) * (5/9)) + 273.15
        case (TemperatureUnits.kelvin.rawValue, TemperatureUnits.celsius.rawValue):
            cValue = doubleValue - 273.15
        case (TemperatureUnits.kelvin.rawValue, TemperatureUnits.fahrenheit.rawValue):
            cValue = ((doubleValue - 273.15) * (9/5)) + 32
        default:
            cValue = 0.0
        }
        return cValue
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Unit", selection: $conversionType) {
                        ForEach(conversionUnits, id: \.self) { unit in
                            Text(unit)
                        }
                    }
                    .pickerStyle(.automatic)
                } header: {
                    Text("Select Unit")
                }
                
                Section {
                    Picker("Unit", selection: $fromUnit) {
                        ForEach(fromUnits, id: \.self) { unit in
                            Text(unit)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    TextField("Enter value", text: $value)
                    .keyboardType(.decimalPad)
                } header: {
                    Text("From")
                }
                
                Section {
                    Picker("Unit", selection: $toUnit) {
                        ForEach(fromUnits, id: \.self) { unit in
                            Text(unit)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    Text(convertedValue)
                    
                } header: {
                    Text("To")
                }
                
            }
            .navigationTitle("Conversion")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
