//
//  Registration_Page.swift
//  sampleErp
//
//  Created by Karthikeyan M on 04/05/24.
//

import Foundation
import UIKit

class RegistrationViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        // Register View UI Configuration
        setup()
        super.viewDidLoad()
    }
    
    func setup(){
        self.hideKeyboardWhenTappedAround()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
}

extension RegistrationViewController : UITableViewDelegate {
    
}

extension RegistrationViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
        let cell = UITableViewCell()
        cell.backgroundColor = .red
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30.0
    }
}
