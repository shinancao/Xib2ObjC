//
//  UIScrollViewProcessor.swift
//  XibProcessor
//
//  Created by 张楠[产品技术中心] on 2018/6/6.
//

import Foundation

class UIScrollViewProcessor: UIViewProcessor {
    override func process(attrName: String, attrText: String) {
        if attrName == "multipleTouchEnabled" {
            output[attrName] = attrText
        } else if attrName == "directionalLockEnabled" {
            output[attrName] = attrText
        } else if attrName == "bounces" {
            output[attrName] = attrText
        } else if attrName == "alwaysBounceVertical" {
            output[attrName] = attrText
        } else if attrName == "alwaysBounceHorizontal" {
            output[attrName] = attrText
        } else if attrName == "scrollEnabled" {
            output[attrName] = attrText
        } else if attrName == "pagingEnabled" {
            output[attrName] = attrText
        } else if attrName == "showsHorizontalScrollIndicator" {
            output[attrName] = attrText
        } else if attrName == "showsVerticalScrollIndicator" {
            output[attrName] = attrText
        } else if attrName == "indicatorStyle" {
            output[attrName] = attrText.indicatorStyleString
        } else if attrName == "delaysContentTouches" {
            output[attrName] = attrText
        } else if attrName == "canCancelContentTouches" {
            output[attrName] = attrText
        } else if attrName == "minimumZoomScale" {
            output[attrName] = attrText
        } else if attrName == "maximumZoomScale" {
            output[attrName] = attrText
        } else if attrName == "bouncesZoom" {
            output[attrName] = attrText
        } else if attrName == "keyboardDismissMode" {
            output[attrName] = attrText.keyboardDismissModeString
        } else {
            super.process(attrName: attrName, attrText: attrText)
        }
    }
}
