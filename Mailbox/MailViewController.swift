//
//  MailViewController.swift
//  Mailbox
//
//  Created by Jason Demetillo on 9/16/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

import UIKit

class MailViewController: UIViewController {

    @IBOutlet weak var mailboxView: UIView!
    @IBOutlet weak var scollView: UIScrollView!
    @IBOutlet weak var feedView: UIImageView!
    @IBOutlet weak var messageView: UIImageView!
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var archiveIcon: UIImageView!
    @IBOutlet weak var deleteIcon: UIImageView!
    @IBOutlet weak var laterIcon: UIImageView!
    @IBOutlet weak var listIcon: UIImageView!
    @IBOutlet weak var rescheduleView: UIImageView!
    @IBOutlet weak var listView: UIImageView!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var fullView: UIView!
    
    var messageCenter: CGPoint!
    var archiveIconCenter: CGPoint!
    var deleteIconCenter: CGPoint!
    var laterIconCenter: CGPoint!
    var listIconCenter: CGPoint!
    var originalCenter : CGPoint!
    var menuHide : Bool = true
    
    @IBAction func onDismiss(sender: AnyObject) {
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.rescheduleView.alpha = 0
            
            }) { (finished:Bool) -> Void in
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.messageView.center.x = self.messageView.frame.width/2
                    self.laterIcon.center.x = 277
                    self.listIcon.center.x = 277
                    self.laterIcon.alpha = 0
                    self.listIcon.alpha = 0
                })
            }

    }

    @IBAction func onReschedule(sender: UIButton) {
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.rescheduleView.alpha = 0
            
            }) { (finished:Bool) -> Void in
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.feedView.center.y = self.feedView.center.y - self.messageView.frame.height
                })
        }
        
    }
    
    @IBAction func onList(sender: UIButton) {
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.listView.alpha = 0
            
            }) { (finished:Bool) -> Void in
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.feedView.center.y = self.feedView.center.y - self.messageView.frame.height
                })
        }
        
        
        
        
    }
    
    @IBAction func onMenu(sender: AnyObject) {
        if (menuHide) {
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                self.fullView.frame.origin.x = 285
                }, completion: nil)
            menuHide = false
        } else {
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                self.fullView.frame.origin.x = 0
                }, completion: nil)
            menuHide = true
        }
    }
    
    @IBAction func onPanMessage(gestureRecognizer: UIPanGestureRecognizer) {
        
        var location = gestureRecognizer.locationInView(view)
        var velocity = gestureRecognizer.velocityInView(view)
        var translation = gestureRecognizer.translationInView(view)
        var breakpointone = messageView.frame.width/4.5
        var breakpointtwo = messageView.frame.width/1.25
        var changeSpeed = 0.2
        var snapSpeed = 0.1
        
        if (gestureRecognizer.state == UIGestureRecognizerState.Began){

            self.messageCenter = messageView.center
            self.archiveIconCenter = archiveIcon.center
            self.laterIconCenter = laterIcon.center
            self.listIconCenter = listIcon.center
            self.deleteIconCenter = deleteIcon.center
            0
            //gray: 214, 214, 214
            colorView.backgroundColor = UIColor(red: 214/255, green: 214/255, blue: 214/255, alpha: 1.0)
            
        } else if (gestureRecognizer.state == UIGestureRecognizerState.Changed){
            //println("pan changed")
            println(translation.x)
            messageView.center.x = self.messageCenter.x+translation.x
            
            if (translation.x < breakpointone && -breakpointone < translation.x){
                
                archiveIcon.alpha = translation.x/breakpointone
                UIView.animateWithDuration(changeSpeed, animations: { () -> Void in

                    self.colorView.backgroundColor = UIColor (red: 214/255, green: 214/255, blue: 214/255, alpha: 1)
                })
                
                self.colorView.backgroundColor = UIColor (red: 214/255, green: 214/255, blue: 214/255, alpha: 1)
                
                self.laterIcon.alpha = -translation.x / breakpointone
                
            }
                

            else if (breakpointone < translation.x && translation.x <  breakpointtwo){
                
                archiveIcon.center.x = self.archiveIconCenter.x + translation.x - breakpointone
                
                //2. archive icon will always be visible
                archiveIcon.alpha = 1
                
                UIView.animateWithDuration(changeSpeed, animations: { () -> Void in
                    self.colorView.backgroundColor = UIColor(red: 48/255, green: 211/255, blue: 182/255, alpha: 1.0)
                    }, completion: nil)
                
                self.deleteIcon.alpha = 0
                deleteIcon.center.x = self.deleteIconCenter.x + translation.x - breakpointone
            }

            else if (-breakpointtwo < translation.x && translation.x < -breakpointone){
                
                //1. will always be yellow 255 221 77
                UIView.animateWithDuration(changeSpeed, animations: { () -> Void in
                    self.colorView.backgroundColor = UIColor(red: 255/255, green: 221/255, blue: 77/255, alpha: 1.0)
                    }, completion: nil)
                
                //2. later icon always visible
                laterIcon.alpha = 1
                
                //3. later icon will always follow
                laterIcon.center.x = self.laterIconCenter.x + translation.x + breakpointone
                
                //4. list icon will be invisible
                listIcon.alpha = 0
                
                //5. list icon will follow
                listIcon.center.x = self.listIconCenter.x + translation.x + breakpointone
                
                
            }

            else if (translation.x > breakpointtwo) {
                //Positive movement
                //1. color block will always be RED 248 14 93
                UIView.animateWithDuration(changeSpeed, animations: { () -> Void in
                    self.colorView.backgroundColor = UIColor(red: 248/255, green: 14/255, blue: 93/255, alpha: 1.0)
                    }, completion: nil)
                
                archiveIcon.alpha = 0
                archiveIcon.center.x = self.archiveIconCenter.x + translation.x - breakpointone
                
                //4. delete icon visible
                //5. delete icon follows
                deleteIcon.alpha = 1
                deleteIcon.center.x = self.deleteIconCenter.x + translation.x - breakpointone
                
            }

                
            else if(translation.x < -breakpointtwo){
                //Negative movement
                //1. will always be brown 189 164 135
                UIView.animateWithDuration(changeSpeed, animations: { () -> Void in
                    self.colorView.backgroundColor = UIColor(red: 189/255, green: 164/255, blue: 135/255, alpha: 1.0)
                    }, completion: nil)
                
                //2. later icon always visible
                laterIcon.alpha = 0
                
                //3. later icon will always follow
                laterIcon.center.x = self.laterIconCenter.x + translation.x + breakpointone
                
                //4. list icon will be invisible
                listIcon.alpha = 1
                
                //5. list icon will follow
                listIcon.center.x = self.listIconCenter.x + translation.x + breakpointone
                
                
            }
            
            //****PANNING ENDED****//
        } else if (gestureRecognizer.state == UIGestureRecognizerState.Ended){
            println("pan ended")

            if (translation.x < breakpointone && -breakpointone < translation.x
                ){
                    UIView.animateWithDuration(snapSpeed, animations: { () -> Void in
                        self.messageView.center.x = self.messageCenter.x
                    })
                    
                    
            } else if (translation.x > breakpointone ){
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    

                    self.messageView.center.x = self.messageView.center.x + 320
                    self.archiveIcon.center.x = self.archiveIcon.center.x + 320
                    self.deleteIcon.center.x = self.deleteIcon.center.x + 320
                    
                    
                    }, completion: { (finished:Bool) -> Void in
                        
                        UIView.animateWithDuration(0.2, animations: { () -> Void in
                            self.feedView.center.y = self.feedView.center.y - self.messageView.frame.height
                        })
                })
                
    
            } else if (-breakpointtwo < translation.x  && translation.x < -breakpointone ){
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.messageView.center.x = -self.messageView.frame.width
                    self.laterIcon.center.x = -self.messageView.frame.width
                    self.listIcon.center.x = -self.messageView.frame.width
                    
                    }, completion: { (finished:Bool) -> Void in
                        UIView.animateWithDuration(0.2, animations: { () -> Void in
                            self.rescheduleView.alpha = 1
                        })
                })
            
            }  else if(translation.x < -breakpointtwo){
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.messageView.center.x = -self.messageView.frame.width
                    self.laterIcon.center.x = -self.messageView.frame.width
                    self.listIcon.center.x = -self.messageView.frame.width
                    
                    }, completion: { (finished:Bool) -> Void in
                        UIView.animateWithDuration(0.2, animations: { () -> Void in
                            self.listView.alpha = 1
                        })
                })
            }
        }

    
        
    }
    
    @IBAction func onEdgePan(gestureRecognizer: UIScreenEdgePanGestureRecognizer) {
        var translation = gestureRecognizer.translationInView(view)
        var edgePan = UIScreenEdgePanGestureRecognizer(target: view, action: "onEdgePan:")
        
        if (gestureRecognizer.state == UIGestureRecognizerState.Began) {
            originalCenter = fullView.center
        } else if (gestureRecognizer.state == UIGestureRecognizerState.Changed) {
            println("got here \(menuHide)")
            if (menuHide) {
                fullView.center.x = originalCenter.x + translation.x
            } else {
                fullView.center.x = originalCenter.x - translation.x
                println(translation.x)
            }
        } else if (gestureRecognizer.state == UIGestureRecognizerState.Ended) {
            if (menuHide && translation.x > 90) {
                UIView.animateWithDuration(0.4, animations: { () -> Void in
                    self.fullView.frame.origin.x = 285
                    }, completion: nil)
                menuHide = false
                edgePan.edges = UIRectEdge.Right
            } else if (menuHide) {
                UIView.animateWithDuration(0.4, animations: { () -> Void in
                    self.fullView.frame.origin.x = 0
                    }, completion: nil)
            } else if (translation.x < -90) {
                UIView.animateWithDuration(0.4, animations: { () -> Void in
                    self.fullView.frame.origin.x = 285
                    }, completion: nil)
            } else {
                UIView.animateWithDuration(0.4, animations: { () -> Void in
                    self.fullView.frame.origin.x = 0
                    }, completion: nil)
                menuHide = true
                edgePan.edges = UIRectEdge.Left
            }
            println(menuHide)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        scollView.contentSize = feedView.image!.size
        archiveIcon.alpha = 0
        laterIcon.alpha = 0
        listIcon.alpha = 0
        deleteIcon.alpha = 0
        rescheduleView.alpha = 0
        listView.alpha = 0
        
        var edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: "onEdgePan:")
        edgePan.edges = UIRectEdge.Left
        fullView.addGestureRecognizer(edgePan)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
