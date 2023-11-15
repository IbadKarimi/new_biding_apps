
class RealStateModel{
  String id="";
  String buyerDocId="";
  String selectType="";
  String areaType="";
  String range="";
  String noFloors="";
  String noBedrooms="";
  String noBathrooms="";
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

  RealStateModel({required this.userId,required this.id,required this.buyerDocId,required this.selectType,required this.areaType,required this.range,required this.noFloors,required this.noBedrooms,required this.noBathrooms,
  required this.auctionType,required this.setBidPrice,required this.setBidEndTime,required this.cityName,required this.completeAddress,required this.description,required this.status,required this.imagePath,required this.categoryName});

  factory  RealStateModel.fromFirestore(Map<String, dynamic> data) {
    return  RealStateModel(
      userId: data['id'] ??"",
      id: data['id'] ??"", //productId
      buyerDocId: data['buyerDocId'] ??"",
      selectType:data['selectType']??"",
      areaType:data['areaType']??"",
      range:data['range']??"",
      noFloors: data['noFloors']??"",
      noBedrooms: data['noBedrooms']??"",
      noBathrooms: data['noBathrooms']??"",
      auctionType:data['auctionType']??"",
      setBidPrice:data['setBidPrice']??"",
      setBidEndTime:data['setBidEndTime']??"",
      cityName:data['cityName']??"",
      completeAddress:data['completeAddress']??"",
      description:data['description']??"",
      status:data['status']??"",
      imagePath:data['imagePath']??"",
      categoryName:data['categoryName']??"",



    );
  }


}