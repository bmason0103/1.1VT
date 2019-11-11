//
//  CollectionViewController.swift
//  MyVirturalTourist
//
//  Created by Brittany Mason on 11/4/19.
//  Copyright © 2019 Udacity. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class collectionViewController : UIViewController, MKMapViewDelegate {
    
    var latitude = 0.0
    var longitude = 0.0
    var cityName = ""
    
    @IBOutlet weak var collectionMapView: MKMapView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var newCollectionButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(latitude, "collectionview cord")
        print(longitude)
        collectionMapView.delegate = self
        let initialLocation = CLLocation(latitude: latitude, longitude: longitude)
        centerMapOnLocation(location: initialLocation)
    }
    
    
    let regionRadius: CLLocationDistance = 8000
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        let locCoord = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let annotation = MKPointAnnotation()
        annotation.coordinate = locCoord
        
        collectionMapView.setRegion(coordinateRegion, animated: true)
        collectionMapView.addAnnotation(annotation)
    }
    
    
    @IBAction func getPhotoButtonPressed(_ sender: Any) {
        print("new Collection button pressed")
        
        
        helperTasks.downloadPhotos { (pictureInfo, error) in
            if let pictureInfo = pictureInfo {
                let totalPhotos = pictureInfo.photos.photo.count
                print(totalPhotos)
//                Constants.FlickrParameters.APIResults = pictureInfo
                DispatchQueue.main.async {
                    self.populateCollectionView()
                }
            } else {
                DispatchQueue.main.async {
                    self.displayAlert(title: "Error", message: "Unable to get student locations.")
                }
                print(error as Any)
            }
        }
    }
    
    func populateCollectionView(){
        var annotations = [MKPointAnnotation]()
        //        for student in parametersAll.StudentLocation.studentsLocDict{
        //
        //            let lat = CLLocationDegrees(student.latitude)
        //            let long = CLLocationDegrees(student.longitude)
        //
        //            /* The lat and long are used to create a CLLocationCoordinates2D instance */
        //            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        //
        //            /* Create the annotation and set its coordiate, title, and subtitle properties */
        //            let annotation = MKPointAnnotation()
        //            annotation.coordinate = coordinate
        //            annotation.title = "\(student.firstName) \(student.lastName)"
        //            annotation.subtitle = "\(student.mediaURLs)"
        //
        //            /* Place the annotation in an array of annotations */
        //            annotations.append(annotation)
        //
        //        }
        //        /* When the array is complete, we add the annotations to the Map View */
        //        self.mapView.addAnnotations(annotations)
        //        print("Annotations are now added to the Map View.")
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        // 2
        let identifier = "pin"
        var view: MKMarkerAnnotationView
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView { // 3
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            // 4
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        //        let location = view.annotation as! Artwork
        let launchOptions = [MKLaunchOptionsDirectionsModeKey:
            MKLaunchOptionsDirectionsModeDriving]
        //        location.mapItem().openInMaps(launchOptions: launchOptions)
    }
    
}






