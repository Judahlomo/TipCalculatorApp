//
//  ContentView.swift
//  TipCalculatorApp
//
//  Created by Judah Lomo on 1/31/25.
//

import SwiftUI

struct ContentView: View {
    @State private var billAmount: Double = 0.0
    @State private var tipPercentage: Double = 15.0
    @State private var numberOfPeople: Double = 1.0
    @State private var showResults: Bool = false
    @State private var selectedCurrency: String = "USD"

    let currencies = ["USD", "EUR", "GBP", "JPY", "CAD"]

    private var tipAmount: Double {
        billAmount * (tipPercentage / 100)
    }

    private var totalAmount: Double {
        billAmount + tipAmount
    }

    private var amountPerPerson: Double {
        totalAmount / numberOfPeople
    }

    var body: some View {
        VStack(spacing: 20) {
            Text("Tip Calculator")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.orange)
                .padding()

            VStack {
                Text("Select Currency")
                    .foregroundColor(.black)
                Picker("Currency", selection: $selectedCurrency) {
                    ForEach(currencies, id: \.self) { currency in
                        Text(currency).tag(currency)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
            }

            VStack(alignment: .leading) {
                Text("Bill Amount: \(billAmount, format: .currency(code: selectedCurrency))")
                    .foregroundColor(.black)
                Slider(value: $billAmount, in: 0...500, step: 1)
                    .accentColor(.orange)
            }
            .padding()

            VStack(alignment: .leading) {
                Text("Tip Percentage: \(Int(tipPercentage))%")
                    .foregroundColor(.black)
                Slider(value: $tipPercentage, in: 0...30, step: 1)
                    .accentColor(.orange)
            }
            .padding()

            VStack(alignment: .leading) {
                Text("Number of People: \(Int(numberOfPeople))")
                    .foregroundColor(.black)
                Slider(value: $numberOfPeople, in: 1...20, step: 1)
                    .accentColor(.orange)
            }
            .padding()

            if showResults {
                VStack(spacing: 10) {
                    Text("Tip: \(tipAmount, format: .currency(code: selectedCurrency))")
                    Text("Total: \(totalAmount, format: .currency(code: selectedCurrency))")
                    Text("Per Person: \(amountPerPerson, format: .currency(code: selectedCurrency))")
                }
                .padding()
                .background(Color.black)
                .foregroundColor(.orange)
                .cornerRadius(10)
                .shadow(radius: 5)
                .padding()
            }

            Button(action: {
                showResults.toggle()
            }) {
                Text(showResults ? "Hide Results" : "Calculate")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(showResults ? Color.black : Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()

            Spacer()
        }
        .padding()
        .background(Color(.systemGray6).ignoresSafeArea())
    }
}

#Preview {
    ContentView()
}
