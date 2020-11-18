//
//  ContentView.swift
//  WeSplit
//
//  Created by Enrique Florencio on 11/12/20.
//

import SwiftUI

struct ContentView: View {
    // MARK: Private variables
    @State private var checkAmount = ""
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 2
    // MARK: Private Constants
    private let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        ///Calculates the total per person
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    ///This body property is reinvoked every time a variable gets changed due to the "State" property. Not sure if this is something that is very expensive
    var body: some View {
        NavigationView {
            Form {
                Section {
                    ///The textfield that prompts a user to enter the amount that they owe the restaurant
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2 ..< 100) { number in
                            Text("\(number) people")
                        }
                    }
                }
                
                Section(header: Text("How much would you like to tip?")) {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) { number in
                            Text("\(tipPercentages[number])%")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Amount Per Person")) {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
            }.navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
