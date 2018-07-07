//
//  ViewFileFormat.swift
//  XibProcessor
//
//  Created by Shinancao on 2018/7/7.
//

import Foundation

let viewFileFormatDict = [
    "ViewHFileString":"//\n// [View-Name].h\n// [Project-Name]\n//\n// Created by [Author] on [Date].\n// Copyright © [Year] [Organization]. All rights reserved.\n//\n\n#import <UIKit/UIKit.h>\n\n@interface [View-Name] : [Inherit-Name]\n\n@end",
    "ViewMFileString":"//\n// [View-Name].m\n// [Project-Name]\n//\n// Created by [Author] on [Date].\n// Copyright © [Year] [Organization]. All rights reserved.\n//\n\n#import \"[View-Name].h\"\n#import <Masonry/Masonry.h>\n\n@interface [View-Name]()\n\n[Property]\n\n@end\n\n@implementation [View-Name]\n\n[Constructor]\n\n- (void)setupUI {\n[UI-Layout]\n}\n\n@end",
    "CallMethodString":"[self setupUI];"
]

struct ViewFile {
    let name: String
    let inheritName: String
    let constructor: String
    
    static func getViewFile(klass:String, userLabel: String) -> ViewFile {
        let callMethodString = viewFileFormatDict["CallMethodString"]!;
        let name = userLabel.capitalizingFirstLetter()
        let inheritName = klass
        var constructor = ""
        if klass == "UITableViewCell" {
            constructor = "- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {\n    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {        \(callMethodString)\n    }\n    return self;\n}"
        } else {
            constructor = "- (instancetype)initWithFrame:(CGRect)frame {\n    if (self = [super initWithFrame:frame]) {\n        \(callMethodString);\n    }\n    return self;\n}"
        }
        return ViewFile(name: name, inheritName: inheritName, constructor: constructor)
    }
}

struct ProjectInformation {
    let author: String
    let dateString: String
    let yearString: String
    
    init() {
        self.author = NSUserName()
        
        let date = Date()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        self.dateString = formatter.string(from: date)
        
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        self.yearString = "\(year)年"
    }
}

let projectInfo = ProjectInformation()
