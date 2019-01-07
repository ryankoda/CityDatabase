import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet weak var cityTable: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
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
}

