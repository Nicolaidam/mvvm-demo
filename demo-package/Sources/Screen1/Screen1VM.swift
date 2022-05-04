//
//  File.swift
//  
//
//  Created by Nicolai Dam on 04/05/2022.
//

import APIClient
import Foundation
import Model

public class Screen1VM: ObservableObject {
    
    @Published var person: Person?
    @Published var count: Int
    var apiClient: APIClient
    
    public init(apiClient: APIClient, count: Int) {
        self.apiClient = apiClient
        self.count = count
    }
    
    func fetchPerson() {
        #warning("todo lav hent person kald her og lav også eksmpel med en fejl.. Så vi får en alert hvis kaldet fejler")
//        apiClient.fetchCrap().assign(to: &person)
    }
    func navigateToScreen2() {
        #warning("TODO lav navigering til screen2. I screen 2 skal der laves en dismiss knap så man kommer tilbage til AppCore. Evt også med en counter i Screen 3, som skal passe sammen med AppCore counteren")
    }
}
