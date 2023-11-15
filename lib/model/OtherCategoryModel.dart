

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


  OtherCategoryModel({required this.buyerDocId,required this.categoryName,required this.condition,required this.selectType,required this.auctionType,required this.setBidPrice,required this.setBidEndTime,
    required this.cityName,required this.completeAddress,required this.description,required this.status});

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
      categoryName: '',


    );
  }

}