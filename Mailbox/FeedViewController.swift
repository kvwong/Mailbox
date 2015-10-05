//
//  FeedViewController.swift
//  Mailbox
//
//  Created by Kevin Wong on 10/3/15.
//  Copyright © 2015 Kevin Wong. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var feedView: UIImageView!
    @IBOutlet weak var helpView: UIImageView!
    @IBOutlet weak var searchView: UIImageView!
    @IBOutlet weak var messageView: UIImageView!
    @IBOutlet var panMessage: UIPanGestureRecognizer!
    @IBOutlet weak var listView: UIImageView!
    @IBOutlet weak var menuView: UIImageView!
    @IBOutlet weak var rescheduleView: UIImageView!
    @IBOutlet weak var navView: UIImageView!
    @IBOutlet weak var tabView: UISegmentedControl!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var archiveIcon: UIImageView!
    @IBOutlet weak var deleteIcon: UIImageView!
    @IBOutlet weak var laterIcon: UIImageView!
    @IBOutlet weak var listIcon: UIImageView!
    @IBOutlet weak var messageBackground: UIView!
    @IBOutlet weak var appView: UIView!
    @IBOutlet weak var archiveView: UIImageView!
    @IBOutlet weak var laterView: UIImageView!
    @IBOutlet weak var composer: UIImageView!
    @IBOutlet weak var blackout: UIView!
    
    var totalSize : CGFloat = 0.0
    var messageCenter: CGPoint!
    var menuX : CGFloat!
    var menuOffset : CGFloat!
    var menuStatus : Bool!
    var rescheduleStatus : Bool!
    var listStatus : Bool!
    var offset : CGFloat!
    var scrollPoint : CGPoint!
    var iconOffset : CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        offset = helpView.image!.size.height + searchView.image!.size.height
        print(offset)
        scrollPoint = CGPointMake(0.0, offset)
        
        menuOffset = 270.0
        menuStatus = false
        rescheduleStatus = false
        listStatus = false
        
        totalSize = feedView.image!.size.height + helpView.image!.size.height + searchView.image!.size.height
        
        scrollView.setContentOffset(scrollPoint, animated: true)
        scrollView.contentSize.height = totalSize
        
        messageBackground.backgroundColor = UIColor.greenColor()
        archiveIcon.alpha = 0
        deleteIcon.alpha = 0
        laterIcon.alpha = 0
        listIcon.alpha = 0
        rescheduleView.alpha = 0
        listView.alpha = 0
        menuView.alpha = 0
        blackout.alpha = 0
        laterView.alpha = 0
        
        let edgeGesture = UIScreenEdgePanGestureRecognizer(target: self, action: "onEdgePan:")
        edgeGesture.edges = UIRectEdge.Left
        appView.addGestureRecognizer(edgeGesture)
    }
    
    @IBAction func compose(sender: AnyObject) {
        blackout.alpha = 0.5
        UIView.animateWithDuration(0.3, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.composer.frame.origin.y = 65
            }, completion: nil)
    }
    
    @IBAction func tabbing(sender: AnyObject) {
        switch tabView.selectedSegmentIndex
        {
        case 0:
            tabView.tintColor = UIColorFromHex(0xFFCC00, alpha: 1.0)
            laterView.alpha = 1
            
            if scrollView.frame.origin.x == 0 {
                archiveView.frame.origin.x = 320
                
                UIView.animateWithDuration(0.3) { () -> Void in
                    self.laterView.frame.origin.x = 0
                    self.scrollView.frame.origin.x = 320
                }
                
            } else if archiveView.frame.origin.x == 0 {
                scrollView.frame.origin.x = 320
                
                UIView.animateWithDuration(0.3) { () -> Void in
                    self.laterView.frame.origin.x = 0
                    self.archiveView.frame.origin.x = 320
                }
            }
        case 1:
            scrollView.alpha = 1
            tabView.tintColor = UIColorFromHex(0x50B9DB, alpha: 1.0)
            if laterView.frame.origin.x == 0 {
                archiveView.frame.origin.x = 320
                
                UIView.animateWithDuration(0.3, animations: {
                    self.scrollView.frame.origin.x = 0
                    self.laterView.frame.origin.x = -320
                    }, completion: {
                        (finished: Bool) -> Void in
                        self.laterView.alpha = 0
                })
            } else if archiveView.frame.origin.x == 0 {
                laterView.frame.origin.x = -320
                
                UIView.animateWithDuration(0.3) { () -> Void in
                    self.scrollView.frame.origin.x = 0
                    self.archiveView.frame.origin.x = 320
                }
            }
            
        case 2:
            tabView.tintColor = UIColorFromHex(0x62DA62, alpha: 1.0)
            if laterView.frame.origin.x == 0 {
                scrollView.frame.origin.x = -320
                scrollView.alpha = 0
                UIView.animateWithDuration(0.3, animations: {
                    self.archiveView.frame.origin.x = 0
                    self.laterView.frame.origin.x = -320
                    }, completion: {
                        (finished: Bool) -> Void in
                        self.laterView.alpha = 0
                })
            } else if scrollView.frame.origin.x == 0 {
                laterView.frame.origin.x = -320
                laterView.alpha = 0
                
                UIView.animateWithDuration(0.3, animations: {
                    self.archiveView.frame.origin.x = 0
                    self.scrollView.frame.origin.x = -320
                    }, completion: {
                        (finished: Bool) -> Void in
                        self.scrollView.alpha = 0
                })
            }
        default:
            break;
        }
    }
    
    @IBAction func menu(sender: AnyObject) {
        if menuStatus == false {
            self.menuView.alpha = 1
            self.menuStatus = true
            self.scrollView.userInteractionEnabled = false
            self.messageView.userInteractionEnabled = false
            UIView.animateWithDuration(0.3) { () -> Void in
                self.appView.frame.origin.x = self.appView.frame.origin.x + self.menuOffset
            }
        } else {
            self.scrollView.userInteractionEnabled = true
            self.messageView.userInteractionEnabled = true
            UIView.animateWithDuration(0.3) { () -> Void in
                //self.menuView.alpha = 0
                self.menuStatus = false
                self.appView.frame.origin.x = self.appView
                    .frame.origin.x - self.menuOffset
            }
        }
    }
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
    
    @IBOutlet var edgeSwipe: UIScreenEdgePanGestureRecognizer!
    
    
    func onEdgePan(edgeGesture: UIScreenEdgePanGestureRecognizer) {
        if edgeGesture.state == .Recognized {
            if menuStatus == false {
                self.menuView.alpha = 1
                self.menuStatus = true
                self.scrollView.userInteractionEnabled = false
                self.messageView.userInteractionEnabled = false
                UIView.animateWithDuration(0.3, delay: 0.0, usingSpringWithDamping: 0.65, initialSpringVelocity: 0.3, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                    self.appView.frame.origin.x = self.appView.frame.origin.x + self.menuOffset
                    }, completion: nil)
            } else {
                UIView.animateWithDuration(0.3, delay: 0.0, usingSpringWithDamping: 0.65, initialSpringVelocity: 0.3, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                    self.menuView.alpha = 0
                    self.menuStatus = false
                    self.scrollView.userInteractionEnabled = true
                    self.messageView.userInteractionEnabled = true
                    self.appView.frame.origin.x = self.appView
                        .frame.origin.x - self.menuOffset
                    }, completion: nil)
            }
            print("Screen edge swiped!")
        }
    }
    
    
    //Edge swipe the app to open the menu
    @IBAction func edgeSwipe(sender: UIScreenEdgePanGestureRecognizer) {
    }
    
    @IBAction func swipeMenuClose(sender: UIPanGestureRecognizer) {
        let translation = sender.translationInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {
            menuX = appView.frame.origin.x
        }
            
        else if sender.state == UIGestureRecognizerState.Changed {
            appView.frame.origin.x = menuX + translation.x
            menuView.alpha = 1
        }
            
        else if sender.state == UIGestureRecognizerState.Ended {
            if appView.frame.origin.x > 60 && menuStatus == false {
                UIView.animateWithDuration(0.3) { () -> Void in
                    self.appView.frame.origin.x = self.menuOffset
                    self.menuStatus = true
                    self.menuView.alpha = 1
                    self.scrollView.userInteractionEnabled = false
                    self.messageView.userInteractionEnabled = false
                }
            } else if appView.frame.origin.x > 0 && appView.frame.origin.x < 60 && menuStatus == false {
                UIView.animateWithDuration(0.3) { () -> Void in
                    self.appView.frame.origin.x = self.menuX
                    self.menuStatus = false
                }
            } else if appView.frame.origin.x < 220 && menuStatus == true {
                UIView.animateWithDuration(0.3) { () -> Void in
                    self.appView.frame.origin.x = 0.0
                    self.menuStatus = false
                    self.scrollView.userInteractionEnabled = true
                    self.messageView.userInteractionEnabled = true
                }
            } else {
                UIView.animateWithDuration(0.3) { () -> Void in
                    self.appView.frame.origin.x = self.menuOffset
                    self.menuStatus = true
                    self.menuView.alpha = 1
                    self.scrollView.userInteractionEnabled = false
                    self.messageView.userInteractionEnabled = false
                }
            }
        }
    }
    
    //Pan swipe menu button to open the menu
    @IBAction func swipeMenu(sender: UIPanGestureRecognizer) {
        let translation = sender.translationInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {
            menuX = appView.frame.origin.x
        }
            
        else if sender.state == UIGestureRecognizerState.Changed {
            appView.frame.origin.x = menuX + translation.x
            menuView.alpha = 1
        }
            
        else if sender.state == UIGestureRecognizerState.Ended {
            if appView.frame.origin.x > 60 && menuStatus == false {
                UIView.animateWithDuration(0.3) { () -> Void in
                    self.appView.frame.origin.x = self.menuOffset
                    self.menuStatus = true
                    self.menuView.alpha = 1
                    self.scrollView.userInteractionEnabled = false
                    self.messageView.userInteractionEnabled = false
                }
            } else if appView.frame.origin.x > 0 && appView.frame.origin.x < 60 && menuStatus == false {
                UIView.animateWithDuration(0.3) { () -> Void in
                    self.appView.frame.origin.x = self.menuX
                    self.menuStatus = false
                }
            } else if appView.frame.origin.x < 220 && menuStatus == true {
                UIView.animateWithDuration(0.3) { () -> Void in
                    self.appView.frame.origin.x = 0.0
                    self.menuStatus = false
                    self.scrollView.userInteractionEnabled = true
                    self.messageView.userInteractionEnabled = true
                }
            } else {
                UIView.animateWithDuration(0.3) { () -> Void in
                    self.appView.frame.origin.x = self.menuOffset
                    self.menuStatus = true
                    self.menuView.alpha = 1
                    self.scrollView.userInteractionEnabled = false
                    self.messageView.userInteractionEnabled = false
                }
            }
        }
    }
    
    //Swipe message to take action
    @IBAction func swipeMessage(sender: UIPanGestureRecognizer) {
        //let point = sender.locationInView(view)
        let translation = sender.translationInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {
            messageCenter = messageView.center
            archiveIcon.alpha = 0
            laterIcon.alpha = 0
            deleteIcon.alpha = 0
            listIcon.alpha = 0
            
            //GESTURE CHANGED
        } else if sender.state == UIGestureRecognizerState.Changed {
            messageView.center = CGPoint(x: messageCenter.x + translation.x, y: messageCenter.y)
            let archiveAlpha = (1.667 * messageView.frame.origin.x) / 100
            let laterAlpha = (1.667 * fabs(messageView.frame.origin.x)) / 100
            
            if messageView.frame.origin.x > 0 && messageView.frame.origin.x < 60 {
                messageBackground.backgroundColor = UIColorFromHex(0xE3E3E3, alpha: 1.0)
                archiveIcon.alpha = archiveAlpha
                archiveIcon.frame.origin.x = 20
                
                print(archiveAlpha)
                print(messageView.frame.origin.x)
            }
            else if messageView.frame.origin.x < 0 && messageView.frame.origin.x > -60 {
                messageBackground.backgroundColor = UIColorFromHex(0xE3E3E3, alpha: 1.0)
                laterIcon.alpha = laterAlpha
                laterIcon.frame.origin.x = 280
                
                print(laterAlpha)
                print(messageView.frame.origin.x)
            }
                
                //Archive that shit
            else if messageView.frame.origin.x > 60 && messageView.frame.origin.x < 260 {
                archiveIcon.frame.origin.x = messageView.frame.origin.x - 40
                archiveIcon.alpha = 1
                deleteIcon.alpha = 0
                messageBackground.backgroundColor = UIColorFromHex(0x62DA62, alpha: 1.0)
            }
                
                //Delete that shit
            else if messageView.frame.origin.x > 260 {
                deleteIcon.frame.origin.x = messageView.frame.origin.x - 40
                deleteIcon.alpha = 1
                archiveIcon.alpha = 0
                messageBackground.backgroundColor = UIColorFromHex(0xEF540D, alpha: 1.0)
            }
                
                //Reschedule that shit
            else if messageView.frame.origin.x < -60 && messageView.frame.origin.x > -260 {
                laterIcon.frame.origin.x = messageView.frame.origin.x + 340
                self.laterIcon.alpha = abs(1.667 * messageView.frame.origin.x)
                listIcon.alpha = 0
                messageBackground.backgroundColor = UIColorFromHex(0xFFCC00, alpha: 1.0)
            }
                
                //Put that shit in a list
            else if messageView.frame.origin.x < -260 {
                listIcon.frame.origin.x = messageView.frame.origin.x + 340
                listIcon.alpha = 1
                laterIcon.alpha = 0
                messageBackground.backgroundColor = UIColorFromHex(0xD9A676, alpha: 1.0)
            }
            
            //GESTURE ENDED
        } else if sender.state == UIGestureRecognizerState.Ended {
            if messageView.frame.origin.x < 60 && messageView.frame.origin.x > 0 {
                UIView.animateWithDuration(0.3, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                    self.messageView.frame.origin.x = 0
                    }, completion: nil)
            }
                
            else if messageView.frame.origin.x > -60 && messageView.frame.origin.x < 0 {
                UIView.animateWithDuration(0.3, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                    self.messageView.frame.origin.x = 0
                    }, completion: nil)
            }
                
                //Complete ARCHIVE Animation
            else if messageView.frame.origin.x > 60 && messageView.frame.origin.x < 260 {
                messageBackground.backgroundColor = UIColorFromHex(0x62DA62, alpha: 1.0)
                archiveIcon.alpha = 0
                deleteIcon.alpha = 0
                laterIcon.alpha = 0
                listIcon.alpha = 0
                
                UIView.animateWithDuration(0.25, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                    self.messageView.frame.origin.x = 320
                    }, completion: {
                        (finished: Bool) -> Void in
                        
                        UIView.animateWithDuration(0.25, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                            self.feedView.frame.origin.y = self.feedView.frame.origin.y - 86
                            self.messageBackground.frame.size.height = 0
                            }, completion: nil)
                })
                
            }
                
                //Complete DELETE Animation
            else if messageView.frame.origin.x > 260 {
                messageBackground.backgroundColor = UIColorFromHex(0xEF540D, alpha: 1.0)
                archiveIcon.alpha = 0
                deleteIcon.alpha = 0
                laterIcon.alpha = 0
                listIcon.alpha = 0
                
                UIView.animateWithDuration(0.25, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                    self.messageView.frame.origin.x = 320
                    }, completion: {
                        (finished: Bool) -> Void in
                        
                        UIView.animateWithDuration(0.25, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                            self.feedView.frame.origin.y = self.feedView.frame.origin.y - 86
                            self.messageBackground.frame.size.height = 0
                            }, completion: nil)
                })
                
                
            }
                
                //Complete RESCHEDULE Animation
            else if messageView.frame.origin.x < -60 && messageView.frame.origin.x > -260 {
                messageBackground.backgroundColor = UIColorFromHex(0xFFCC00, alpha: 1.0)
                archiveIcon.alpha = 0
                deleteIcon.alpha = 0
                laterIcon.alpha = 0
                listIcon.alpha = 0
                
                UIView.animateWithDuration(0.25, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                    self.messageView.frame.origin.x = -320
                    self.rescheduleView.alpha = 1
                    }, completion: {
                        (finished: Bool) -> Void in
                        
                        //if self.rescheduleView.alpha == 0 {
                        //UIView.animateWithDuration(0.25, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                        //    self.feedView.frame.origin.y = self.feedView.frame.origin.y - 86
                        //    self.messageBackground.frame.size.height = 0
                        //    }, completion: nil)
                        //} else {
                        
                        //}
                })
                
                
            }
                
                //Complete LIST Animation
            else if messageView.frame.origin.x < -260 {
                messageBackground.backgroundColor = UIColorFromHex(0xD9A676, alpha: 1.0)
                archiveIcon.alpha = 0
                deleteIcon.alpha = 0
                laterIcon.alpha = 0
                listIcon.alpha = 0
                
                UIView.animateWithDuration(0.25, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                    self.messageView.frame.origin.x = -320
                    self.listView.alpha = 1
                    }, completion: {
                        (finished: Bool) -> Void in
                })
                
                
            }
            
        }
    }
    
    @IBAction func dismissComposer(sender: AnyObject) {
        UIView.animateWithDuration(0.15, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
            self.composer.frame.origin.y = 568
            self.blackout.alpha = 0
            }, completion: nil)
    }
    
    @IBAction func dismissRescheduleView(sender: AnyObject) {
        if rescheduleView.alpha == 1 {
            rescheduleView.alpha = 0
            UIView.animateWithDuration(0.25, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                self.feedView.frame.origin.y = self.feedView.frame.origin.y - 86
                self.messageBackground.frame.size.height = 0
                }, completion: nil)
        } else {
            rescheduleView.alpha = 1
        }
    }
    
    @IBAction func dismissLIstView(sender: AnyObject) {
        if listView.alpha == 1 {
            listView.alpha = 0
            UIView.animateWithDuration(0.25, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                self.feedView.frame.origin.y = self.feedView.frame.origin.y - 86
                self.messageBackground.frame.size.height = 0
                }, completion: nil)
        } else {
            listView.alpha = 1
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
