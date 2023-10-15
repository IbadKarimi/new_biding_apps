

class OtherCategoryModel{
  String buyerDocId="";
  String categoryName="";
  String condition="";
  String selectType="";
  String auctionType="";
  String setBidPrice="";
  String setBidEndTime="";
  String cityName="";
  String completeAddress="";
  String description="";
  String status="";


  OtherCategoryModel({this.buyerDocId,this.categoryName,this.condition,this.selectType,this.auctionType,this.setBidPrice,this.setBidEndTime,
    this.cityName,this.completeAddress,this.description,this.status});

  factory  OtherCategoryModel.fromFirestore(Map<String, dynamic> data) {
    return OtherCategoryModel(


      buyerDocId: data['buyerDocId'] ??"",
      condition:data['condition']??"",
      selectType:data['selectType']??"",
      auctionType:data['auctionType']??"",
      setBidPrice:data['setBidPrice']??"",
      setBidEndTime:data['setBidEndTime']??"",
      cityName:data['cityName']??"",
      completeAddress:data['completeAddress']??"",
      description:data['description']??"",
      status:data['status']??"",


    );
  }

}