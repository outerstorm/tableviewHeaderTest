//
//  ViewController.swift
//  tableviewHeaderTest
//
//  Created by Justin Storm on 5/12/17.
//  Copyright © 2017 McKesson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var data = ["Row 1", "Row 2", "Row 3", "Row 4", "Row 5"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.

        tableView.sectionHeaderHeight = UITableViewAutomaticDimension
        tableView.estimatedSectionHeaderHeight = 30.0
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 75.0
        
        tableView.register(UINib(nibName: "CustomHeaderView", bundle: Bundle.main), forHeaderFooterViewReuseIdentifier: "CustomHeaderView")
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.3) {
            //self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CustomHeaderView") as! CustomHeaderView
        view.setup()
        return view
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell
    
        let randomNum = Int(arc4random_uniform(4)) + 1
        let text = String(repeating: "This is some text for the cell itself to see what happens.", count: randomNum)
        cell.label.text = text
        
        return cell
    }
}


class CustomCell: UITableViewCell {
    @IBOutlet var label: UILabel!
}

class CustomHeaderView: UITableViewHeaderFooterView {
    
    @IBOutlet weak var mainLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        mainLabel.text = nil
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        
        mainLabel.text = nil
    }
    
    func setup() {
        let randomNum = Int(arc4random_uniform(4)) + 1
        
        let text = String(repeating: "This is where the really long text goes so that it will wrap lines appropriately", count: randomNum)
        
        mainLabel.text = text
    }
}
