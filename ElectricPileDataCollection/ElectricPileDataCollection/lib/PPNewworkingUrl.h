//
//  PPNewworkingUrl.h
//  上传Demo
//
//  Created by apple on 16/3/17.
//  Copyright © 2016年 鲁强. All rights reserved.
//

#ifndef PPNewworkingUrl_h
#define PPNewworkingUrl_h


#endif /* PPNewworkingUrl_h */


// 基础URL
#define BaseUrl @"http://192.168.1.38/"

// 图片上传路径
#define UpLoadImageUrl BaseUrl@"image-service/upload/?location=%@"

// 数据上传路径
#define UpLoadDataUrl BaseUrl@"pile-service/pile/village/upload"

// 新增片区：userId:xx;districtId:xx;name:xx;code:xx;
#define UpLoadNewArea BaseUrl@"pile-service/region/area/add"

// 新增小区：userId:xx;areaId:xx;name:xx;code:xx;
#define UpLoadNewVillage BaseUrl@"pile-service/region/village/add"

