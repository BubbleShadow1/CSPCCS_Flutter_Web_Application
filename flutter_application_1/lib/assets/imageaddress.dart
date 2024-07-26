class imageaddress{
   String basepath='assets/images/';
   String exten='.jpg';
   late String light;
  late String dark;
   imageaddress()
   {
      light=basepath+'light'+exten;
      dark=basepath+'dark'+exten;
   }
}
