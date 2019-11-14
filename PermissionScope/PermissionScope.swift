//
//  PermissionScope.swift
//  PermissionScope
//
//  Created by Nick O'Neill on 4/5/15.
//  Copyright (c) 2015 That Thing in Swift. All rights reserved.
//

import UIKit
import CoreLocation
import AddressBook
import AVFoundation
import Photos
import EventKit
import CoreBluetooth
import CoreMotion
import Contacts

<<<<<<< HEAD
public typealias statusRequestClosure = (_ status: PermissionStatus) -> Void
public typealias authClosureType      = (_ finished: Bool, _ results: [PermissionResult]) -> Void
public typealias cancelClosureType    = (_ results: [PermissionResult]) -> Void
=======
public typealias statusRequestClosure = (status: PermissionStatus) -> Void
public typealias authClosureType      = (finished: Bool, results: [PermissionResult]) -> Void
public typealias cancelClosureType    = (results: [PermissionResult]) -> Void
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d
typealias resultsForConfigClosure     = ([PermissionResult]) -> Void

@objc public class PermissionScope: UIViewController, CLLocationManagerDelegate, UIGestureRecognizerDelegate, CBPeripheralManagerDelegate {

    // MARK: UI Parameters
    
    /// Header UILabel with the message "Hey, listen!" by default.
    public var headerLabel                 = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
    /// Header UILabel with the message "We need a couple things\r\nbefore you get started." by default.
    public var bodyLabel                   = UILabel(frame: CGRect(x: 0, y: 0, width: 240, height: 70))
    /// Color for the close button's text color.
    public var closeButtonTextColor        = UIColor(red: 0, green: 0.47, blue: 1, alpha: 1)
    /// Color for the permission buttons' text color.
    public var permissionButtonTextColor   = UIColor(red: 0, green: 0.47, blue: 1, alpha: 1)
    /// Color for the permission buttons' border color.
    public var permissionButtonBorderColor = UIColor(red: 0, green: 0.47, blue: 1, alpha: 1)
    /// Width for the permission buttons.
<<<<<<< HEAD
    public var permissionButtonBorderWidth  : CGFloat = 1
    /// Corner radius for the permission buttons.
    public var permissionButtonCornerRadius : CGFloat = 6
    /// Color for the permission labels' text color.
    public var permissionLabelColor:UIColor = .black
    /// Font used for all the UIButtons
    public var buttonFont:UIFont            = .boldSystemFont(ofSize: 14)
    /// Font used for all the UILabels
    public var labelFont:UIFont             = .systemFont(ofSize: 14)
    /// Close button. By default in the top right corner.
    public var closeButton                  = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 32))
    /// Offset used to position the Close button.
    public var closeOffset                  = CGSize.zero
=======
    public var permissionButtonΒorderWidth  : CGFloat = 1
    /// Corner radius for the permission buttons.
    public var permissionButtonCornerRadius : CGFloat = 6
    /// Color for the permission labels' text color.
    public var permissionLabelColor:UIColor = .blackColor()
    /// Font used for all the UIButtons
    public var buttonFont:UIFont            = .boldSystemFontOfSize(14)
    /// Font used for all the UILabels
    public var labelFont:UIFont             = .systemFontOfSize(14)
    /// Close button. By default in the top right corner.
    public var closeButton                  = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 32))
    /// Offset used to position the Close button.
    public var closeOffset                  = CGSizeZero
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d
    /// Color used for permission buttons with authorized status
    public var authorizedButtonColor        = UIColor(red: 0, green: 0.47, blue: 1, alpha: 1)
    /// Color used for permission buttons with unauthorized status. By default, inverse of `authorizedButtonColor`.
    public var unauthorizedButtonColor:UIColor?
    /// Messages for the body label of the dialog presented when requesting access.
    lazy var permissionMessages: [PermissionType : String] = [PermissionType : String]()
    
    // MARK: View hierarchy for custom alert
    let baseView    = UIView()
    public let contentView = UIView()

    // MARK: - Various lazy managers
    lazy var locationManager:CLLocationManager = {
        let lm = CLLocationManager()
        lm.delegate = self
        return lm
    }()

    lazy var bluetoothManager:CBPeripheralManager = {
        return CBPeripheralManager(delegate: self, queue: nil, options:[CBPeripheralManagerOptionShowPowerAlertKey: false])
    }()
    
    lazy var motionManager:CMMotionActivityManager = {
        return CMMotionActivityManager()
    }()
    
    /// NSUserDefaults standardDefaults lazy var
<<<<<<< HEAD
    lazy var defaults:UserDefaults = {
        return .standard
    }()
    
    /// Default status for Core Motion Activity
    var motionPermissionStatus: PermissionStatus = .unknown
=======
    lazy var defaults:NSUserDefaults = {
        return .standardUserDefaults()
    }()
    
    /// Default status for Core Motion Activity
    var motionPermissionStatus: PermissionStatus = .Unknown
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d

    // MARK: - Internal state and resolution
    
    /// Permissions configured using `addPermission(:)`
    var configuredPermissions: [Permission] = []
    var permissionButtons: [UIButton]       = []
    var permissionLabels: [UILabel]         = []
	
	// Useful for direct use of the request* methods
    
    /// Callback called when permissions status change.
    public var onAuthChange: authClosureType? = nil
    /// Callback called when the user taps on the close button.
    public var onCancel: cancelClosureType?   = nil
    
    /// Called when the user has disabled or denied access to notifications, and we're presenting them with a help dialog.
    public var onDisabledOrDenied: cancelClosureType? = nil
	/// View controller to be used when presenting alerts. Defaults to self. You'll want to set this if you are calling the `request*` methods directly.
	public var viewControllerForAlerts : UIViewController?

    /**
    Checks whether all the configured permission are authorized or not.
    
    - parameter completion: Closure used to send the result of the check.
    */
<<<<<<< HEAD
    func allAuthorized(_ completion: @escaping (Bool) -> Void ) {
        getResultsForConfig{ results in
            let result = results
                .first { $0.status != .authorized }
=======
    func allAuthorized(completion: (Bool) -> Void ) {
        getResultsForConfig{ results in
            let result = results
                .first { $0.status != .Authorized }
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d
                .isNil
            completion(result)
        }
    }
    
    /**
    Checks whether all the required configured permission are authorized or not.
    **Deprecated** See issues #50 and #51.
    
    - parameter completion: Closure used to send the result of the check.
    */
<<<<<<< HEAD
    func requiredAuthorized(_ completion: @escaping (Bool) -> Void ) {
        getResultsForConfig{ results in
            let result = results
                .first { $0.status != .authorized }
=======
    func requiredAuthorized(completion: (Bool) -> Void ) {
        getResultsForConfig{ results in
            let result = results
                .first { $0.status != .Authorized }
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d
                .isNil
            completion(result)
        }
    }
    
    // use the code we have to see permission status
<<<<<<< HEAD
    public func permissionStatuses(_ permissionTypes: [PermissionType]?) -> Dictionary<PermissionType, PermissionStatus> {
=======
    public func permissionStatuses(permissionTypes: [PermissionType]?) -> Dictionary<PermissionType, PermissionStatus> {
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d
        var statuses: Dictionary<PermissionType, PermissionStatus> = [:]
        let types: [PermissionType] = permissionTypes ?? PermissionType.allValues
        
        for type in types {
            statusForPermission(type, completion: { status in
                statuses[type] = status
            })
        }
        
        return statuses
    }
    
    /**
    Designated initializer.
    
    - parameter backgroundTapCancels: True if a tap on the background should trigger the dialog dismissal.
    */
    public init(backgroundTapCancels: Bool) {
        super.init(nibName: nil, bundle: nil)

		viewControllerForAlerts = self
		
        // Set up main view
<<<<<<< HEAD
        view.frame = UIScreen.main.bounds
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleHeight, UIView.AutoresizingMask.flexibleWidth]
=======
        view.frame = UIScreen.mainScreen().bounds
        view.autoresizingMask = [UIViewAutoresizing.FlexibleHeight, UIViewAutoresizing.FlexibleWidth]
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d
        view.backgroundColor = UIColor(red:0, green:0, blue:0, alpha:0.7)
        view.addSubview(baseView)
        // Base View
        baseView.frame = view.frame
        baseView.addSubview(contentView)
        if backgroundTapCancels {
            let tap = UITapGestureRecognizer(target: self, action: #selector(cancel))
            tap.delegate = self
            baseView.addGestureRecognizer(tap)
        }
        // Content View
<<<<<<< HEAD
        contentView.backgroundColor = UIColor.white
=======
        contentView.backgroundColor = UIColor.whiteColor()
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        contentView.layer.borderWidth = 0.5

        // header label
<<<<<<< HEAD
        headerLabel.font = UIFont.systemFont(ofSize: 22)
        headerLabel.textColor = UIColor.black
        headerLabel.textAlignment = NSTextAlignment.center
        headerLabel.text = "Hey, listen!".localized
        headerLabel.accessibilityIdentifier = "permissionscope.headerlabel"
=======
        headerLabel.font = UIFont.systemFontOfSize(22)
        headerLabel.textColor = UIColor.blackColor()
        headerLabel.textAlignment = NSTextAlignment.Center
        headerLabel.text = "Hey, listen!".localized
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d

        contentView.addSubview(headerLabel)

        // body label
<<<<<<< HEAD
        bodyLabel.font = UIFont.boldSystemFont(ofSize: 16)
        bodyLabel.textColor = UIColor.black
        bodyLabel.textAlignment = NSTextAlignment.center
        bodyLabel.text = "We need a couple things\r\nbefore you get started.".localized
        bodyLabel.numberOfLines = 2
        bodyLabel.accessibilityIdentifier = "permissionscope.bodylabel"
=======
        bodyLabel.font = UIFont.boldSystemFontOfSize(16)
        bodyLabel.textColor = UIColor.blackColor()
        bodyLabel.textAlignment = NSTextAlignment.Center
        bodyLabel.text = "We need a couple things\r\nbefore you get started.".localized
        bodyLabel.numberOfLines = 2
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d

        contentView.addSubview(bodyLabel)
        
        // close button
<<<<<<< HEAD
        closeButton.setTitle("Close".localized, for: .normal)
        closeButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        closeButton.accessibilityIdentifier = "permissionscope.closeButton"
        
        contentView.addSubview(closeButton)
        
        _ = self.statusMotion() //Added to check motion status on load
=======
        closeButton.setTitle("Close".localized, forState: .Normal)
        closeButton.addTarget(self, action: #selector(cancel), forControlEvents: .TouchUpInside)
        
        contentView.addSubview(closeButton)
        
        self.statusMotion() //Added to check motion status on load
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d
    }
    
    /**
    Convenience initializer. Same as `init(backgroundTapCancels: true)`
    */
    public convenience init() {
        self.init(backgroundTapCancels: true)
    }

    required public init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

<<<<<<< HEAD
    override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName:nibNameOrNil, bundle:nibBundleOrNil)
    }

    override public func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let screenSize = UIScreen.main.bounds.size
=======
    override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName:nibNameOrNil, bundle:nibBundleOrNil)
    }

    public override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let screenSize = UIScreen.mainScreen().bounds.size
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d
        // Set background frame
        view.frame.size = screenSize
        // Set frames
        let x = (screenSize.width - Constants.UI.contentWidth) / 2

        let dialogHeight: CGFloat
        switch self.configuredPermissions.count {
        case 2:
            dialogHeight = Constants.UI.dialogHeightTwoPermissions
        case 3:
            dialogHeight = Constants.UI.dialogHeightThreePermissions
        default:
            dialogHeight = Constants.UI.dialogHeightSinglePermission
        }
        
        let y = (screenSize.height - dialogHeight) / 2
        contentView.frame = CGRect(x:x, y:y, width:Constants.UI.contentWidth, height:dialogHeight)

        // offset the header from the content center, compensate for the content's offset
        headerLabel.center = contentView.center
        headerLabel.frame.offsetInPlace(dx: -contentView.frame.origin.x, dy: -contentView.frame.origin.y)
        headerLabel.frame.offsetInPlace(dx: 0, dy: -((dialogHeight/2)-50))

        // ... same with the body
        bodyLabel.center = contentView.center
        bodyLabel.frame.offsetInPlace(dx: -contentView.frame.origin.x, dy: -contentView.frame.origin.y)
        bodyLabel.frame.offsetInPlace(dx: 0, dy: -((dialogHeight/2)-100))
        
        closeButton.center = contentView.center
        closeButton.frame.offsetInPlace(dx: -contentView.frame.origin.x, dy: -contentView.frame.origin.y)
        closeButton.frame.offsetInPlace(dx: 105, dy: -((dialogHeight/2)-20))
        closeButton.frame.offsetInPlace(dx: self.closeOffset.width, dy: self.closeOffset.height)
        if let _ = closeButton.imageView?.image {
<<<<<<< HEAD
            closeButton.setTitle("", for: .normal)
        }
        closeButton.setTitleColor(closeButtonTextColor, for: .normal)
=======
            closeButton.setTitle("", forState: .Normal)
        }
        closeButton.setTitleColor(closeButtonTextColor, forState: .Normal)
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d

        let baseOffset = 95
        var index = 0
        for button in permissionButtons {
            button.center = contentView.center
            button.frame.offsetInPlace(dx: -contentView.frame.origin.x, dy: -contentView.frame.origin.y)
            button.frame.offsetInPlace(dx: 0, dy: -((dialogHeight/2)-160) + CGFloat(index * baseOffset))
            
            let type = configuredPermissions[index].type
            
            statusForPermission(type,
                completion: { currentStatus in
                    let prettyDescription = type.prettyDescription
<<<<<<< HEAD
                    if currentStatus == .authorized {
                        self.setButtonAuthorizedStyle(button)
                        button.setTitle(String(format: "Allowed (prettyDescription)".localized,prettyDescription).uppercased(), for: .normal)
                    } else if currentStatus == .unauthorized {
                        self.setButtonUnauthorizedStyle(button)
                        button.setTitle(String(format: "Denied (prettyDescription)".localized,prettyDescription).uppercased(), for: .normal)
                    } else if currentStatus == .disabled {
                        //                setButtonDisabledStyle(button)
                        button.setTitle(String(format: "(prettyDescription) Disabled".localized,prettyDescription).uppercased(), for: .normal)
=======
                    if currentStatus == .Authorized {
                        self.setButtonAuthorizedStyle(button)
                        button.setTitle("Allowed \(prettyDescription)".localized.uppercaseString, forState: .Normal)
                    } else if currentStatus == .Unauthorized {
                        self.setButtonUnauthorizedStyle(button)
                        button.setTitle("Denied \(prettyDescription)".localized.uppercaseString, forState: .Normal)
                    } else if currentStatus == .Disabled {
                        //                setButtonDisabledStyle(button)
                        button.setTitle("\(prettyDescription) Disabled".localized.uppercaseString, forState: .Normal)
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d
                    }
                    
                    let label = self.permissionLabels[index]
                    label.center = self.contentView.center
                    label.frame.offsetInPlace(dx: -self.contentView.frame.origin.x, dy: -self.contentView.frame.origin.y)
                    label.frame.offsetInPlace(dx: 0, dy: -((dialogHeight/2)-205) + CGFloat(index * baseOffset))
                    
                    index = index + 1
            })
        }
    }

    // MARK: - Customizing the permissions
    
    /**
    Adds a permission configuration to PermissionScope.
    
    - parameter config: Configuration for a specific permission.
    - parameter message: Body label's text on the presented dialog when requesting access.
    */
<<<<<<< HEAD
    @objc public func addPermission(_ permission: Permission, message: String) {
=======
    @objc public func addPermission(permission: Permission, message: String) {
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d
        assert(!message.isEmpty, "Including a message about your permission usage is helpful")
        assert(configuredPermissions.count < 3, "Ask for three or fewer permissions at a time")
        assert(configuredPermissions.first { $0.type == permission.type }.isNil, "Permission for \(permission.type) already set")
        
        configuredPermissions.append(permission)
        permissionMessages[permission.type] = message
        
<<<<<<< HEAD
        if permission.type == .bluetooth && askedBluetooth {
            triggerBluetoothStatusUpdate()
        } else if permission.type == .motion && askedMotion {
=======
        if permission.type == .Bluetooth && askedBluetooth {
            triggerBluetoothStatusUpdate()
        } else if permission.type == .Motion && askedMotion {
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d
            triggerMotionStatusUpdate()
        }
    }

    /**
    Permission button factory. Uses the custom style parameters such as `permissionButtonTextColor`, `buttonFont`, etc.
    
    - parameter type: Permission type
    
    - returns: UIButton instance with a custom style.
    */
<<<<<<< HEAD
    func permissionStyledButton(_ type: PermissionType) -> UIButton {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 220, height: 40))
        button.setTitleColor(permissionButtonTextColor, for: .normal)
        button.titleLabel?.font = buttonFont

        button.layer.borderWidth = permissionButtonBorderWidth
        button.layer.borderColor = permissionButtonBorderColor.cgColor
=======
    func permissionStyledButton(type: PermissionType) -> UIButton {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 220, height: 40))
        button.setTitleColor(permissionButtonTextColor, forState: .Normal)
        button.titleLabel?.font = buttonFont

        button.layer.borderWidth = permissionButtonΒorderWidth
        button.layer.borderColor = permissionButtonBorderColor.CGColor
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d
        button.layer.cornerRadius = permissionButtonCornerRadius

        // this is a bit of a mess, eh?
        switch type {
<<<<<<< HEAD
        case .locationAlways, .locationInUse:
            button.setTitle( String(format: "Enable (prettyDescription)".localized,type.prettyDescription).uppercased(), for: .normal)
        default:
            button.setTitle( String(format: "Allow (type)".localized,type.prettyDescription).uppercased(), for: .normal)
        }
        
        button.addTarget(self, action: Selector("request\(type)"), for: .touchUpInside)

        button.accessibilityIdentifier = "permissionscope.button.\(type)".lowercased()
=======
        case .LocationAlways, .LocationInUse:
            button.setTitle("Enable \(type.prettyDescription)".localized.uppercaseString, forState: .Normal)
        default:
            button.setTitle("Allow \(type)".localized.uppercaseString, forState: .Normal)
        }
        
        button.addTarget(self, action: Selector("request\(type)"), forControlEvents: .TouchUpInside)
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d
        
        return button
    }

    /**
    Sets the style for permission buttons with authorized status.
    
    - parameter button: Permission button
    */
<<<<<<< HEAD
    func setButtonAuthorizedStyle(_ button: UIButton) {
        button.layer.borderWidth = 0
        button.backgroundColor = authorizedButtonColor
        button.setTitleColor(.white, for: .normal)
=======
    func setButtonAuthorizedStyle(button: UIButton) {
        button.layer.borderWidth = 0
        button.backgroundColor = authorizedButtonColor
        button.setTitleColor(.whiteColor(), forState: .Normal)
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d
    }
    
    /**
    Sets the style for permission buttons with unauthorized status.
    
    - parameter button: Permission button
    */
<<<<<<< HEAD
    func setButtonUnauthorizedStyle(_ button: UIButton) {
        button.layer.borderWidth = 0
        button.backgroundColor = unauthorizedButtonColor ?? authorizedButtonColor.inverseColor
        button.setTitleColor(.white, for: .normal)
=======
    func setButtonUnauthorizedStyle(button: UIButton) {
        button.layer.borderWidth = 0
        button.backgroundColor = unauthorizedButtonColor ?? authorizedButtonColor.inverseColor
        button.setTitleColor(.whiteColor(), forState: .Normal)
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d
    }

    /**
    Permission label factory, located below the permission buttons.
    
    - parameter type: Permission type
    
    - returns: UILabel instance with a custom style.
    */
<<<<<<< HEAD
    func permissionStyledLabel(_ type: PermissionType) -> UILabel {
        let label  = UILabel(frame: CGRect(x: 0, y: 0, width: 260, height: 50))
        label.font = labelFont
        label.numberOfLines = 2
        label.textAlignment = .center
=======
    func permissionStyledLabel(type: PermissionType) -> UILabel {
        let label  = UILabel(frame: CGRect(x: 0, y: 0, width: 260, height: 50))
        label.font = labelFont
        label.numberOfLines = 2
        label.textAlignment = .Center
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d
        label.text = permissionMessages[type]
        label.textColor = permissionLabelColor
        
        return label
    }

    // MARK: - Status and Requests for each permission
    
    // MARK: Location
    
    /**
    Returns the current permission status for accessing LocationAlways.
    
    - returns: Permission status for the requested type.
    */
    public func statusLocationAlways() -> PermissionStatus {
<<<<<<< HEAD
        guard CLLocationManager.locationServicesEnabled() else { return .disabled }

        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .authorizedAlways:
            return .authorized
        case .restricted, .denied:
            return .unauthorized
        case .authorizedWhenInUse:
            // Curious why this happens? Details on upgrading from WhenInUse to Always:
            // [Check this issue](https://github.com/nickoneill/PermissionScope/issues/24)
            if defaults.bool(forKey: Constants.NSUserDefaultsKeys.requestedInUseToAlwaysUpgrade) {
                return .unauthorized
            } else {
                return .unknown
            }
        case .notDetermined:
            return .unknown
        @unknown default:
            fatalError()
=======
        guard CLLocationManager.locationServicesEnabled() else { return .Disabled }

        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .AuthorizedAlways:
            return .Authorized
        case .Restricted, .Denied:
            return .Unauthorized
        case .AuthorizedWhenInUse:
            // Curious why this happens? Details on upgrading from WhenInUse to Always:
            // [Check this issue](https://github.com/nickoneill/PermissionScope/issues/24)
            if defaults.boolForKey(Constants.NSUserDefaultsKeys.requestedInUseToAlwaysUpgrade) {
                return .Unauthorized
            } else {
                return .Unknown
            }
        case .NotDetermined:
            return .Unknown
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d
        }
    }

    /**
    Requests access to LocationAlways, if necessary.
    */
<<<<<<< HEAD
    @objc
    public func requestLocationAlways() {
    	let hasAlwaysKey:Bool = !Bundle.main
    		.object(forInfoDictionaryKey: Constants.InfoPlistKeys.locationAlways).isNil
=======
    public func requestLocationAlways() {
    	let hasAlwaysKey:Bool = !NSBundle.mainBundle()
    		.objectForInfoDictionaryKey(Constants.InfoPlistKeys.locationAlways).isNil
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d
    	assert(hasAlwaysKey, Constants.InfoPlistKeys.locationAlways + " not found in Info.plist.")
    	
        let status = statusLocationAlways()
        switch status {
<<<<<<< HEAD
        case .unknown:
            if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
                defaults.set(true, forKey: Constants.NSUserDefaultsKeys.requestedInUseToAlwaysUpgrade)
                defaults.synchronize()
            }
            locationManager.requestAlwaysAuthorization()
        case .unauthorized:
            self.showDeniedAlert(.locationAlways)
        case .disabled:
            self.showDisabledAlert(.locationInUse)
=======
        case .Unknown:
            if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
                defaults.setBool(true, forKey: Constants.NSUserDefaultsKeys.requestedInUseToAlwaysUpgrade)
                defaults.synchronize()
            }
            locationManager.requestAlwaysAuthorization()
        case .Unauthorized:
            self.showDeniedAlert(.LocationAlways)
        case .Disabled:
            self.showDisabledAlert(.LocationInUse)
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d
        default:
            break
        }
    }

    /**
    Returns the current permission status for accessing LocationWhileInUse.
    
    - returns: Permission status for the requested type.
    */
    public func statusLocationInUse() -> PermissionStatus {
<<<<<<< HEAD
        guard CLLocationManager.locationServicesEnabled() else { return .disabled }
=======
        guard CLLocationManager.locationServicesEnabled() else { return .Disabled }
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d
        
        let status = CLLocationManager.authorizationStatus()
        // if you're already "always" authorized, then you don't need in use
        // but the user can still demote you! So I still use them separately.
        switch status {
<<<<<<< HEAD
        case .authorizedWhenInUse, .authorizedAlways:
            return .authorized
        case .restricted, .denied:
            return .unauthorized
        case .notDetermined:
            return .unknown
        @unknown default:
            fatalError()
=======
        case .AuthorizedWhenInUse, .AuthorizedAlways:
            return .Authorized
        case .Restricted, .Denied:
            return .Unauthorized
        case .NotDetermined:
            return .Unknown
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d
        }
    }

    /**
    Requests access to LocationWhileInUse, if necessary.
    */
<<<<<<< HEAD
    @objc
    public func requestLocationInUse() {
    	let hasWhenInUseKey :Bool = !Bundle.main
    		.object(forInfoDictionaryKey: Constants.InfoPlistKeys.locationWhenInUse).isNil
=======
    public func requestLocationInUse() {
    	let hasWhenInUseKey :Bool = !NSBundle.mainBundle()
    		.objectForInfoDictionaryKey(Constants.InfoPlistKeys.locationWhenInUse).isNil
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d
    	assert(hasWhenInUseKey, Constants.InfoPlistKeys.locationWhenInUse + " not found in Info.plist.")
    	
        let status = statusLocationInUse()
        switch status {
<<<<<<< HEAD
        case .unknown:
            locationManager.requestWhenInUseAuthorization()
        case .unauthorized:
            self.showDeniedAlert(.locationInUse)
        case .disabled:
            self.showDisabledAlert(.locationInUse)
=======
        case .Unknown:
            locationManager.requestWhenInUseAuthorization()
        case .Unauthorized:
            self.showDeniedAlert(.LocationInUse)
        case .Disabled:
            self.showDisabledAlert(.LocationInUse)
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d
        default:
            break
        }
    }

    // MARK: Contacts
    
    /**
    Returns the current permission status for accessing Contacts.
    
    - returns: Permission status for the requested type.
    */
    public func statusContacts() -> PermissionStatus {
        if #available(iOS 9.0, *) {
<<<<<<< HEAD
            let status = CNContactStore.authorizationStatus(for: .contacts)
            switch status {
            case .authorized:
                return .authorized
            case .restricted, .denied:
                return .unauthorized
            case .notDetermined:
                return .unknown
            @unknown default:
                fatalError()
=======
            let status = CNContactStore.authorizationStatusForEntityType(.Contacts)
            switch status {
            case .Authorized:
                return .Authorized
            case .Restricted, .Denied:
                return .Unauthorized
            case .NotDetermined:
                return .Unknown
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d
            }
        } else {
            // Fallback on earlier versions
            let status = ABAddressBookGetAuthorizationStatus()
            switch status {
<<<<<<< HEAD
            case .authorized:
                return .authorized
            case .restricted, .denied:
                return .unauthorized
            case .notDetermined:
                return .unknown
            @unknown default:
                fatalError()
=======
            case .Authorized:
                return .Authorized
            case .Restricted, .Denied:
                return .Unauthorized
            case .NotDetermined:
                return .Unknown
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d
            }
        }
    }

    /**
    Requests access to Contacts, if necessary.
    */
<<<<<<< HEAD
    @objc
    public func requestContacts() {
        let status = statusContacts()
        switch status {
        case .unknown:
            if #available(iOS 9.0, *) {
                CNContactStore().requestAccess(for: .contacts, completionHandler: {
=======
    public func requestContacts() {
        let status = statusContacts()
        switch status {
        case .Unknown:
            if #available(iOS 9.0, *) {
                CNContactStore().requestAccessForEntityType(.Contacts, completionHandler: {
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d
                    success, error in
                    self.detectAndCallback()
                })
            } else {
                ABAddressBookRequestAccessWithCompletion(nil) { success, error in
                    self.detectAndCallback()
                }
            }
<<<<<<< HEAD
        case .unauthorized:
            self.showDeniedAlert(.contacts)
=======
        case .Unauthorized:
            self.showDeniedAlert(.Contacts)
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d
        default:
            break
        }
    }

    // MARK: Notifications
    
    /**
    Returns the current permission status for accessing Notifications.
    
    - returns: Permission status for the requested type.
    */
    public func statusNotifications() -> PermissionStatus {
<<<<<<< HEAD
        let settings = UIApplication.shared.currentUserNotificationSettings
        if let settingTypes = settings?.types , settingTypes != UIUserNotificationType() {
            return .authorized
        } else {
            if defaults.bool(forKey: Constants.NSUserDefaultsKeys.requestedNotifications) {
                return .unauthorized
            } else {
                return .unknown
=======
        let settings = UIApplication.sharedApplication().currentUserNotificationSettings()
        if let settingTypes = settings?.types where settingTypes != .None {
            return .Authorized
        } else {
            if defaults.boolForKey(Constants.NSUserDefaultsKeys.requestedNotifications) {
                return .Unauthorized
            } else {
                return .Unknown
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d
            }
        }
    }
    
    /**
    To simulate the denied status for a notifications permission,
    we track when the permission has been asked for and then detect
    when the app becomes active again. If the permission is not granted
    immediately after becoming active, the user has cancelled or denied
    the request.
    
    This function is called when we want to show the notifications
    alert, kicking off the entire process.
    */
<<<<<<< HEAD
    @objc func showingNotificationPermission() {
        let notifCenter = NotificationCenter.default
        
        notifCenter
            .removeObserver(self,
                            name: UIApplication.willResignActiveNotification,
=======
    func showingNotificationPermission() {
        let notifCenter = NSNotificationCenter.defaultCenter()
        
        notifCenter
            .removeObserver(self,
                            name: UIApplicationWillResignActiveNotification,
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d
                            object: nil)
        notifCenter
            .addObserver(self,
                         selector: #selector(finishedShowingNotificationPermission),
<<<<<<< HEAD
                         name: UIApplication.didBecomeActiveNotification, object: nil)
=======
                         name: UIApplicationDidBecomeActiveNotification, object: nil)
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d
        notificationTimer?.invalidate()
    }
    
    /**
    A timer that fires the event to let us know the user has asked for 
    notifications permission.
    */
<<<<<<< HEAD
    var notificationTimer : Timer?
=======
    var notificationTimer : NSTimer?
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d

    /**
    This function is triggered when the app becomes 'active' again after
    showing the notification permission dialog.
    
    See `showingNotificationPermission` for a more detailed description
    of the entire process.
    */
<<<<<<< HEAD
    @objc func finishedShowingNotificationPermission () {
        NotificationCenter.default.removeObserver(self,
                                                  name: UIApplication.willResignActiveNotification,
            object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIApplication.didBecomeActiveNotification,
=======
    func finishedShowingNotificationPermission () {
        NSNotificationCenter.defaultCenter().removeObserver(self,
            name: UIApplicationWillResignActiveNotification,
            object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self,
            name: UIApplicationDidBecomeActiveNotification,
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d
            object: nil)
        
        notificationTimer?.invalidate()
        
<<<<<<< HEAD
        defaults.set(true, forKey: Constants.NSUserDefaultsKeys.requestedNotifications)
        defaults.synchronize()

        // callback after a short delay, otherwise notifications don't report proper auth
        DispatchQueue.main.asyncAfter(
            deadline: .now() + .milliseconds(100),
            execute: {
            self.getResultsForConfig { results in
                guard let notificationResult = results.first(where: { $0.type == .notifications })
                    else { return }
                if notificationResult.status == .unknown {
=======
        defaults.setBool(true, forKey: Constants.NSUserDefaultsKeys.requestedNotifications)
        defaults.synchronize()

        // callback after a short delay, otherwise notifications don't report proper auth
        dispatch_after(
            dispatch_time(DISPATCH_TIME_NOW,Int64(0.1 * Double(NSEC_PER_SEC))),
            dispatch_get_main_queue(), {
            self.getResultsForConfig { results in
                guard let notificationResult = results
                    .first({ $0.type == .Notifications }) else { return }
                if notificationResult.status == .Unknown {
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d
                    self.showDeniedAlert(notificationResult.type)
                } else {
                    self.detectAndCallback()
                }
            }
        })
    }
    
    /**
    Requests access to User Notifications, if necessary.
    */
<<<<<<< HEAD
    @objc
    public func requestNotifications() {
        let status = statusNotifications()
        switch status {
        case .unknown:
=======
    public func requestNotifications() {
        let status = statusNotifications()
        switch status {
        case .Unknown:
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d
            let notificationsPermission = self.configuredPermissions
                .first { $0 is NotificationsPermission } as? NotificationsPermission
            let notificationsPermissionSet = notificationsPermission?.notificationCategories

<<<<<<< HEAD
            NotificationCenter.default.addObserver(self, selector: #selector(showingNotificationPermission), name: UIApplication.willResignActiveNotification, object: nil)
            
            notificationTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(finishedShowingNotificationPermission), userInfo: nil, repeats: false)
            
            UIApplication.shared.registerUserNotificationSettings(
                UIUserNotificationSettings(types: [.alert, .sound, .badge],
                categories: notificationsPermissionSet)
            )
        case .unauthorized:
            showDeniedAlert(.notifications)
        case .disabled:
            showDisabledAlert(.notifications)
        case .authorized:
=======
            NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(showingNotificationPermission), name: UIApplicationWillResignActiveNotification, object: nil)
            
            notificationTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(finishedShowingNotificationPermission), userInfo: nil, repeats: false)
            
            UIApplication.sharedApplication().registerUserNotificationSettings(
                UIUserNotificationSettings(forTypes: [.Alert, .Sound, .Badge],
                categories: notificationsPermissionSet)
            )
        case .Unauthorized:
            showDeniedAlert(.Notifications)
        case .Disabled:
            showDisabledAlert(.Notifications)
        case .Authorized:
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d
            detectAndCallback()
        }
    }
    
    // MARK: Microphone
    
    /**
    Returns the current permission status for accessing the Microphone.
    
    - returns: Permission status for the requested type.
    */
    public func statusMicrophone() -> PermissionStatus {
<<<<<<< HEAD
        let recordPermission = AVAudioSession.sharedInstance().recordPermission
        switch recordPermission {
        case AVAudioSessionRecordPermission.denied:
            return .unauthorized
        case AVAudioSessionRecordPermission.granted:
            return .authorized
        default:
            return .unknown
=======
        let recordPermission = AVAudioSession.sharedInstance().recordPermission()
        switch recordPermission {
        case AVAudioSessionRecordPermission.Denied:
            return .Unauthorized
        case AVAudioSessionRecordPermission.Granted:
            return .Authorized
        default:
            return .Unknown
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d
        }
    }
    
    /**
    Requests access to the Microphone, if necessary.
    */
<<<<<<< HEAD
    @objc
    public func requestMicrophone() {
        let status = statusMicrophone()
        switch status {
        case .unknown:
            AVAudioSession.sharedInstance().requestRecordPermission({ granted in
                self.detectAndCallback()
            })
        case .unauthorized:
            showDeniedAlert(.microphone)
        case .disabled:
            showDisabledAlert(.microphone)
        case .authorized:
=======
    public func requestMicrophone() {
        let status = statusMicrophone()
        switch status {
        case .Unknown:
            AVAudioSession.sharedInstance().requestRecordPermission({ granted in
                self.detectAndCallback()
            })
        case .Unauthorized:
            showDeniedAlert(.Microphone)
        case .Disabled:
            showDisabledAlert(.Microphone)
        case .Authorized:
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d
            break
        }
    }
    
    // MARK: Camera
    
    /**
    Returns the current permission status for accessing the Camera.
    
    - returns: Permission status for the requested type.
    */
    public func statusCamera() -> PermissionStatus {
<<<<<<< HEAD
        let status = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        switch status {
        case .authorized:
            return .authorized
        case .restricted, .denied:
            return .unauthorized
        case .notDetermined:
            return .unknown
        @unknown default:
            fatalError()
=======
        let status = AVCaptureDevice.authorizationStatusForMediaType(AVMediaTypeVideo)
        switch status {
        case .Authorized:
            return .Authorized
        case .Restricted, .Denied:
            return .Unauthorized
        case .NotDetermined:
            return .Unknown
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d
        }
    }
    
    /**
    Requests access to the Camera, if necessary.
    */
<<<<<<< HEAD
    @objc
    public func requestCamera() {
        let status = statusCamera()
        switch status {
        case .unknown:
            AVCaptureDevice.requestAccess(for: AVMediaType.video,
                completionHandler: { granted in
                    self.detectAndCallback()
            })
        case .unauthorized:
            showDeniedAlert(.camera)
        case .disabled:
            showDisabledAlert(.camera)
        case .authorized:
=======
    public func requestCamera() {
        let status = statusCamera()
        switch status {
        case .Unknown:
            AVCaptureDevice.requestAccessForMediaType(AVMediaTypeVideo,
                completionHandler: { granted in
                    self.detectAndCallback()
            })
        case .Unauthorized:
            showDeniedAlert(.Camera)
        case .Disabled:
            showDisabledAlert(.Camera)
        case .Authorized:
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d
            break
        }
    }

    // MARK: Photos
    
    /**
    Returns the current permission status for accessing Photos.
    
    - returns: Permission status for the requested type.
    */
    public func statusPhotos() -> PermissionStatus {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
<<<<<<< HEAD
        case .authorized:
            return .authorized
        case .denied, .restricted:
            return .unauthorized
        case .notDetermined:
            return .unknown
        @unknown default:
            fatalError()
=======
        case .Authorized:
            return .Authorized
        case .Denied, .Restricted:
            return .Unauthorized
        case .NotDetermined:
            return .Unknown
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d
        }
    }
    
    /**
    Requests access to Photos, if necessary.
    */
<<<<<<< HEAD
    @objc
    public func requestPhotos() {
        let status = statusPhotos()
        switch status {
        case .unknown:
            PHPhotoLibrary.requestAuthorization({ status in
                self.detectAndCallback()
            })
        case .unauthorized:
            self.showDeniedAlert(.photos)
        case .disabled:
            showDisabledAlert(.photos)
        case .authorized:
=======
    public func requestPhotos() {
        let status = statusPhotos()
        switch status {
        case .Unknown:
            PHPhotoLibrary.requestAuthorization({ status in
                self.detectAndCallback()
            })
        case .Unauthorized:
            self.showDeniedAlert(.Photos)
        case .Disabled:
            showDisabledAlert(.Photos)
        case .Authorized:
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d
            break
        }
    }
    
    // MARK: Reminders
    
    /**
    Returns the current permission status for accessing Reminders.
    
    - returns: Permission status for the requested type.
    */
    public func statusReminders() -> PermissionStatus {
<<<<<<< HEAD
        let status = EKEventStore.authorizationStatus(for: .reminder)
        switch status {
        case .authorized:
            return .authorized
        case .restricted, .denied:
            return .unauthorized
        case .notDetermined:
            return .unknown
        @unknown default:
            fatalError()
=======
        let status = EKEventStore.authorizationStatusForEntityType(.Reminder)
        switch status {
        case .Authorized:
            return .Authorized
        case .Restricted, .Denied:
            return .Unauthorized
        case .NotDetermined:
            return .Unknown
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d
        }
    }
    
    /**
    Requests access to Reminders, if necessary.
    */
<<<<<<< HEAD
    @objc
    public func requestReminders() {
        let status = statusReminders()
        switch status {
        case .unknown:
            EKEventStore().requestAccess(to: .reminder,
                completion: { granted, error in
                    self.detectAndCallback()
            })
        case .unauthorized:
            self.showDeniedAlert(.reminders)
=======
    public func requestReminders() {
        let status = statusReminders()
        switch status {
        case .Unknown:
            EKEventStore().requestAccessToEntityType(.Reminder,
                completion: { granted, error in
                    self.detectAndCallback()
            })
        case .Unauthorized:
            self.showDeniedAlert(.Reminders)
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d
        default:
            break
        }
    }
    
    // MARK: Events
    
    /**
    Returns the current permission status for accessing Events.
    
    - returns: Permission status for the requested type.
    */
    public func statusEvents() -> PermissionStatus {
<<<<<<< HEAD
        let status = EKEventStore.authorizationStatus(for: .event)
        switch status {
        case .authorized:
            return .authorized
        case .restricted, .denied:
            return .unauthorized
        case .notDetermined:
            return .unknown
        @unknown default:
            fatalError()
=======
        let status = EKEventStore.authorizationStatusForEntityType(.Event)
        switch status {
        case .Authorized:
            return .Authorized
        case .Restricted, .Denied:
            return .Unauthorized
        case .NotDetermined:
            return .Unknown
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d
        }
    }
    
    /**
    Requests access to Events, if necessary.
    */
<<<<<<< HEAD
    @objc
    public func requestEvents() {
        let status = statusEvents()
        switch status {
        case .unknown:
            EKEventStore().requestAccess(to: .event,
                completion: { granted, error in
                    self.detectAndCallback()
            })
        case .unauthorized:
            self.showDeniedAlert(.events)
=======
    public func requestEvents() {
        let status = statusEvents()
        switch status {
        case .Unknown:
            EKEventStore().requestAccessToEntityType(.Event,
                completion: { granted, error in
                    self.detectAndCallback()
            })
        case .Unauthorized:
            self.showDeniedAlert(.Events)
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d
        default:
            break
        }
    }
    
    // MARK: Bluetooth
    
    /// Returns whether Bluetooth access was asked before or not.
<<<<<<< HEAD
    fileprivate var askedBluetooth:Bool {
        get {
            return defaults.bool(forKey: Constants.NSUserDefaultsKeys.requestedBluetooth)
        }
        set {
            defaults.set(newValue, forKey: Constants.NSUserDefaultsKeys.requestedBluetooth)
=======
    private var askedBluetooth:Bool {
        get {
            return defaults.boolForKey(Constants.NSUserDefaultsKeys.requestedBluetooth)
        }
        set {
            defaults.setBool(newValue, forKey: Constants.NSUserDefaultsKeys.requestedBluetooth)
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d
            defaults.synchronize()
        }
    }
    
    /// Returns whether PermissionScope is waiting for the user to enable/disable bluetooth access or not.
<<<<<<< HEAD
    fileprivate var waitingForBluetooth = false
=======
    private var waitingForBluetooth = false
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d
    
    /**
    Returns the current permission status for accessing Bluetooth.
    
    - returns: Permission status for the requested type.
    */
    public func statusBluetooth() -> PermissionStatus {
        // if already asked for bluetooth before, do a request to get status, else wait for user to request
        if askedBluetooth{
            triggerBluetoothStatusUpdate()
        } else {
<<<<<<< HEAD
            return .unknown
=======
            return .Unknown
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d
        }
        
        let state = (bluetoothManager.state, CBPeripheralManager.authorizationStatus())
        switch state {
<<<<<<< HEAD
        case (.unsupported, _), (.poweredOff, _), (_, .restricted):
            return .disabled
        case (.unauthorized, _), (_, .denied):
            return .unauthorized
        case (.poweredOn, .authorized):
            return .authorized
        default:
            return .unknown
=======
        case (.Unsupported, _), (.PoweredOff, _), (_, .Restricted):
            return .Disabled
        case (.Unauthorized, _), (_, .Denied):
            return .Unauthorized
        case (.PoweredOn, .Authorized):
            return .Authorized
        default:
            return .Unknown
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d
        }
        
    }
    
    /**
    Requests access to Bluetooth, if necessary.
    */
<<<<<<< HEAD
    @objc
    public func requestBluetooth() {
        let status = statusBluetooth()
        switch status {
        case .disabled:
            showDisabledAlert(.bluetooth)
        case .unauthorized:
            showDeniedAlert(.bluetooth)
        case .unknown:
=======
    public func requestBluetooth() {
        let status = statusBluetooth()
        switch status {
        case .Disabled:
            showDisabledAlert(.Bluetooth)
        case .Unauthorized:
            showDeniedAlert(.Bluetooth)
        case .Unknown:
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d
            triggerBluetoothStatusUpdate()
        default:
            break
        }
        
    }
    
    /**
    Start and immediately stop bluetooth advertising to trigger
    its permission dialog.
    */
<<<<<<< HEAD
    fileprivate func triggerBluetoothStatusUpdate() {
        if !waitingForBluetooth && bluetoothManager.state == .unknown {
=======
    private func triggerBluetoothStatusUpdate() {
        if !waitingForBluetooth && bluetoothManager.state == .Unknown {
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d
            bluetoothManager.startAdvertising(nil)
            bluetoothManager.stopAdvertising()
            askedBluetooth = true
            waitingForBluetooth = true
        }
    }
    
    // MARK: Core Motion Activity
    
    /**
    Returns the current permission status for accessing Core Motion Activity.
    
    - returns: Permission status for the requested type.
    */
    public func statusMotion() -> PermissionStatus {
        if askedMotion {
            triggerMotionStatusUpdate()
        }
        return motionPermissionStatus
    }
    
    /**
    Requests access to Core Motion Activity, if necessary.
    */
<<<<<<< HEAD
    @objc
    public func requestMotion() {
        let status = statusMotion()
        switch status {
        case .unauthorized:
            showDeniedAlert(.motion)
        case .unknown:
=======
    public func requestMotion() {
        let status = statusMotion()
        switch status {
        case .Unauthorized:
            showDeniedAlert(.Motion)
        case .Unknown:
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d
            triggerMotionStatusUpdate()
        default:
            break
        }
    }
    
    /**
    Prompts motionManager to request a status update. If permission is not already granted the user will be prompted with the system's permission dialog.
    */
<<<<<<< HEAD
    fileprivate func triggerMotionStatusUpdate() {
        let tmpMotionPermissionStatus = motionPermissionStatus
        defaults.set(true, forKey: Constants.NSUserDefaultsKeys.requestedMotion)
        defaults.synchronize()
        
        let today = Date()
        motionManager.queryActivityStarting(from: today,
            to: today,
            to: .main) { activities, error in
                if let error = error , error._code == Int(CMErrorMotionActivityNotAuthorized.rawValue) {
                    self.motionPermissionStatus = .unauthorized
                } else {
                    self.motionPermissionStatus = .authorized
=======
    private func triggerMotionStatusUpdate() {
        let tmpMotionPermissionStatus = motionPermissionStatus
        defaults.setBool(true, forKey: Constants.NSUserDefaultsKeys.requestedMotion)
        defaults.synchronize()
        
        let today = NSDate()
        motionManager.queryActivityStartingFromDate(today,
            toDate: today,
            toQueue: .mainQueue()) { activities, error in
                if let error = error where error.code == Int(CMErrorMotionActivityNotAuthorized.rawValue) {
                    self.motionPermissionStatus = .Unauthorized
                } else {
                    self.motionPermissionStatus = .Authorized
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d
                }
                
                self.motionManager.stopActivityUpdates()
                if tmpMotionPermissionStatus != self.motionPermissionStatus {
                    self.waitingForMotion = false
                    self.detectAndCallback()
                }
        }
        
        askedMotion = true
        waitingForMotion = true
    }
    
    /// Returns whether Bluetooth access was asked before or not.
<<<<<<< HEAD
    fileprivate var askedMotion:Bool {
        get {
            return defaults.bool(forKey: Constants.NSUserDefaultsKeys.requestedMotion)
        }
        set {
            defaults.set(newValue, forKey: Constants.NSUserDefaultsKeys.requestedMotion)
=======
    private var askedMotion:Bool {
        get {
            return defaults.boolForKey(Constants.NSUserDefaultsKeys.requestedMotion)
        }
        set {
            defaults.setBool(newValue, forKey: Constants.NSUserDefaultsKeys.requestedMotion)
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d
            defaults.synchronize()
        }
    }
    
    /// Returns whether PermissionScope is waiting for the user to enable/disable motion access or not.
<<<<<<< HEAD
    fileprivate var waitingForMotion = false
=======
    private var waitingForMotion = false
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d
    
    // MARK: - UI
    
    /**
    Shows the modal viewcontroller for requesting access to the configured permissions and sets up the closures on it.
    
    - parameter authChange: Called when a status is detected on any of the permissions.
    - parameter cancelled:  Called when the user taps the Close button.
    */
<<<<<<< HEAD
    @objc public func show(_ authChange: authClosureType? = nil, cancelled: cancelClosureType? = nil) {
=======
    @objc public func show(authChange: authClosureType? = nil, cancelled: cancelClosureType? = nil) {
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d
        assert(!configuredPermissions.isEmpty, "Please add at least one permission")

        onAuthChange = authChange
        onCancel = cancelled
        
<<<<<<< HEAD
        DispatchQueue.main.async {
=======
        dispatch_async(dispatch_get_main_queue()) {
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d
            while self.waitingForBluetooth || self.waitingForMotion { }
            // call other methods that need to wait before show
            // no missing required perms? callback and do nothing
            self.requiredAuthorized({ areAuthorized in
                if areAuthorized {
                    self.getResultsForConfig({ results in

<<<<<<< HEAD
                        self.onAuthChange?(true, results)
=======
                        self.onAuthChange?(finished: true, results: results)
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d
                    })
                } else {
                    self.showAlert()
                }
            })
        }
    }
    
    /**
    Creates the modal viewcontroller and shows it.
    */
<<<<<<< HEAD
    fileprivate func showAlert() {
        // add the backing views
        let window = UIApplication.shared.keyWindow!
=======
    private func showAlert() {
        // add the backing views
        let window = UIApplication.sharedApplication().keyWindow!
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d
        
        //hide KB if it is shown
        window.endEditing(true)
        
        window.addSubview(view)
        view.frame = window.bounds
        baseView.frame = window.bounds

        for button in permissionButtons {
            button.removeFromSuperview()
        }
        permissionButtons = []

        for label in permissionLabels {
            label.removeFromSuperview()
        }
        permissionLabels = []

        // create the buttons
        for permission in configuredPermissions {
            let button = permissionStyledButton(permission.type)
            permissionButtons.append(button)
            contentView.addSubview(button)

            let label = permissionStyledLabel(permission.type)
            permissionLabels.append(label)
            contentView.addSubview(label)
        }
        
        self.view.setNeedsLayout()
        
        // slide in the view
        self.baseView.frame.origin.y = self.view.bounds.origin.y - self.baseView.frame.size.height
        self.view.alpha = 0
        
<<<<<<< HEAD
        UIView.animate(withDuration: 0.2, delay: 0.0, options: [], animations: {
            self.baseView.center.y = window.center.y + 15
            self.view.alpha = 1
        }, completion: { finished in
            UIView.animate(withDuration: 0.2, animations: {
=======
        UIView.animateWithDuration(0.2, delay: 0.0, options: [], animations: {
            self.baseView.center.y = window.center.y + 15
            self.view.alpha = 1
        }, completion: { finished in
            UIView.animateWithDuration(0.2, animations: {
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d
                self.baseView.center = window.center
            })
        })
    }

    /**
    Hides the modal viewcontroller with an animation.
    */
    public func hide() {
<<<<<<< HEAD
        let window = UIApplication.shared.keyWindow!

        DispatchQueue.main.async(execute: {
            UIView.animate(withDuration: 0.2, animations: {
=======
        let window = UIApplication.sharedApplication().keyWindow!

        dispatch_async(dispatch_get_main_queue(), {
            UIView.animateWithDuration(0.2, animations: {
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d
                self.baseView.frame.origin.y = window.center.y + 400
                self.view.alpha = 0
            }, completion: { finished in
                self.view.removeFromSuperview()
            })
        })
        
        notificationTimer?.invalidate()
        notificationTimer = nil
    }
    
    // MARK: - Delegates
    
    // MARK: Gesture delegate
    
<<<<<<< HEAD
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
=======
    public func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d
        // this prevents our tap gesture from firing for subviews of baseview
        if touch.view == baseView {
            return true
        }
        return false
    }

    // MARK: Location delegate
    
<<<<<<< HEAD
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
=======
    public func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d
        detectAndCallback()
    }
    
    // MARK: Bluetooth delegate
    
<<<<<<< HEAD
    public func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
=======
    public func peripheralManagerDidUpdateState(peripheral: CBPeripheralManager) {
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d
        waitingForBluetooth = false
        detectAndCallback()
    }

    // MARK: - UI Helpers
    
    /**
    Called when the users taps on the close button.
    */
<<<<<<< HEAD
    @objc func cancel() {
=======
    func cancel() {
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d
        self.hide()
        
        if let onCancel = onCancel {
            getResultsForConfig({ results in
<<<<<<< HEAD
                onCancel(results)
=======
                onCancel(results: results)
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d
            })
        }
    }
    
    /**
    Shows an alert for a permission which was Denied.
    
    - parameter permission: Permission type.
    */
<<<<<<< HEAD
    func showDeniedAlert(_ permission: PermissionType) {
        // compile the results and pass them back if necessary
        if let onDisabledOrDenied = self.onDisabledOrDenied {
            self.getResultsForConfig({ results in
                onDisabledOrDenied(results)
            })
        }
        
        let alert = UIAlertController(title: String(format: "Permission for (prettyDescription) was denied.".localized,permission.prettyDescription),
            message: String(format: "Please enable access to (prettyDescription) in the Settings app".localized,permission.prettyDescription),
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK".localized,
            style: .cancel,
            handler: nil))
        alert.addAction(UIAlertAction(title: "Show me".localized,
            style: .default,
            handler: { action in
                NotificationCenter.default.addObserver(self, selector: #selector(self.appForegroundedAfterSettings), name: UIApplication.didBecomeActiveNotification, object: nil)
                
                let settingsUrl = URL(string: UIApplication.openSettingsURLString)
                UIApplication.shared.openURL(settingsUrl!)
        }))
        
        DispatchQueue.main.async {
            self.viewControllerForAlerts?.present(alert,
=======
    func showDeniedAlert(permission: PermissionType) {
        // compile the results and pass them back if necessary
        if let onDisabledOrDenied = self.onDisabledOrDenied {
            self.getResultsForConfig({ results in
                onDisabledOrDenied(results: results)
            })
        }
        
        let alert = UIAlertController(title: "Permission for \(permission.prettyDescription) was denied.".localized,
            message: "Please enable access to \(permission.prettyDescription) in the Settings app".localized,
            preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK".localized,
            style: .Cancel,
            handler: nil))
        alert.addAction(UIAlertAction(title: "Show me".localized,
            style: .Default,
            handler: { action in
                NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.appForegroundedAfterSettings), name: UIApplicationDidBecomeActiveNotification, object: nil)
                
                let settingsUrl = NSURL(string: UIApplicationOpenSettingsURLString)
                UIApplication.sharedApplication().openURL(settingsUrl!)
        }))
        
        dispatch_async(dispatch_get_main_queue()) {
            self.viewControllerForAlerts?.presentViewController(alert,
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d
                animated: true, completion: nil)
        }
    }
    
    /**
    Shows an alert for a permission which was Disabled (system-wide).
    
    - parameter permission: Permission type.
    */
<<<<<<< HEAD
    func showDisabledAlert(_ permission: PermissionType) {
        // compile the results and pass them back if necessary
        if let onDisabledOrDenied = self.onDisabledOrDenied {
            self.getResultsForConfig({ results in
                onDisabledOrDenied(results)
            })
        }
        
        let alert = UIAlertController(title: String(format: "(prettyDescription) is currently disabled.".localized,permission.prettyDescription),
            message: String(format: "Please enable access to (prettyDescription) in Settings".localized,permission.prettyDescription),
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK".localized,
            style: .cancel,
            handler: nil))
        alert.addAction(UIAlertAction(title: "Show me".localized,
            style: .default,
            handler: { action in
                NotificationCenter.default.addObserver(self, selector: #selector(self.appForegroundedAfterSettings), name: UIApplication.didBecomeActiveNotification, object: nil)
                
                let settingsUrl = URL(string: UIApplication.openSettingsURLString)
                UIApplication.shared.openURL(settingsUrl!)
        }))
        
        DispatchQueue.main.async {
            self.viewControllerForAlerts?.present(alert,
=======
    func showDisabledAlert(permission: PermissionType) {
        // compile the results and pass them back if necessary
        if let onDisabledOrDenied = self.onDisabledOrDenied {
            self.getResultsForConfig({ results in
                onDisabledOrDenied(results: results)
            })
        }
        
        let alert = UIAlertController(title: "\(permission.prettyDescription) is currently disabled.".localized,
            message: "Please enable access to \(permission.prettyDescription) in Settings".localized,
            preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK".localized,
            style: .Cancel,
            handler: nil))
        alert.addAction(UIAlertAction(title: "Show me".localized,
            style: .Default,
            handler: { action in
                NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.appForegroundedAfterSettings), name: UIApplicationDidBecomeActiveNotification, object: nil)
                
                let settingsUrl = NSURL(string: UIApplicationOpenSettingsURLString)
                UIApplication.sharedApplication().openURL(settingsUrl!)
        }))
        
        dispatch_async(dispatch_get_main_queue()) {
            self.viewControllerForAlerts?.presentViewController(alert,
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d
                animated: true, completion: nil)
        }
    }

    // MARK: Helpers
    
    /**
    This notification callback is triggered when the app comes back
    from the settings page, after a user has tapped the "show me" 
    button to check on a disabled permission. It calls detectAndCallback
    to recheck all the permissions and update the UI.
    */
<<<<<<< HEAD
    @objc func appForegroundedAfterSettings() {
        NotificationCenter.default.removeObserver(self, name: UIApplication.didBecomeActiveNotification, object: nil)
=======
    func appForegroundedAfterSettings() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIApplicationDidBecomeActiveNotification, object: nil)
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d
        
        detectAndCallback()
    }
    
    /**
    Requests the status of any permission.
    
    - parameter type:       Permission type to be requested
    - parameter completion: Closure called when the request is done.
    */
<<<<<<< HEAD
    func statusForPermission(_ type: PermissionType, completion: statusRequestClosure) {
        // Get permission status
        let permissionStatus: PermissionStatus
        switch type {
        case .locationAlways:
            permissionStatus = statusLocationAlways()
        case .locationInUse:
            permissionStatus = statusLocationInUse()
        case .contacts:
            permissionStatus = statusContacts()
        case .notifications:
            permissionStatus = statusNotifications()
        case .microphone:
            permissionStatus = statusMicrophone()
        case .camera:
            permissionStatus = statusCamera()
        case .photos:
            permissionStatus = statusPhotos()
        case .reminders:
            permissionStatus = statusReminders()
        case .events:
            permissionStatus = statusEvents()
        case .bluetooth:
            permissionStatus = statusBluetooth()
        case .motion:
=======
    func statusForPermission(type: PermissionType, completion: statusRequestClosure) {
        // Get permission status
        let permissionStatus: PermissionStatus
        switch type {
        case .LocationAlways:
            permissionStatus = statusLocationAlways()
        case .LocationInUse:
            permissionStatus = statusLocationInUse()
        case .Contacts:
            permissionStatus = statusContacts()
        case .Notifications:
            permissionStatus = statusNotifications()
        case .Microphone:
            permissionStatus = statusMicrophone()
        case .Camera:
            permissionStatus = statusCamera()
        case .Photos:
            permissionStatus = statusPhotos()
        case .Reminders:
            permissionStatus = statusReminders()
        case .Events:
            permissionStatus = statusEvents()
        case .Bluetooth:
            permissionStatus = statusBluetooth()
        case .Motion:
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d
            permissionStatus = statusMotion()
        }
        
        // Perform completion
<<<<<<< HEAD
        completion(permissionStatus)
=======
        completion(status: permissionStatus)
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d
    }
    
    /**
    Rechecks the status of each requested permission, updates
    the PermissionScope UI in response and calls your onAuthChange
    to notifiy the parent app.
    */
    func detectAndCallback() {
<<<<<<< HEAD
        DispatchQueue.main.async {
=======
        dispatch_async(dispatch_get_main_queue()) {
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d
            // compile the results and pass them back if necessary
            if let onAuthChange = self.onAuthChange {
                self.getResultsForConfig({ results in
                    self.allAuthorized({ areAuthorized in
<<<<<<< HEAD
                        onAuthChange(areAuthorized, results)
=======
                        onAuthChange(finished: areAuthorized, results: results)
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d
                    })
                })
            }
            
            self.view.setNeedsLayout()

            // and hide if we've sucessfully got all permissions
            self.allAuthorized({ areAuthorized in
                if areAuthorized {
                    self.hide()
                }
            })
        }
    }
    
    /**
    Calculates the status for each configured permissions for the caller
    */
<<<<<<< HEAD
    func getResultsForConfig(_ completionBlock: resultsForConfigClosure) {
=======
    func getResultsForConfig(completionBlock: resultsForConfigClosure) {
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d
        var results: [PermissionResult] = []
        
        for config in configuredPermissions {
            self.statusForPermission(config.type, completion: { status in
                let result = PermissionResult(type: config.type,
                    status: status)
                results.append(result)
            })
        }
        
        completionBlock(results)
    }
}
