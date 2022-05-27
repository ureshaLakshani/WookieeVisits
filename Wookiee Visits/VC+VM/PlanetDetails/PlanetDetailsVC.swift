//
//  PlanetDetailsVC.swift
//  Wookiee Visits
//
//  Created by Uresha Lakshani on 2022-05-26.
//

import UIKit
import SDWebImage

class PlanetDetailsVC: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var planetIV: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var orbitalLbl: UILabel!
    @IBOutlet weak var gravityLbl: UILabel!
    
    //MARK: - Variables
    let vm = PlanetDetailsVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setItemField()
    }
    
    // set field property
     func setItemField() {
         //set navigation Bar title
         self.title = "Planet Deatails"
        //set labels names
         nameLbl.text = vm.planet?.name
         orbitalLbl.text = "Orbital Period : \(vm.planet?.orbitalPeriod ?? "N/A") "
         gravityLbl.text = "Gravity : \(vm.planet?.gravity ?? "N/A")"
         //set image
         planetIV.sd_setImage(with: URL(string: "https://picsum.photos/id/\(vm.imageID ?? 0)/200/300"), placeholderImage: UIImage(named: "placeholder.png"))

    }


}
