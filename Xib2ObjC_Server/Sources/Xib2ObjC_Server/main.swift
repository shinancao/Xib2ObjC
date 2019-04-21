import XibProcessor
import Rainbow

let processor = XibProcessor()
processor.input = "/Users/zn/Documents/workplace/TextXIB/TestXIB/TestCollectionView.xib"

do {
    let filePath = try processor.process()
    print("\(filePath).h is generated.".green.bold)
    print("\(filePath).m is generated.".green.bold)
} catch Xib2ObjCError.createOutputDirFailed(let errorMsg){
    print(errorMsg.red.bold)
} catch Xib2ObjCError.xibFileNotExist(let errorMsg) {
    print(errorMsg.red.bold)
} catch Xib2ObjCError.unknownXibObject(let errorMsg) {
    print(errorMsg.red.bold)
} catch Xib2ObjCError.parseXibToXmlFailed(let errorMsg) {
    print(errorMsg.red.bold)
} catch {
    print("Unexpected error: \(error).".red.bold)
}
