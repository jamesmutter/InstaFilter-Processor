import UIKit

let image = UIImage(named: "sample")!

class Filter{
    var userRGBA = [UInt8](count:5, repeatedValue: 0)
}

let redFilter: Filter = Filter()
redFilter.userRGBA[0] = 255

let greenFilter: Filter = Filter()
greenFilter.userRGBA[1] = 45

let blueFilter: Filter = Filter()
blueFilter.userRGBA[2] = 255

let zeroGreen: Filter = Filter()
zeroGreen.userRGBA[3] = 50

let zeroRed = Filter()
zeroRed.userRGBA[4] = 65



class ImageProcessor{
    
    var finalFilterList: [Filter] = []
    
    var filtersToChoose: [String: Filter] = [
        "redFilter": redFilter,
        "greenFilter": greenFilter,
        "blueFilter": blueFilter,
        "zeroGreen": zeroGreen,
        "zeroRed": zeroRed
    ]
    
    func addFilter(filter: String){
        finalFilterList.append(filtersToChoose[filter]!)
    }
    
    func appyFilters(image: UIImage) -> UIImage{
        
        let userImage = RGBAImage(image: image)!
        
        for y in 0..<userImage.height{
            for x in 0..<userImage.width{
                let index = y * userImage.width + x
                var pixel = userImage.pixels[index]
                for filter in finalFilterList{
                    for value in 0...4 {
                    
                        if(filter.userRGBA[value] != 0 ){
                            
                            switch value{
                                
                            case 0:
                                
                                let redDiff = Int(pixel.red) - 1
                                if (redDiff>0) {
                                    pixel.red = UInt8( max(0,min(255,1 + redDiff*2 ) ) )
                                    userImage.pixels[index] = pixel
                                }
                                
                            case 1:
                                
                                let greenDiff = Int(pixel.green) - 1
                                if (greenDiff>0) {
                                    pixel.green = UInt8( max(0,min(255,1 + greenDiff*2 ) ) )
                                    userImage.pixels[index] = pixel //store pixel back in image
                                }
                                
                            case 2:
                                
                                let blueDiff = Int(pixel.blue) - 1
                                if (blueDiff>0) {
                                    pixel.blue = UInt8( max(0,min(255,1 + blueDiff*2 ) ) )
                                    userImage.pixels[index] = pixel //store pixel back in image
                                }
                                
                            case 3:
                                
                                let greenValue = Int(pixel.green)
                                if (greenValue>0) {
                                    pixel.green = 0
                                    userImage.pixels[index] = pixel //store pixel back in image
                                }
                                
                            case 4:
                                let redValue = Int(pixel.red)
                                if (redValue>0) {
                                    pixel.red = 0
                                    userImage.pixels[index] = pixel //store pixel back in image
                                }
                                
                            default:
                                
                                print("No filter named that")
                                
                            }
                        }
                    }
                }
            }
        }
        let finalImage = userImage.toUIImage()!
        return finalImage
    }
}


var imageProcessor: ImageProcessor = ImageProcessor()

imageProcessor.addFilter("greenFilter")
imageProcessor.addFilter("blueFilter")



imageProcessor.appyFilters(image)
