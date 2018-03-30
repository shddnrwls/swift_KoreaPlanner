//
//  DetailGoogleMapViewController.swift
//  KoreaP
//
//  Created by mac on 2018. 3. 23..
//  Copyright © 2018년 swift. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import Alamofire

class DetailGoogleMapViewController: UIViewController ,CLLocationManagerDelegate, GMSMapViewDelegate, GMSAutocompleteViewControllerDelegate,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet var dateView: UIView!
    @IBOutlet var googleMapView: GMSMapView!
    @IBOutlet var addBtn: UIButton!
    @IBOutlet var dateViewConstraint: NSLayoutConstraint!
    @IBOutlet var listViewConstraint: NSLayoutConstraint!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var listView: UIView!
    @IBOutlet var blurView: UIVisualEffectView!
    @IBOutlet var listBtn: UIButton!
    @IBOutlet var startText: UITextField!
    @IBOutlet var endText: UITextField!
    @IBOutlet var resetButton: UIButton!
    let datePicker = UIDatePicker()
    let endDatePicker = UIDatePicker()
    let path = GMSMutablePath()
    var latitude:Double = 0.0
    var longitude:Double = 0.0
    var locationName:String = ""
    var count:Int = 0
    
    var locationNamearr : Array<String> = Array<String>()
    var locationManager = CLLocationManager()
    override func viewDidLoad() {
        
        super.viewDidLoad()
        dateViewConstraint.constant = -130
        listViewConstraint.constant = -140
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
        initGoogleMaps()
        createDate()

        // Do any additional setup after loading the view.
    }
    func initGoogleMaps() {
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        self.googleMapView.camera = camera
        
        
        self.googleMapView.delegate = self
        self.googleMapView.isMyLocationEnabled = true
        self.googleMapView.settings.myLocationButton = true
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.icon = UIImage(named: "marker")
        marker.map = mapView
        
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
    @IBAction func resetAction(_ sender: Any) {
    }
    @IBAction func listAction(_ sender: UIButton) {
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
    @IBAction func AddAction(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2, animations: {
            self.dateViewConstraint.constant = 0
            self.view.layoutIfNeeded()
            
        })
        
        let position = CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
        let marker = GMSMarker(position: position)
        marker.map = googleMapView
        path.add(CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude))
        let rectangle = GMSPolyline(path: path)
        rectangle.map = googleMapView
        
        
    }
    
       
    @IBAction func dateDoneAction(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2, animations: {
            self.dateViewConstraint.constant = -130
            self.view.layoutIfNeeded()
            
        })
        
        sechdulearr.append(sechedule(name: locationName,startDate: startText.text!,endDate: endText.text!,latitude: self.latitude,longitude: self.longitude,count: self.count))
        count += 1
        self.tableView.reloadData()
        }
    }
    class sechedule{
        let name:String
        var startDate:String
        var endDate:String
        let latitude:Double
        let longitude:Double
        let count:Int
        init(name: String,startDate: String,endDate: String,latitude: Double,longitude: Double,count: Int){
            self.name = name
            self.startDate = startDate
            self.endDate = endDate
            self.latitude = latitude
            self.longitude = longitude
            self.count = count
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return l
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "sechduleCell") as? SecheduleTableViewCell else {
            return UITableViewCell()
        }
        cell.locationNamelbl.text = seche[indexPath.row].name as String!
        
        //        cell.locationNamelbl.text = locationNamearr[indexPath.row] as String
        //        cell.locationNamelbl.text = sechdulearr[indexPath.row]["name"] as String
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
        
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let add = UITableViewRowAction(style: .destructive, title: "Add", handler: { action , indexPath in
            self.sechdulearr.remove(at: indexPath.row)
            tableView.reloadData()
        })
        return [add]
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
        
        startText.inputAccessoryView = toolbar
        endText.inputAccessoryView = toolbar
        
        // textField 에 선택한 날짜 보여주기
        endText.inputView = endDatePicker
        startText.inputView = datePicker
        
    }
    //날짜입력 확인이벤트
    @objc func donePressed() {
        
        // format date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        count += 1
        startText.text = dateFormatter.string(from: datePicker.date)
        endText.text = dateFormatter.string(from: endDatePicker.date)
        //        sechdulearr[count].endDate = endTextField.text!
        //        sechdulearr[count].startDate = startTextField.text!
        //        count += 1
        
        self.view.endEditing(true)
    }


