//
//  onDutyViewController.swift
//  HelpMeSecurity
//
//  Created by Александр on 20.04.17.
//  Copyright © 2017 Александр. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import FirebaseDatabase

class onDutyViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
  
    @IBAction func slideMenu(_ sender: Any) {
        self.performSegue(withIdentifier: "lkView", sender: self)
    }
    
    var messagesCount = 0
    
    var startTime = TimeInterval()
    
    var timer:Timer = Timer()
    
    var menuVC: slideMenuViewController!
    
    let locationManager = CLLocationManager()
    var userPinView: MKAnnotationView!
    
 
    
    //MARK: dutyHelp
    
    func getDataFirstTime () {
        var ref: FIRDatabaseReference!
        
        ref = FIRDatabase.database().reference()
        
        ref.child("users").observeSingleEvent(of: .value, with: { (snapshot) in
            
            let array = snapshot.value as? NSArray
            self.messagesCount = (array?.count)!
            
            print ("Array count \(self.messagesCount)")
            self.getData()
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    
    func getData () {
        var ref: FIRDatabaseReference!
        
        ref = FIRDatabase.database().reference()
        
        ref.child("users").observeSingleEvent(of: .value, with: { (snapshot) in
            
            let array = snapshot.value as? NSArray
            
            if ((array?.count)! > self.messagesCount) {
                self.messagesCount = (array?.count)!
                let dictionary = array?.lastObject as! NSDictionary
                self.performSegue(withIdentifier: "testShow", sender: self)
            }
            self.getData()
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
   /**********/

    
    /****/
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingHeading()
        self.getDataFirstTime()
    }
    
    @IBAction func findMeButton(_ sender: Any) {
       geoPostion()
    }
    
 
    
    
    @IBAction func zoomPlus(_ sender: Any) {
        let spanZoom = MKCoordinateSpan(latitudeDelta: mapView.region.span.latitudeDelta/2, longitudeDelta: mapView.region.span.longitudeDelta/2)
        let region = MKCoordinateRegion(center: mapView.region.center, span: spanZoom)
        mapView.setRegion(region, animated: true)
    }
    
    @IBAction func minusZoom(_ sender: Any) {
        zoom()
    }
    
    @IBAction func startDutyButton(_ sender: Any) {
        timers()
        geoPostion()
    }
    
    
    func timers(){
            
DispatchQueue.global(qos: .userInitiated).async {
    DispatchQueue.main.async {
        let aSelector : Selector = #selector(onDutyViewController.updateTime)
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: aSelector, userInfo: nil, repeats: true)
        self.startTime = Date.timeIntervalSinceReferenceDate
    
            }
        }
        
    }
    
   /* func iLoveWithEvelina(){
        let views : Selector = #selector(onDutyViewController.teddiaLittleDog)
        let timerss = Timer.scheduledTimer(timeInterval: 5, target: self, selector: views, userInfo: nil, repeats: true)
        print("loveEvelina")
    }
    
    func teddiaLittleDog(){
        self.performSegue(withIdentifier: "testShow", sender: self)
        print("nagly teddi")
    } */
    
    
    func updateTime() {
        let currentTime = Date.timeIntervalSinceReferenceDate
        
        //Find the difference between current time and start time.
        var elapsedTime: TimeInterval = currentTime - startTime
        
        //calculate the Hour
        let hour = UInt(elapsedTime / 3600)
       // elapsedTime -= (TimeInterval(hour) * 24)
        
        //calculate the minutes in elapsed time.
        let minutes = UInt8(elapsedTime / 60.0)
        elapsedTime -= (TimeInterval(minutes) * 60)
        
        //calculate the seconds in elapsed time.
        let seconds = UInt8(elapsedTime)
        elapsedTime -= TimeInterval(seconds)
        
        
        //add the leading zero for minutes, seconds and millseconds and store them as string constants
        
        let strHour = String(format: "%02d", hour)
        let strMinutes = String(format: "%02d", minutes)
        let strSeconds = String(format: "%02d", seconds)
        
        timeLabel.text = "\(strHour):\(strMinutes):\(strSeconds)"
    }


    func geoPostion(){
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.mapView.showsUserLocation = true
    }
    
    func zoom(){
        let spanZoom = MKCoordinateSpan(latitudeDelta: mapView.region.span.latitudeDelta/2, longitudeDelta: mapView.region.span.longitudeDelta*2)
        let region = MKCoordinateRegion(center: mapView.region.center, span: spanZoom)
        mapView.setRegion(region, animated: true)
    }
    
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            let pin = mapView.view(for: annotation) ?? MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
            pin.image = UIImage(named: "navigation")
            userPinView = pin
            return pin
        } else{
                
        }
        return nil
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        let result : Double = (newHeading.magneticHeading * .pi/180)
        let theTransform  = CGAffineTransform(rotationAngle: CGFloat(result))
        userPinView.transform = theTransform
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        let region = MKCoordinateRegion(center: center, span: span)
        
        let user_lat = String(format: "%f", (manager.location?.coordinate.latitude)!)
        let user_lap = String(format: "%f", (manager.location?.coordinate.longitude)!)
        let user_speed = String(format: "%f", (manager.location?.speed)!)
        let user_put = String(format: "%f", (manager.location?.altitude)!)
        
        print("Широта - \(user_lat)")
        print("Долгота - \(user_lap)")
        print("Скорость - \(user_speed)")
        print("путь   - \(user_put)")
        
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                self.mapView.setRegion(region, animated: true)
                self.locationManager.startUpdatingLocation()
            }
        }
        
        
    }

 
}

