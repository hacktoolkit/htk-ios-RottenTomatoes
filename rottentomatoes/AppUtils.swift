//
//  AppUtils.swift
//  rottentomatoes
//
//  Created by Jonathan Tsai on 9/16/14.
//  Copyright (c) 2014 Hacktoolkit. All rights reserved.
//

import Foundation

func displayNetworkErrorMessage() {
    TSMessage.showNotificationWithTitle(
        "Network error",
        subtitle: "Couldn't connect to the server. Check your network connection.",
        type: TSMessageNotificationType.Error
    )
}