//
//  SurveyListTableViewController.swift
//  Survey2
//
//  Created by Laura O'Brien on 10/5/17.
//  Copyright © 2017 Laura O'Brien. All rights reserved.
//

import UIKit

class SurveyListTableViewController: UITableViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        SurveyController.shared.fetchEmoji {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return SurveyController.shared.surveys.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "surveyCell", for: indexPath)

        let survey = SurveyController.shared.surveys[indexPath.row]
        
        cell.textLabel?.text = survey.name
        cell.detailTextLabel?.text = survey.emoji
        
        return cell
    }
}
