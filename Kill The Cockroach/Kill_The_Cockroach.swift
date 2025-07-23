//
//  Kill_The_Cockroach.swift
//  Kill The Cockroach
//
//  Created by Lilit Avdalyan on 23.07.25.
//

import AppIntents

struct Kill_The_Cockroach: AppIntent {
    static var title: LocalizedStringResource { "Kill The Cockroach" }
    
    func perform() async throws -> some IntentResult {
        return .result()
    }
}
