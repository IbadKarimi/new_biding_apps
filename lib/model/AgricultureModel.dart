

class AgricultureModel{
  String id;
  String buyerDocId="";
String typesCrops="";
String workType="";
String areaType="";
String range="";
String auctionType="";
String setBidPrice="";
String setBidEndTime="";
String cityName="";
String completeAddress="";
String description="";
String status="";
String imagePath="";
String categoryName="";
String userId="";



AgricultureModel({required this.userId,required this.id,required this.buyerDocId,required this.typesCrops,required this.workType,required this.areaType,required this.range,required this.auctionType,required this.setBidPrice
,required this.setBidEndTime,required this.cityName,required this.completeAddress,required this.description,required this.status,required this.imagePath,required this.categoryName});


  factory  AgricultureModel.fromFirestore(Map<String, dynamic> data) {
    return AgricultureModel(

      id: data['id'] ??"",
      buyerDocId: data['buyerDocId'] ??"",
      typesCrops:data['typesCrop'] ??"",
      workType:data['workType']??"",
      areaType:data['areaType']??"",
      range:data['range']??"",
      auctionType:data['auctionType']??"",
      setBidPrice:data['setBidPrice']??"",
      setBidEndTime:data['setBidEndTime']??"",
      cityName:data['cityName']??"",
      completeAddress:data['completeAddress']??"",
      description:data['description']??"",
      status:data['status']??"",
      imagePath:data['imagePath']??"",
      categoryName:data['categoryName']??"",
      userId: data['id'] ??"",



    );
  }



}