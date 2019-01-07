import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet weak var cityTable: UITableView!
    var cm:CityModel = CityModel()
    override func viewDidLoad()
    {
        super.viewDidLoad()
        cityTable.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cm.fetchRecord();
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for:indexPath) as! CityTableViewCell
        cell.layer.borderWidth = 1.0
        let rowdata = cm.getCityObject(row: indexPath.row)
        cell.cellName.text = rowdata.cityName
        if(rowdata.cityImage != nil)
        {
            cell.cellImage.image = UIImage(data:rowdata.cityImage as! Data, scale:1.0)
        }
        else
        {
            cell.cellImage.image = nil
        }
        return cell
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexpath: IndexPath) -> UITableViewCell.EditingStyle
    {
        return UITableViewCell.EditingStyle.delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            cm.removeCity(row:indexPath.row)
            cityTable.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100.0;
    }
    @IBAction func addCity(_ sender: Any)
    {
        let alertController = UIAlertController(title: "Add New City", message: "", preferredStyle: UIAlertController.Style.alert)
        alertController.addTextField { (textField: UITextField!) -> Void in
            textField.placeholder = "Enter City Name"
        }
        alertController.addTextField { (textField: UITextField!) -> Void in
            textField.placeholder = "Enter A Description"
        }
        let addAction = UIAlertAction(title: "Add", style: UIAlertAction.Style.default, handler: {alert-> Void in
            let first = alertController.textFields![0].text!
            let second = alertController.textFields![1].text!
            if first.isEmpty || second.isEmpty
            {
                let alert2Controller = UIAlertController(title: "Add City Failed", message: "One or more text fields were empty", preferredStyle:UIAlertController.Style.alert)
                let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
                alert2Controller.addAction(okAction)
                self.present(alert2Controller, animated:true, completion:nil)
            }
            else
            {
                self.cm.addCity(name:first, description:second)
                self.cityTable.reloadData()
            }
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: {(action: UIAlertAction!) -> Void in })
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated:true, completion:nil)
        cityTable.reloadData()
    }
    @IBAction func deleteAll(_ sender: Any)
    {
        cm.deleteAll()
        cityTable.reloadData()
    }
    @IBAction func unwind(segue: UIStoryboardSegue)
    {
        cityTable.reloadData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let selectedIndex:IndexPath = self.cityTable.indexPath(for:sender as! UITableViewCell)!
        if (segue.identifier == "cityView")
        {
            if let viewController: CityViewController = segue.destination as? CityViewController
            {
                let x = cm.getCityObject(row:selectedIndex.row)
                viewController.tempRow = selectedIndex.row
                viewController.y = x
                //print(selectedIndex.row)
                viewController.tempName = x.cityName
                viewController.tempDescription = x.cityDescription
                if(x.cityImage != nil)
                {
                    viewController.tempImage = UIImage(data:x.cityImage as! Data,scale:1.0)
                }
            }
        }
        cityTable.reloadData()
    }
}

