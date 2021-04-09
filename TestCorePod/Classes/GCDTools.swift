//
//  GCDTools.swift
//  TestCorePod
//
//  Created by douyu on 2021/4/9.
//

import Foundation

// MARK: 异步方法

/**
 主线程中延时处理

 - parameter delay:   延时时长，单位为秒
 - parameter closure: 处理代码
 */
func asyncAfter(_ delay: Double, closure: @escaping (() -> Void)) {
    DispatchQueue.main.asyncAfter(
        deadline: DispatchTime.now() + Double(delay), execute: closure
    )
}

/**
 在主线程的下一个Runloop中执行。

 - parameter closure: 处理代码
 */
func asyncExecInMainQueue(_ closure: @escaping (() -> Void)) {
    DispatchQueue.main.async(execute: closure)
}

/**
 在GlobalQueue中异步执行

 - parameter closure: 处理代码
 */
func asyncExecInGlobalQueue(_ closure: @escaping (() -> Void)) {
    DispatchQueue.global(qos: .default).async(execute: closure)
}

/**
 在指定queue中异步执行

 - parameter queue:   指定dispatch_queue_t
 - parameter closure: 处理代码
 */
func asyncExecInQueue(_ queue: DispatchQueue, closure: @escaping (() -> Void)) {
    queue.async(execute: closure)
}

// MARK: 同步方法

/**
 在指定queue中同步执行代码

 - parameter queue:   指定dispatch_queue_t
 - parameter closure: 处理代码
 */
func syncExecInQueue(_ queue: DispatchQueue, closure: () -> Void) {
    queue.sync(execute: closure)
}

/**
 在主线程中同步执行代码

 - parameter closure: 处理代码
 */
func syncExecInMainQueueSafely(_ closure: () -> Void) {
    if Thread.isMainThread {
        closure()
    } else {
        syncExecInQueue(DispatchQueue.main, closure: closure)
    }
}
