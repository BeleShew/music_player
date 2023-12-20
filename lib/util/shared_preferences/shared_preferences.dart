import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Sharedpreferences{
  static SharedPreferences? _preferencesprefs;

  //Read
  static initSharedPreference()async{
    _preferencesprefs=await SharedPreferences.getInstance();
  }
  static Future<String?> getStringValuesSF({key}) async {
    //Return String
    var stringValue =_preferencesprefs?.getString(key);
    return stringValue;
  }
  static Future<List<String>?> getStringListValuesSF({key}) async {
    //Return String List
    var stringValue =_preferencesprefs?.getStringList(key);
    return stringValue;
  }
  static Future<bool?> getBoolValuesSF({key}) async {
    //Return bool
    bool? boolValue = _preferencesprefs?.getBool(key);
    return boolValue;
  }
  static Future<int?> getIntValuesSF({key}) async {
    //Return int
    int? intValue = _preferencesprefs?.getInt(key);
    return intValue;
  }
  static Future<double?> getDoubleValuesSF({key}) async {
    //Return double
    double? doubleValue = _preferencesprefs?.getDouble(key);
    return doubleValue;
  }

  //Write
static saveValues({key,values,required PreferenceType valueTypeToSaved,bool isStringList=false}){
    switch(valueTypeToSaved){
      case PreferenceType.isString:
        addStringToSF(key: key,value: values,isStringList:isStringList);
        break;
      case PreferenceType.isInt:
        addIntToSF(key: key,value: values);
        break;
      case PreferenceType.isBoolean:
        addBoolToSF(key: key,value: values);
        break;
      case PreferenceType.isDouble:
        addDoubleToSF(key: key,value: values);
        break;
      default:
    addStringToSF(key: key,value: values,isStringList:isStringList);
    break;
    }
    }
  static addStringToSF({key, value,bool isStringList=false}) async {
    try{
      if(isStringList){
        await _preferencesprefs?.setStringList(key, value);
      }else{
        await _preferencesprefs?.setString(key, value);
      }
    }catch(e){
      print(e);
    }
  }
  static addIntToSF({key, value}) async {
   await _preferencesprefs?.setInt(key, value);
  }
  static addDoubleToSF({key, value}) async {
    _preferencesprefs?.setDouble(key, value);
  }
  static addBoolToSF({key, value}) async {
    _preferencesprefs?.setBool(key, value);
  }
}
enum PreferenceType{
  isInt,isDouble,isString,isBoolean
}