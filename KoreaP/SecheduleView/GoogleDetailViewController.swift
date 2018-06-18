

import UIKit
import GoogleMaps
import GooglePlaces
import Alamofire

class GoogleDetailViewController: UIViewController ,CLLocationManagerDelegate, GMSMapViewDelegate, GMSAutocompleteViewControllerDelegate,UITableViewDataSource,UITableViewDelegate{
    @IBOutlet var tableView: UITableView!
    let sid = mysechedulearr[myindex]["sid"] as! Int
    @IBOutlet var saveBtn: UIButton!
    @IBOutlet var resetBtn: UIButton!
    @IBOutlet var listBlurView: UIVisualEffectView!
    @IBOutlet var listView: UIView!
    @IBOutlet var listViewConstraint: NSLayoutConstraint!
    @IBOutlet var googleMapView: GMSMapView!
    @IBOutlet var startTextField: UITextField!
    @IBOutlet var endTextField: UITextField!
    @IBOutlet var dateView: UIView!
    let datePicker = UIDatePicker()
    let endDatePicker = UIDatePicker()
    var sechdulearr = [sechedule]()
    @IBOutlet var addbtn: UIButton!
    @IBOutlet var listbtn: UIButton!
    @IBOutlet var dateViewConstraint: NSLayoutConstraint!
    var locationManager = CLLocationManager()
    var latitude:Double = 0.0
    var longitude:Double = 0.0
    var locationName:String = ""
    var count:Int = 0
    var locationNamearr : Array<String> = Array<String>()
    var se = [AnyObject]()
    var startDatearr :  Array<String> = Array<String>()
    var endDatearr :  Array<String> = Array<String>()
    let path = GMSMutablePath()
    let add : UIImage = UIImage(named:"add")!
    let list : UIImage = UIImage(named:"list")!
    var marker = GMSMarker()
    var rectangle = GMSPolyline()
    var polylinearr = [GMSPolyline]()
    var markerarr = [GMSMarker]()
    
    var uid = UserDefaults.standard.integer(forKey: "uid")
    let token =   UserDefaults.standard.object(forKey: "object" as String)
    override func viewDidLoad() {
        super.viewDidLoad()
    
        dateViewConstraint.constant = -130
        listViewConstraint.constant = -140
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
        
        createDate()
        addbtn.setImage(add, for: UIControlState.normal)
        listbtn.setImage(list, for: UIControlState.normal)
        listbtn.layer.cornerRadius = 30
        dateView.layer.cornerRadius = 20
        listBlurView.layer.cornerRadius = 30
        initGoogleMaps()
        detailRest()
        
        
        
        // Do any additional setup after loading the view.
    }
    func initGoogleMaps() {
        let camera = GMSCameraPosition.camera(withLatitude: 37.597319, longitude: 127.057843, zoom: 15.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        self.googleMapView.camera = camera
        
        
        self.googleMapView.delegate = self
        self.googleMapView.isMyLocationEnabled = true
        self.googleMapView.settings.myLocationButton = true
        // Creates a marker in the center of the map.
        let marker = GMSMarker()


        
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("\(error)")
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        
        let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!, zoom: 17.0)
        self.googleMapView.animate(to: camera)
        self.locationManager.stopUpdatingLocation()
    }
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        self.googleMapView.isMyLocationEnabled = true
    }
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        self.googleMapView.isMyLocationEnabled = true
        if (gesture) {
            mapView.selectedMarker = nil
        }
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        let camera = GMSCameraPosition.camera(withLatitude: place.coordinate.latitude, longitude: place.coordinate.longitude, zoom: 17.0)
        self.latitude = place.coordinate.latitude
        self.longitude = place.coordinate.longitude
        self.locationName = place.name
        self.googleMapView.camera = camera
        self.dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("\(error)")
    }
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func openSearchAddress(_ sender: UIBarButtonItem) {
        let autoCompleteController = GMSAutocompleteViewController()
        autoCompleteController.delegate = self
        self.locationManager.stopUpdatingLocation()
        self.present(autoCompleteController, animated: true, completion: nil)
        
    }
    @IBAction func addButton(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2, animations: {
            self.dateViewConstraint.constant = 0
            self.view.layoutIfNeeded()
            
        })
        
        let position = CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
        let marker = GMSMarker(position: position)
        marker.map = googleMapView
        markerarr.append(marker)
        path.add(CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude))
        let rectangle = GMSPolyline(path: path)
        rectangle.map = googleMapView
        locationNamearr.append(self.locationName)
        polylinearr.append(rectangle)
        print(locationNamearr)
        
    }
    
    @IBAction func dateAdd(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2, animations: {
            self.dateViewConstraint.constant = -130
            self.view.layoutIfNeeded()
            
        })
        startDatearr.append(self.startTextField.text!)
        endDatearr.append(self.endTextField.text!)
        sechdulearr.append(sechedule(name: locationName,startDate: startTextField.text!,endDate: endTextField.text!,latitude: self.latitude,longitude: self.longitude))
        se.append(sechedule(name: locationName,startDate: startTextField.text!,endDate: endTextField.text!,latitude:self.latitude,longitude:self.longitude))
        
        print(se)
        count += 1
        self.tableView.reloadData()
    }
    @IBAction func viewList(_ sender: UIButton) {
        if listViewConstraint.constant < 0{
            UIView.animate(withDuration: 0.2, animations: {
                self.listViewConstraint.constant = 0
                self.view.layoutIfNeeded()
                
            })
        }else{
            UIView.animate(withDuration: 0.2, animations: {
                self.listViewConstraint.constant = -140
                self.view.layoutIfNeeded()
                
            })
        }
    }
    func createDate(){
        
        //datePicke 포멧
        datePicker.datePickerMode = .date
        endDatePicker.datePickerMode = .date
        
        // 하단툴바
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // 툴바 버튼아이템
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: false)
        
        startTextField.inputAccessoryView = toolbar
        endTextField.inputAccessoryView = toolbar
        
        // textField 에 선택한 날짜 보여주기
        endTextField.inputView = endDatePicker
        startTextField.inputView = datePicker
        
    }
    //날짜입력 확인이벤트
    @objc func donePressed() {
        
        // format date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        count += 1
        startTextField.text = dateFormatter.string(from: datePicker.date)
        endTextField.text = dateFormatter.string(from: endDatePicker.date)
        //        sechdulearr[count].endDate = endTextField.text!
        //        sechdulearr[count].startDate = startTextField.text!
        //        count += 1
        
        self.view.endEditing(true)
    }
    class sechedule{
        let city:String
        var startdate:String
        var enddate:String
        let latitude:Double
        let longitude:Double
        
        init(name: String,startDate: String,endDate: String,latitude: Double,longitude: Double){
            self.city = name
            self.startdate = startDate
            self.enddate = endDate
            self.latitude = latitude
            self.longitude = longitude
          
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sechdulearr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "sechduleCell") as? SecheduleTableViewCell else {
            return UITableViewCell()
        }
        cell.locationNamelbl.text = sechdulearr[indexPath.row].city as String?
        cell.stdLbl.text = sechdulearr[indexPath.row].startdate as String?
        cell.endLbl.text = sechdulearr[indexPath.row].enddate as String?
        
        
//        var dlong = se[indexPath.row]["longitude"] as? Double
//        var dlat = se[indexPath.row]["latitude"] as? Double
        
        
        //        cell.locationNamelbl.text = locationNamearr[indexPath.row] as String
        //        cell.locationNamelbl.text = sechdulearr[indexPath.row]["name"] as String
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
        
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let add = UITableViewRowAction(style: .destructive, title: "삭제", handler: { action , indexPath in
            let position = CLLocationCoordinate2D(latitude: self.sechdulearr[indexPath.row - 1].latitude as Double, longitude: self.sechdulearr[indexPath.row - 1].longitude as Double)
            self.markerarr[indexPath.row].map = nil
            self.markerarr.remove(at: indexPath.row)
            self.polylinearr[indexPath.row].map = nil
            self.path.removeCoordinate(at: UInt(indexPath.row))
            self.path.replaceCoordinate(at: UInt(indexPath.row+1), with: position)
            self.polylinearr.remove(at: indexPath.row)
            
            //
            //            let dmarker = GMSMarker(position: position)
            //            self.path.removeAllCoordinates()
            //            dmarker.map = nil
            //            self.googleMapView.reloadInputViews()
            //
            //            self.googleMapView.clear()
            self.sechdulearr.remove(at: indexPath.row)
            tableView.reloadData()
        })
        return [add]
    }
    func detailRest(){
        let headersVal = [
            "Authorization": (token as! String),
            ]
        Alamofire.request("http://13.125.66.99:8080/koreaplaner/api/schedules/\(sid)/detail", headers: headersVal).responseJSON { response in
            let result = response.result
            if let dict = result.value as? Dictionary<String,AnyObject>{
                if let innerDict = dict["data"]{
                    if let secondinnerDict = innerDict["detailScheduleDtos"]
                    {
                        print(innerDict)
                        self.se = secondinnerDict as! [AnyObject]
                    }
                }
            }
            
            for i in 0 ..< self.se.count{
                let long = self.se[i]["longitude"] as! Double
                let lat = self.se[i]["latitude"] as! Double
                let na = self.se[i]["city"] as! String
                let st = self.se[i]["startdate"] as! String
                let ed = self.se[i]["enddate"] as! String
                let position = CLLocationCoordinate2D(latitude: lat, longitude: long)
                let marker = GMSMarker(position: position)
                marker.map = self.googleMapView
                self.markerarr.append(marker)
                self.path.add(CLLocationCoordinate2D(latitude: lat, longitude: long))
                let rectangle = GMSPolyline(path: self.path)
                rectangle.map = self.googleMapView
                self.polylinearr.append(rectangle)

                self.sechdulearr.append(sechedule(name: na, startDate: st, endDate: ed, latitude: lat, longitude: long))
                self.tableView.reloadData()
            }
            print(self.sechdulearr[0].city)
        }
    }
    @IBAction func save(_ sender: UIButton) {
        let cityDictionary = sechdulearr.map({["city": $0.city,
                                               "enddate": $0.enddate,
                                               "sequence": 0,
                                               "startdate": $0.startdate,
                                               "traffic": "1",
                                               "latitude": $0.latitude,
                                               "longitude": $0.longitude,]})
        let params: [String: Any] = [
            "list" : cityDictionary
        ]
        print(params)
        let token =   UserDefaults.standard.object(forKey: "object" as String)
        let headersVal = [
            "Authorization": (token as! String),
            ]
        let url = URL(string: "http://13.125.66.99:8080/koreaplaner/api/schedules/schedule/\(sid)/detail")!
        Alamofire.request(url, method: .put, parameters: params as? [String : AnyObject],encoding: JSONEncoding.default, headers: headersVal)
            
            .responseJSON { response in
                
                if let authorization = response.response?.allHeaderFields["Authorization"] as? String {
                    
                    let newToken : String = authorization
                    UserDefaults.standard.set(newToken, forKey: "object")
                    UserDefaults.standard.synchronize()
                }
                switch response.result {
                case .success:
                    print("SUCCES with \(response)")
                case .failure(let error):
                    print("ERROR with '\(error)")
                }
        }
        let storyboard: UIStoryboard = self.storyboard!
        let nextView = storyboard.instantiateViewController(withIdentifier: "mainNavView")
        self.present(nextView, animated: true, completion: nil)
    }
}

    


