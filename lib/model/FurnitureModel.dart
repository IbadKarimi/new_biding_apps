

class FurnitureModel{
  String buyerDocId="";
  String makingMaterial="";
  String condition="";
  String selectType="";
  String auctionType="";
  String setBidPrice="";
  String setBidEndTime="";
  String cityName="";
  String completeAddress="";
  String description="";
  String status="";
  String imagePath="";
  String remainingTime="";
  String categoryName="";
  String userId="";

  FurnitureModel({required this.userId,required this.buyerDocId,required this.makingMaterial,required this.condition,required this.selectType,required this.auctionType,required this.setBidPrice,required this.setBidEndTime,
  required this.cityName,required this.completeAddress,required this.description,required this.status,required this.imagePath,required this.remainingTime,required this.categoryName});

  factory  FurnitureModel.fromFirestore(Map<String, dynamic> data) {
    return FurnitureModel(


      buyerDocId: data['buyerDocId'] ??"",
      makingMaterial:data['makingMaterial'] ??"",
      condition:data['condition']??"",
      selectType:data['selectType']??"",
      auctionType:data['auctionType']??"",
      setBidPrice:data['setBidPrice']??"",
      setBidEndTime:data['setBidEndTime']??"",
      cityName:data['cityName']??"",
      completeAddress:data['completeAddress']??"",
      description:data['description']??"",
      status:data['status']??"",
      imagePath:data['imagePath']??"",
      remainingTime: data['remainingTime'] ??"",
      categoryName:data['categoryName']??"",
      userId: data['id'] ??"",


    );
  }

}