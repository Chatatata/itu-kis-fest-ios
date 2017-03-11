//
//  ViewController.swift
//  itukisfestivali
//
//  Created by Efe Helvaci on 26.10.2016.
//  Copyright © 2016 efehelvaci. All rights reserved.
//

import UIKit
import FirebaseDatabase

class MainPageViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource, ScrollPagerDelegate, UIPopoverPresentationControllerDelegate{

    @IBOutlet var scrollPager: ScrollPager!
    @IBOutlet var eventsCollectionView: UICollectionView!
    @IBOutlet var notificationsTableView: UITableView!
    @IBOutlet var galleryCollectionView: UICollectionView!
    
    let infoButton : UIButton! = UIButton(type: .infoDark)
    var events = [Event]()
    var notifications = [String]()
    var imageURLs = [String]()
    
    var imageVC : ImageViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        infoButton.addTarget(self, action: #selector(infoButtonClicked), for: .touchUpInside)
        
        navigationItem.titleView = UIImageView(image: UIImage(named: "Logo"))
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: infoButton)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Galeri", style: .plain, target: nil, action: nil)
        
        let eventCellNib = UINib(nibName: "EventCollectionViewCell", bundle: nil)
        let notificationCellNib = UINib(nibName: "NotificationTableViewCell", bundle: nil)
        let galleryCellNib = UINib(nibName: "GalleryCollectionViewCell", bundle: nil)
        
        eventsCollectionView.register(eventCellNib, forCellWithReuseIdentifier: "eventCell")
        notificationsTableView.register(notificationCellNib, forCellReuseIdentifier: "notificationCell")
        galleryCollectionView.register(galleryCellNib, forCellWithReuseIdentifier: "galleryCell"
        )
        scrollPager.delegate = self
        scrollPager.addSegmentsWithTitlesAndViews(segments: [
            ("Etkinlikler", eventsCollectionView),
            ("Duyurular", notificationsTableView),
            ("Galeri", galleryCollectionView)
            ])
        
        imageVC = self.storyboard?.instantiateViewController(withIdentifier: "ImageViewController") as! ImageViewController
        
        retrieveEvents()
        retrieveNotifications()
        retrieveGallery()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - CollectionView Delegate Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == eventsCollectionView {
            return events.count
        } else {
            return imageURLs.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == eventsCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "eventCell", for: indexPath) as! EventsCollectionViewCell
            
            cell.configureCell(event: events[indexPath.row])
            
            return cell
        } else if collectionView == galleryCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "galleryCell", for: indexPath) as! GalleryCollectionViewCell
            
            cell.galleryImage.kf.setImage(with: URL(string: imageURLs[indexPath.row]))
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == galleryCollectionView {
            imageVC.imageURL = imageURLs[indexPath.row]
            show(imageVC, sender: self)
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        if collectionView == eventsCollectionView {
            let cellHeight : CGFloat = 225 + (events[indexPath.row].description).heightWithConstrainedWidth(screenSize.width-16, font: UIFont(name: "OpenSans", size: 14)!)
            return CGSize(width: screenSize.width - 8, height: cellHeight + 12)
        } else {
            return CGSize(width: (screenSize.width / 3.0) - 7, height: (screenSize.width / 3.0) - 7)
        }
    }
    
    
    // MARK: -Table View Delegate Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "notificationCell") as? NotificationTableViewCell {
            cell.notificationLabel.text = notifications[indexPath.row]
            
            return cell
        } else {
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var notificationHeight : CGFloat = 60
        
        if notifications[indexPath.row].heightWithConstrainedWidth(screenSize.width-16, font: UIFont(name: "Open Sans", size: 14)!) > 40 {
            notificationHeight = notifications[indexPath.row].heightWithConstrainedWidth(screenSize.width-16, font: UIFont(name: "Open Sans", size: 14)!) + 30
        }
        
        return notificationHeight
    }

    func retrieveEvents() {
        var tempEvents = [Event]()
        var counter = 0
        
        REF_EVENTS.observe(.value, with: { snapshot in
            if snapshot.exists() {
                tempEvents.removeAll()
                counter = 0
                
                for eventSnap in snapshot.children.allObjects {
                    counter += 1
                    
                    let newEvent = Event(snapshot: eventSnap as! FIRDataSnapshot)
                    
                    tempEvents.append(newEvent)
                    
                    if counter == snapshot.children.allObjects.count {
                        tempEvents.reverse()
                        self.events = tempEvents
                        self.eventsCollectionView.reloadData()
                    }
                }
            }
        })
    }
    
    func retrieveNotifications() {
        var tempNotifications = [String]()
        var counter = 0
        
        REF_NOTIFICATIONS.observe(.value, with: { snapshot in
            if snapshot.exists() {
                tempNotifications.removeAll()
                counter = 0
                
                for notificatonSnap in snapshot.children.allObjects as! [FIRDataSnapshot] {
                    counter += 1
                    
                    if let data = notificatonSnap.value as? String {
                        tempNotifications.append(data)
                    }
                    
                    if counter == snapshot.children.allObjects.count {
                        self.notifications = tempNotifications
                        self.notificationsTableView.reloadData()
                    }
                }
            }
        })
        
    }
    
    func retrieveGallery() {
        var tempImageURLs = [String]()
        var counter = 0
        
        REF_GALLERY.observe(.value, with: { snapshot in
            if snapshot.exists() {
                tempImageURLs.removeAll()
                counter = 0
                
                for imageSnap in snapshot.children.allObjects as! [FIRDataSnapshot]{
                    counter += 1
                    
                    if let data = imageSnap.value as? String {
                        tempImageURLs.append(data)
                        
                    }
                    
                    if counter == snapshot.children.allObjects.count {
                        tempImageURLs.reverse()
                        self.imageURLs = tempImageURLs
                        self.galleryCollectionView.reloadData()
                    }
                    
                }
            }
        })
    }
    
    func infoButtonClicked() {
        print("LOLO")
        
        let popoverVC = storyboard?.instantiateViewController(withIdentifier: "DeveloperInfoViewController") as! DeveloperInfoViewController
        popoverVC.modalPresentationStyle = .popover
        popoverVC.preferredContentSize = CGSize(width: screenSize.width-16, height: 270)
        
        let popoverController = popoverVC.popoverPresentationController
        popoverController?.permittedArrowDirections = UIPopoverArrowDirection.up
        popoverController?.delegate = self
        popoverController?.sourceView = self.view
        popoverController?.sourceRect = CGRect(x: screenSize.width-52, y: 24, width: 32, height: 32)
        present(popoverVC, animated: true, completion: nil)
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }

    @IBAction func facebookPageClicked(_ sender: AnyObject) {
        let facebookURL = URL(string: "fb://profile/itukisfest")!
        if UIApplication.shared.canOpenURL(facebookURL) {
            UIApplication.shared.openURL(facebookURL)
        } else {
            UIApplication.shared.openURL(URL(string: "https://www.facebook.com/itukisfest")!)
        }
    }
    
    @IBAction func instagramPageClicked(_ sender: AnyObject) {
        let instagramURL = URL(string: "instagram://user?username=itukisfest")!
        if UIApplication.shared.canOpenURL(instagramURL) {
            UIApplication.shared.openURL(instagramURL)
        } else {
            UIApplication.shared.openURL(URL(string: "https://www.instagram.com/itukisfest")!)
        }
    }
    
    @IBAction func twitterPageClicked(_ sender: AnyObject) {
        let twitterURL = URL(string: "twitter:///user?screen_name=itukisfest")!
        if UIApplication.shared.canOpenURL(twitterURL) {
            UIApplication.shared.openURL(twitterURL)
        } else {
            UIApplication.shared.openURL(URL(string: "https://twitter.com/itukisfest")!)
        }
    }
}

