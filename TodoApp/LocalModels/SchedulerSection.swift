//
//  SchedulerSection.swift
//  TodoApp
//
//  Created by ALEMDAR on 31.08.2021.
//

import Foundation
import RxDataSources

struct SchedulerSection {
    var header: String
    var items: [Item]
}

extension SchedulerSection: SectionModelType {
    
    typealias Item = Task
    
    init(original: SchedulerSection, items: [Task]) {
        self = original
        self.items = items
    }
    
}
