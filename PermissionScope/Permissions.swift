//
//  Permissions.swift
//  PermissionScope
//
//  Created by Nick O'Neill on 8/25/15.
//  Copyright © 2015 That Thing in Swift. All rights reserved.
//

import Foundation
import CoreLocation
import AddressBook
import AVFoundation
import Photos
import EventKit
import CoreBluetooth
import CoreMotion
import CloudKit
import Accounts

/**
*  Protocol for permission configurations.
*/
@objc public protocol Permission {
    /// Permission type
    var type: PermissionType { get }
}

@objc public class NotificationsPermission: NSObject, Permission {
<<<<<<< HEAD
    public let type: PermissionType = .notifications
    public let notificationCategories: Set<UIUserNotificationCategory>?
    
    @objc
=======
    public let type: PermissionType = .Notifications
    public let notificationCategories: Set<UIUserNotificationCategory>?
    
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d
    public init(notificationCategories: Set<UIUserNotificationCategory>? = nil) {
        self.notificationCategories = notificationCategories
    }
}

@objc public class LocationWhileInUsePermission: NSObject, Permission {
<<<<<<< HEAD
    public let type: PermissionType = .locationInUse
}

@objc public class LocationAlwaysPermission: NSObject, Permission {
    public let type: PermissionType = .locationAlways
}

@objc public class ContactsPermission: NSObject, Permission {
    public let type: PermissionType = .contacts
=======
    public let type: PermissionType = .LocationInUse
}

@objc public class LocationAlwaysPermission: NSObject, Permission {
    public let type: PermissionType = .LocationAlways
}

@objc public class ContactsPermission: NSObject, Permission {
    public let type: PermissionType = .Contacts
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d
}

public typealias requestPermissionUnknownResult = () -> Void
public typealias requestPermissionShowAlert     = (PermissionType) -> Void

@objc public class EventsPermission: NSObject, Permission {
<<<<<<< HEAD
    public let type: PermissionType = .events
}

@objc public class MicrophonePermission: NSObject, Permission {
    public let type: PermissionType = .microphone
}

@objc public class CameraPermission: NSObject, Permission {
    public let type: PermissionType = .camera
}

@objc public class PhotosPermission: NSObject, Permission {
    public let type: PermissionType = .photos
}

@objc public class RemindersPermission: NSObject, Permission {
    public let type: PermissionType = .reminders
}

@objc public class BluetoothPermission: NSObject, Permission {
    public let type: PermissionType = .bluetooth
}

@objc public class MotionPermission: NSObject, Permission {
    public let type: PermissionType = .motion
=======
    public let type: PermissionType = .Events
}

@objc public class MicrophonePermission: NSObject, Permission {
    public let type: PermissionType = .Microphone
}

@objc public class CameraPermission: NSObject, Permission {
    public let type: PermissionType = .Camera
}

@objc public class PhotosPermission: NSObject, Permission {
    public let type: PermissionType = .Photos
}

@objc public class RemindersPermission: NSObject, Permission {
    public let type: PermissionType = .Reminders
}

@objc public class BluetoothPermission: NSObject, Permission {
    public let type: PermissionType = .Bluetooth
}

@objc public class MotionPermission: NSObject, Permission {
    public let type: PermissionType = .Motion
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d
}
