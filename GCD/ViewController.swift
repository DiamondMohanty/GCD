//
//  ViewController.swift
//  GCD
//
//  Created by Diamond Mohanty on 16/03/18.
//  Copyright © 2018 Codebasics. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    var inactiveQueue: DispatchQueue!
    
    @IBOutlet weak var imageView: NSImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        //simpleQueues()
        
        // advanceQueues()
        
        //queueWithQosSamePriority()
        
        //queueWithQosDifferentPririty()
        
        //serialQueueWithQos()
        
        // concurrentQueues()
        
        /*
         initiallyInactiveQueue()
        
        if let queue = inactiveQueue {
            queue.activate()
        } 
         */
        
        // delayQueue()
        
        // globalAndMainQueue()
        
        loadImageView()
        
        // useWorkItem
    
    
    }
    
    func simpleQueues() {
        
        // Creating a simple queue. This is not concurrent
        let queue = DispatchQueue(label: "com.codebits.queue1")
        
        // Heavy Work
        queue.sync {
            for i in 0...9 {
                print("❤️ \(i)")
            }
        }
        
        // UI Updation
        for i in 100...110 {
            print("🖤 \(i)")
        }
        
    }
    
    func advanceQueues() {
        
        let queue = DispatchQueue(label: "com.codebits.queue2")
        
        
        // Heavy Work
        queue.async {
            for i in 0...9 {
                print("❤️ \(i)")
            }
        }
        
        // UI Updation
        for i in 100...110 {
            print("🖤 \(i)")
        }
    }
    
    func queueWithQosSamePriority() {
        
        // Both Queues have same priorities
        
        let queue1 = DispatchQueue(label: "com.codebit.queue3", qos: .userInitiated)
        let queue2 = DispatchQueue(label: "com.codebit.queue4", qos: .userInitiated)
        
        
        queue1.async {
            for i in 0...9 {
                print("❤️ \(i)")
            }
        }
        
        queue2.async {
            for i in 100...110 {
                print("🖤 \(i)")
            }
        }
    }

    func queueWithQosDifferentPririty() {
        
        // Queues have different priority
        
        let queue1 = DispatchQueue(label: "com.codebit.queue5", qos: .userInitiated)
        
        // let queue1 = DispatchQueue(label: "com.codebit.queue5", qos: .background)
        
        let queue2 = DispatchQueue(label: "com.codebit.queue6", qos: .utility)
        
        queue1.async {
            for i in 0...9 {
                print("❤️ \(i)")
            }
            
        }
        
        queue2.async {
            for i in 100...110 {
                print("🖤 \(i)")
            }
        }
        
    }
    
    func serialQueueWithQos() {
            
        // Queues have different priority
        
        let queue1 = DispatchQueue(label: "com.codebit.queue5", qos: .userInitiated)
        
        // let queue1 = DispatchQueue(label: "com.codebit.queue5", qos: .background)
        
        let queue2 = DispatchQueue(label: "com.codebit.queue6", qos: .utility)
        
        
        // The blocks in queue1 are serial. Green Heart will never finish before red one
        
        queue1.async {
            for i in 0...9 {
                print("❤️ \(i)")
            }
            
        }
        
        
        queue1.async {
            for i in 10...20 {
                print("💚 \(i)")
            }
        }
        
        queue2.async {
            for i in 100...110 {
                print("🖤 \(i)")
            }
        }
        
    }
    
    func concurrentQueues() {
        
        // Defining a concurrent queue
        
        let queue = DispatchQueue(label: "com.codebits.queue7", qos: .userInitiated, attributes: .concurrent)
    
        
        queue.async {
            for i in 0...9 {
                print("❤️ \(i)")
            }
        }

        queue.async {
            for i in 10...20 {
                print("💚 \(i)")
            }
        }
        
        queue.async {
            for i in 100...110 {
                print("🖤 \(i)")
            }
        }
    }
    
    func initiallyInactiveQueue() {
        
        // attibutes: initiallyInactive. The queue does not trigger automatically. The developer need to trigger the queue.
        
        // Use of class property is necessary
        
        // Declaring a concurrent inactive queue
        
        let queue = DispatchQueue(label: "com.codebit.queue9", qos: .userInitiated, attributes: [.initiallyInactive, .concurrent])
        
        
        // Declaring a serial inactive queue
        // let queue = DispatchQueue(label: "com.codebit.queue9", qos: .userInitiated, attributes: .initiallyInactive)
        inactiveQueue = queue
        
        queue.async {
            for i in 0...9 {
                print("❤️ \(i)")
            }
        }
        
        queue.async {
            for i in 10...20 {
                print("💚 \(i)")
            }
        }
        
        queue.async {
            for i in 100...110 {
                print("🖤 \(i)")
            }
        }
        
    }
    
    func delayQueue() {
        
        let delayQueue = DispatchQueue(label: "com.codebit.queue10")
        
        let executeAfterTime: DispatchTimeInterval = .seconds(2)
        
        
        
        print(Date())
        
        delayQueue.asyncAfter(deadline: .now() + executeAfterTime) {
            
            for i in 100...110 {
                print("🖤 \(i)")
            }
            
            print(Date())
        }
    
        
    }
    
    func globalAndMainQueue() {
        
    
        let globalQueue = DispatchQueue.global()
    
        // Disaptch queue with QoS
         _ = DispatchQueue.global(qos: .userInitiated)
        
        globalQueue.async {
            
            // Accessing the main queue inside the background queue
            DispatchQueue.main.async {
                for i in 100...110 {
                    print("🖤 \(i)")
                }
            }
            
        }
    }
    
    func loadImageView() {
        
        let imageUrl = URL(string: "https://nintendoeverything.com/wp-content/uploads/zelda-breath-wild-3.jpg")
        
        
        // Creating self queue
        let backgroundQueue = DispatchQueue(label: "com.codebit.imageLoaderQueue")
        backgroundQueue.async {
            let image = NSImage(contentsOf: imageUrl!)
            
            // UI updation in main thread
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
        
        
        // Using system provided queue
        /*
        let session = URLSession(configuration: .default).dataTask(with: imageUrl!) { (data, response, error) in
            if error != nil {
                print(error!)
            } else {
                if let rawImageData = data, let image = NSImage(data: rawImageData) {
                    self.imageView.image = image
                }
            }
        }
        session.resume()
         */
        
        
        
    }
    
    func useWorkItem() {
        
        var value = 10
        
        let workItem = DispatchWorkItem {
            value += 5
        }
        
        workItem.perform()
        
        let queue = DispatchQueue.global(qos: .utility)
        
        queue.async(execute: workItem)
        
        workItem.notify(queue: DispatchQueue.main) { 
            print(value)
        }
        
        
    }
    
    
    
}

