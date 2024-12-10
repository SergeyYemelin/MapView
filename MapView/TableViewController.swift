//
//  TableViewController.swift
//  MapView
//
//  Created by Сергей Емелин on 03.12.2024.
//

import UIKit

class TableViewController: UITableViewController {
    
    var arrayHotel = [Hotel(name: "Hilton Garden Inn Cupertino", adress: "10741 North Wolfe Road, Cupertino, CA 95014", image: "hiltongarden", latitude: 37.33340349690932, longitude: -122.01475017966338), Hotel(name: "The Grand Hotel", adress: "865 W El Camino Real, Sunnyvale, CA 94087", image: "grandhotel", latitude: 37.370928829430085, longitude: -122.04286686915754), Hotel(name: "Wild Palms Hotel - JDV by Hyatt", adress: "910 E Fremont Ave, Sunnyvale, CA 94087", image: "wildpalms", latitude: 37.351829068811426, longitude: -122.01359402862693) ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrayHotel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let label = cell.viewWithTag(1002) as! UILabel
        label.text = arrayHotel[indexPath.row].name
        
        let imageView = cell.viewWithTag(1001) as! UIImageView
        imageView.image = UIImage(named: arrayHotel[indexPath.row].image)

        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as!
        DetailViewController
        
        vc.hotel = arrayHotel[indexPath.row]
        
        navigationController?.show(vc, sender: self)
    }
    
    
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
