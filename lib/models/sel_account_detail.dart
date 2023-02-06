// To parse this JSON data, do
//
//     final selAccountDetails = selAccountDetailsFromJson(jsonString);

import 'dart:convert';

SelAccountDetails selAccountDetailsFromJson(String str) =>
    SelAccountDetails.fromJson(json.decode(str));

String selAccountDetailsToJson(SelAccountDetails data) =>
    json.encode(data.toJson());

class SelAccountDetails {
  SelAccountDetails({
    this.accounts,
    this.status,
    this.statusText,
    this.requestMessageId,
    this.checkPoint,
    this.exceptionContext,
  });

  List<Account>? accounts;
  String? status;
  String? statusText;
  dynamic requestMessageId;
  int? checkPoint;
  dynamic exceptionContext;

  factory SelAccountDetails.fromJson(Map<String, dynamic> json) =>
      SelAccountDetails(
        accounts: List<Account>.from(
            json["Accounts"].map((x) => Account.fromJson(x))),
        status: json["Status"],
        statusText: json["StatusText"],
        requestMessageId: json["RequestMessageID"],
        checkPoint: json["CheckPoint"],
        exceptionContext: json["ExceptionContext"],
      );

  Map<String, dynamic> toJson() => {
        "Accounts": List<dynamic>.from(accounts!.map((x) => x.toJson())),
        "Status": status,
        "StatusText": statusText,
        "RequestMessageID": requestMessageId,
        "CheckPoint": checkPoint,
        "ExceptionContext": exceptionContext,
      };
}

class Account {
  Account({
    this.subscriberorderid,
    this.clecid,
    this.lifelinecertificationtypeid,
    this.firstname,
    this.mi,
    this.lastname,
    this.address,
    this.city,
    this.statetype,
    this.zipcode,
    this.customerpackageid,
    this.primaryphone,
    this.secondaryphone,
    this.email,
    this.ssn,
    this.dob,
    this.comment,
    this.csa,
    this.isloa,
    this.isetc,
    this.devicecost,
    this.shippingcost,
    this.tax,
    this.housenumber,
    this.suffix,
    this.directionprefixtype,
    this.streettypeid,
    this.directionsuffixtype,
    this.unittypeid,
    this.unit,
    this.elevationtypeid,
    this.elevation,
    this.structuretypeid,
    this.structure,
    this.wirelinenonetc,
    this.agestamponorder,
    this.smartphoneupgrade,
    this.smartphoneupgradepaid,
    this.smartphoneupgradecost,
    this.istribal,
    this.tribalid,
    this.rushshippingupgrade,
    this.rushshippingpaid,
    this.rushshippingcost,
    this.interactionid,
    this.isfasimoorder,
    this.creationDatetime,
    this.revisionDatetime,
    this.creationAuthor,
    this.revisionAuthor,
    this.lifelinecertificationtype,
    this.customerpackage,
    this.structuretype,
    this.refreshtype,
    this.currentstatetype,
    this.subscriberdeviceid,
    this.esn,
    this.esnHex,
    this.msid,
    this.mdn,
    this.msl,
    this.statustype,
    this.trackingnumber,
    this.shipmentdate,
    this.devicecsa,
    this.firstusedate,
    this.availablevoice,
    this.availabletext,
    this.availabledata,
    this.statustypeid,
    this.subscriberaccountid,
    this.isproofofbenefitsuploaded,
    this.isidentityproofuploaded,
    this.hasprioritynotes,
    this.hasoutgoingvoiceblock,
    this.hasincomingvoiceblock,
    this.hasoutgoingtextblock,
    this.hasincomingtextblock,
    this.incoveragearea,
    this.lastusedate,
    this.nladstatus,
    this.nladstatustypeid,
    this.nladerror,
    this.nladerrortypeid,
    this.lastrefreshdate,
    this.nextrefreshdate,
    this.activationdate,
    this.wirelessprovidertypeid,
    this.wirelessprovidertype,
    this.lteaddlactivationcode,
    this.paymentstatustypeid,
    this.paymentstatustype,
    this.clec,
    this.hasdatablock,
    this.address2,
    this.agentuserid,
    this.username,
    this.assigneddate,
    this.graceDate,
    this.modelnumber,
    this.model,
    this.nladresolutionid,
    this.usacsubscriberid,
    this.portstatus,
    this.imei,
    this.dateinserteddate,
    this.ipaddress,
    this.contractStartdate,
    this.contractEnddate,
    this.ebbp,
    this.ebbnladstatus,
    this.ebbpstatus,
    this.devicereimbursementdate,
    this.nladprogram,
    this.lastusedatevoicetext,
    this.ebblifelinecertificationtype,
    this.typeName,
    this.version,
  });

  int? subscriberorderid;
  int? clecid;
  dynamic lifelinecertificationtypeid;
  String? firstname;
  dynamic mi;
  String? lastname;
  String? address;
  String? city;
  String? statetype;
  String? zipcode;
  int? customerpackageid;
  String? primaryphone;
  dynamic secondaryphone;
  String? email;
  String? ssn;
  String? dob;
  String? comment;
  dynamic csa;
  bool? isloa;
  bool? isetc;
  dynamic devicecost;
  dynamic shippingcost;
  dynamic tax;
  dynamic housenumber;
  dynamic suffix;
  dynamic directionprefixtype;
  dynamic streettypeid;
  dynamic directionsuffixtype;
  dynamic unittypeid;
  dynamic unit;
  dynamic elevationtypeid;
  dynamic elevation;
  dynamic structuretypeid;
  dynamic structure;
  bool? wirelinenonetc;
  dynamic agestamponorder;
  bool? smartphoneupgrade;
  bool? smartphoneupgradepaid;
  dynamic smartphoneupgradecost;
  bool? istribal;
  dynamic tribalid;
  bool? rushshippingupgrade;
  bool? rushshippingpaid;
  dynamic rushshippingcost;
  dynamic interactionid;
  bool? isfasimoorder;
  String? creationDatetime;
  String? revisionDatetime;
  String? creationAuthor;
  String? revisionAuthor;
  dynamic lifelinecertificationtype;
  String? customerpackage;
  dynamic structuretype;
  dynamic refreshtype;
  String? currentstatetype;
  int? subscriberdeviceid;
  String? esn;
  dynamic esnHex;
  dynamic msid;
  String? mdn;
  String? msl;
  String? statustype;
  dynamic trackingnumber;
  dynamic shipmentdate;
  dynamic devicecsa;
  dynamic firstusedate;
  dynamic availablevoice;
  dynamic availabletext;
  dynamic availabledata;
  int? statustypeid;
  int? subscriberaccountid;
  bool? isproofofbenefitsuploaded;
  bool? isidentityproofuploaded;
  bool? hasprioritynotes;
  bool? hasoutgoingvoiceblock;
  bool? hasincomingvoiceblock;
  bool? hasoutgoingtextblock;
  bool? hasincomingtextblock;
  bool? incoveragearea;
  String? lastusedate;
  String? nladstatus;
  int? nladstatustypeid;
  dynamic nladerror;
  dynamic nladerrortypeid;
  dynamic lastrefreshdate;
  dynamic nextrefreshdate;
  String? activationdate;
  int? wirelessprovidertypeid;
  String? wirelessprovidertype;
  dynamic lteaddlactivationcode;
  dynamic paymentstatustypeid;
  dynamic paymentstatustype;
  String? clec;
  bool? hasdatablock;
  String? address2;
  int? agentuserid;
  String? username;
  dynamic assigneddate;
  dynamic graceDate;
  String? modelnumber;
  String? model;
  dynamic nladresolutionid;
  dynamic usacsubscriberid;
  dynamic portstatus;
  String? imei;
  dynamic dateinserteddate;
  dynamic ipaddress;
  dynamic contractStartdate;
  dynamic contractEnddate;
  bool? ebbp;
  int? ebbnladstatus;
  String? ebbpstatus;
  String? devicereimbursementdate;
  String? nladprogram;
  String? lastusedatevoicetext;
  String? ebblifelinecertificationtype;
  String? typeName;
  String? version;

  factory Account.fromJson(Map<String, dynamic> json) => Account(
        subscriberorderid: json["SUBSCRIBERORDERID"],
        clecid: json["CLECID"],
        lifelinecertificationtypeid: json["LIFELINECERTIFICATIONTYPEID"],
        firstname: json["FIRSTNAME"],
        mi: json["MI"],
        lastname: json["LASTNAME"],
        address: json["ADDRESS"],
        city: json["CITY"],
        statetype: json["STATETYPE"],
        zipcode: json["ZIPCODE"],
        customerpackageid: json["CUSTOMERPACKAGEID"],
        primaryphone: json["PRIMARYPHONE"],
        secondaryphone: json["SECONDARYPHONE"],
        email: json["EMAIL"],
        ssn: json["SSN"],
        dob: json["DOB"],
        comment: json["COMMENT"],
        csa: json["CSA"],
        isloa: json["ISLOA"],
        isetc: json["ISETC"],
        devicecost: json["DEVICECOST"],
        shippingcost: json["SHIPPINGCOST"],
        tax: json["TAX"],
        housenumber: json["HOUSENUMBER"],
        suffix: json["SUFFIX"],
        directionprefixtype: json["DIRECTIONPREFIXTYPE"],
        streettypeid: json["STREETTYPEID"],
        directionsuffixtype: json["DIRECTIONSUFFIXTYPE"],
        unittypeid: json["UNITTYPEID"],
        unit: json["UNIT"],
        elevationtypeid: json["ELEVATIONTYPEID"],
        elevation: json["ELEVATION"],
        structuretypeid: json["STRUCTURETYPEID"],
        structure: json["STRUCTURE"],
        wirelinenonetc: json["WIRELINENONETC"],
        agestamponorder: json["AGESTAMPONORDER"],
        smartphoneupgrade: json["SMARTPHONEUPGRADE"],
        smartphoneupgradepaid: json["SMARTPHONEUPGRADEPAID"],
        smartphoneupgradecost: json["SMARTPHONEUPGRADECOST"],
        istribal: json["ISTRIBAL"],
        tribalid: json["TRIBALID"],
        rushshippingupgrade: json["RUSHSHIPPINGUPGRADE"],
        rushshippingpaid: json["RUSHSHIPPINGPAID"],
        rushshippingcost: json["RUSHSHIPPINGCOST"],
        interactionid: json["INTERACTIONID"],
        isfasimoorder: json["ISFASIMOORDER"],
        creationDatetime: json["CREATION_DATETIME"],
        revisionDatetime: json["REVISION_DATETIME"],
        creationAuthor: json["CREATION_AUTHOR"],
        revisionAuthor: json["REVISION_AUTHOR"],
        lifelinecertificationtype: json["LIFELINECERTIFICATIONTYPE"],
        customerpackage: json["CUSTOMERPACKAGE"],
        structuretype: json["STRUCTURETYPE"],
        refreshtype: json["REFRESHTYPE"],
        currentstatetype: json["CURRENTSTATETYPE"],
        subscriberdeviceid: json["SUBSCRIBERDEVICEID"],
        esn: json["ESN"],
        esnHex: json["ESN_HEX"],
        msid: json["MSID"],
        mdn: json["MDN"],
        msl: json["MSL"],
        statustype: json["STATUSTYPE"],
        trackingnumber: json["TRACKINGNUMBER"],
        shipmentdate: json["SHIPMENTDATE"],
        devicecsa: json["DEVICECSA"],
        firstusedate: json["FIRSTUSEDATE"],
        availablevoice: json["AVAILABLEVOICE"],
        availabletext: json["AVAILABLETEXT"],
        availabledata: json["AVAILABLEDATA"],
        statustypeid: json["STATUSTYPEID"],
        subscriberaccountid: json["SUBSCRIBERACCOUNTID"],
        isproofofbenefitsuploaded: json["ISPROOFOFBENEFITSUPLOADED"],
        isidentityproofuploaded: json["ISIDENTITYPROOFUPLOADED"],
        hasprioritynotes: json["HASPRIORITYNOTES"],
        hasoutgoingvoiceblock: json["HASOUTGOINGVOICEBLOCK"],
        hasincomingvoiceblock: json["HASINCOMINGVOICEBLOCK"],
        hasoutgoingtextblock: json["HASOUTGOINGTEXTBLOCK"],
        hasincomingtextblock: json["HASINCOMINGTEXTBLOCK"],
        incoveragearea: json["INCOVERAGEAREA"],
        lastusedate: json["LASTUSEDATE"],
        nladstatus: json["NLADSTATUS"],
        nladstatustypeid: json["NLADSTATUSTYPEID"],
        nladerror: json["NLADERROR"],
        nladerrortypeid: json["NLADERRORTYPEID"],
        lastrefreshdate: json["LASTREFRESHDATE"],
        nextrefreshdate: json["NEXTREFRESHDATE"],
        activationdate: json["ACTIVATIONDATE"],
        wirelessprovidertypeid: json["WIRELESSPROVIDERTYPEID"],
        wirelessprovidertype: json["WIRELESSPROVIDERTYPE"],
        lteaddlactivationcode: json["LTEADDLACTIVATIONCODE"],
        paymentstatustypeid: json["PAYMENTSTATUSTYPEID"],
        paymentstatustype: json["PAYMENTSTATUSTYPE"],
        clec: json["CLEC"],
        hasdatablock: json["HASDATABLOCK"],
        address2: json["ADDRESS2"],
        agentuserid: json["AGENTUSERID"],
        username: json["USERNAME"],
        assigneddate: json["ASSIGNEDDATE"],
        graceDate: json["GRACE_DATE"],
        modelnumber: json["MODELNUMBER"],
        model: json["MODEL"],
        nladresolutionid: json["NLADRESOLUTIONID"],
        usacsubscriberid: json["USACSUBSCRIBERID"],
        portstatus: json["PORTSTATUS"],
        imei: json["IMEI"],
        dateinserteddate: json["DATEINSERTEDDATE"],
        ipaddress: json["IPADDRESS"],
        contractStartdate: json["CONTRACT_STARTDATE"],
        contractEnddate: json["CONTRACT_ENDDATE"],
        ebbp: json["EBBP"],
        ebbnladstatus: json["EBBNLADSTATUS"],
        ebbpstatus: json["EBBPSTATUS"],
        devicereimbursementdate: json["DEVICEREIMBURSEMENTDATE"],
        nladprogram: json["NLADPROGRAM"],
        lastusedatevoicetext: json["LASTUSEDATEVOICETEXT"],
        ebblifelinecertificationtype: json["EBBLIFELINECERTIFICATIONTYPE"],
        typeName: json["TypeName"],
        version: json["Version"],
      );

  Map<String, dynamic> toJson() => {
        "SUBSCRIBERORDERID": subscriberorderid,
        "CLECID": clecid,
        "LIFELINECERTIFICATIONTYPEID": lifelinecertificationtypeid,
        "FIRSTNAME": firstname,
        "MI": mi,
        "LASTNAME": lastname,
        "ADDRESS": address,
        "CITY": city,
        "STATETYPE": statetype,
        "ZIPCODE": zipcode,
        "CUSTOMERPACKAGEID": customerpackageid,
        "PRIMARYPHONE": primaryphone,
        "SECONDARYPHONE": secondaryphone,
        "EMAIL": email,
        "SSN": ssn,
        "DOB": dob,
        "COMMENT": comment,
        "CSA": csa,
        "ISLOA": isloa,
        "ISETC": isetc,
        "DEVICECOST": devicecost,
        "SHIPPINGCOST": shippingcost,
        "TAX": tax,
        "HOUSENUMBER": housenumber,
        "SUFFIX": suffix,
        "DIRECTIONPREFIXTYPE": directionprefixtype,
        "STREETTYPEID": streettypeid,
        "DIRECTIONSUFFIXTYPE": directionsuffixtype,
        "UNITTYPEID": unittypeid,
        "UNIT": unit,
        "ELEVATIONTYPEID": elevationtypeid,
        "ELEVATION": elevation,
        "STRUCTURETYPEID": structuretypeid,
        "STRUCTURE": structure,
        "WIRELINENONETC": wirelinenonetc,
        "AGESTAMPONORDER": agestamponorder,
        "SMARTPHONEUPGRADE": smartphoneupgrade,
        "SMARTPHONEUPGRADEPAID": smartphoneupgradepaid,
        "SMARTPHONEUPGRADECOST": smartphoneupgradecost,
        "ISTRIBAL": istribal,
        "TRIBALID": tribalid,
        "RUSHSHIPPINGUPGRADE": rushshippingupgrade,
        "RUSHSHIPPINGPAID": rushshippingpaid,
        "RUSHSHIPPINGCOST": rushshippingcost,
        "INTERACTIONID": interactionid,
        "ISFASIMOORDER": isfasimoorder,
        "CREATION_DATETIME": creationDatetime,
        "REVISION_DATETIME": revisionDatetime,
        "CREATION_AUTHOR": creationAuthor,
        "REVISION_AUTHOR": revisionAuthor,
        "LIFELINECERTIFICATIONTYPE": lifelinecertificationtype,
        "CUSTOMERPACKAGE": customerpackage,
        "STRUCTURETYPE": structuretype,
        "REFRESHTYPE": refreshtype,
        "CURRENTSTATETYPE": currentstatetype,
        "SUBSCRIBERDEVICEID": subscriberdeviceid,
        "ESN": esn,
        "ESN_HEX": esnHex,
        "MSID": msid,
        "MDN": mdn,
        "MSL": msl,
        "STATUSTYPE": statustype,
        "TRACKINGNUMBER": trackingnumber,
        "SHIPMENTDATE": shipmentdate,
        "DEVICECSA": devicecsa,
        "FIRSTUSEDATE": firstusedate,
        "AVAILABLEVOICE": availablevoice,
        "AVAILABLETEXT": availabletext,
        "AVAILABLEDATA": availabledata,
        "STATUSTYPEID": statustypeid,
        "SUBSCRIBERACCOUNTID": subscriberaccountid,
        "ISPROOFOFBENEFITSUPLOADED": isproofofbenefitsuploaded,
        "ISIDENTITYPROOFUPLOADED": isidentityproofuploaded,
        "HASPRIORITYNOTES": hasprioritynotes,
        "HASOUTGOINGVOICEBLOCK": hasoutgoingvoiceblock,
        "HASINCOMINGVOICEBLOCK": hasincomingvoiceblock,
        "HASOUTGOINGTEXTBLOCK": hasoutgoingtextblock,
        "HASINCOMINGTEXTBLOCK": hasincomingtextblock,
        "INCOVERAGEAREA": incoveragearea,
        "LASTUSEDATE": lastusedate,
        "NLADSTATUS": nladstatus,
        "NLADSTATUSTYPEID": nladstatustypeid,
        "NLADERROR": nladerror,
        "NLADERRORTYPEID": nladerrortypeid,
        "LASTREFRESHDATE": lastrefreshdate,
        "NEXTREFRESHDATE": nextrefreshdate,
        "ACTIVATIONDATE": activationdate,
        "WIRELESSPROVIDERTYPEID": wirelessprovidertypeid,
        "WIRELESSPROVIDERTYPE": wirelessprovidertype,
        "LTEADDLACTIVATIONCODE": lteaddlactivationcode,
        "PAYMENTSTATUSTYPEID": paymentstatustypeid,
        "PAYMENTSTATUSTYPE": paymentstatustype,
        "CLEC": clec,
        "HASDATABLOCK": hasdatablock,
        "ADDRESS2": address2,
        "AGENTUSERID": agentuserid,
        "USERNAME": username,
        "ASSIGNEDDATE": assigneddate,
        "GRACE_DATE": graceDate,
        "MODELNUMBER": modelnumber,
        "MODEL": model,
        "NLADRESOLUTIONID": nladresolutionid,
        "USACSUBSCRIBERID": usacsubscriberid,
        "PORTSTATUS": portstatus,
        "IMEI": imei,
        "DATEINSERTEDDATE": dateinserteddate,
        "IPADDRESS": ipaddress,
        "CONTRACT_STARTDATE": contractStartdate,
        "CONTRACT_ENDDATE": contractEnddate,
        "EBBP": ebbp,
        "EBBNLADSTATUS": ebbnladstatus,
        "EBBPSTATUS": ebbpstatus,
        "DEVICEREIMBURSEMENTDATE": devicereimbursementdate,
        "NLADPROGRAM": nladprogram,
        "LASTUSEDATEVOICETEXT": lastusedatevoicetext,
        "EBBLIFELINECERTIFICATIONTYPE": ebblifelinecertificationtype,
        "TypeName": typeName,
        "Version": version,
      };
}
