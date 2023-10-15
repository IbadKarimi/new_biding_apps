
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

  RealStateModel({this.id,this.buyerDocId,this.selectType,this.areaType,this.range,this.noFloors,this.noBedrooms,this.noBathrooms,
  this.auctionType,this.setBidPrice,this.setBidEndTime,this.cityName,this.completeAddress,this.description,this.status});

  factory  RealStateModel.fromFirestore(Map<String, dynamic> data) {
    return  RealStateModel(

      id: data['id'] ??"",
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



    );
  }


}