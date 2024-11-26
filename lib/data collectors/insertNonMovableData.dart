import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class RegistrationFormNonMovableData extends StatefulWidget {
  // const RegistrationFormNonMovableData({super.key});
  final String? username;
  const RegistrationFormNonMovableData({super.key, required this.username});

  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationFormNonMovableData> {
  final _formKey = GlobalKey<FormState>();

  // File? _imageOfheritagePath;

  var WeredasIDMap = {
    // 'ወረዳ ሰለኽለካ',
    'ወረዳ ታሕታይ ኣድያቦ': 'ET-TG-TA',
    'ወረዳ ታሕታይ ቆራሮ': 'ET-TG-TQ',
    'ወረዳ ፀለምቲ': 'ET-TG-TL',
    'ከተማ ሽረ እንዳ ሥላሴ': 'ET-TG-SE',
    'ከተማ ሸራሮ': 'ET-TG-SK',
    'ከተማ ዓዲ ዳዕሮ': 'ET-TG-AD',
    'ወረዳ ኣስገደ': 'ET-TG-AS',
    'ከተማ እንዳባጉና': 'ET-TG-EB',
    'ከተማ ማይ ፀብሪ': 'ET-TG-MT',
    'ወረዳ ሰየምቲ ኣድያቦ': 'ET-TG-SA',

    'ወረዳ ፅምብላ': 'ET-TG-TB',
    'ወረዳ ዛና': 'ET-TG-ZN',
    'ወረዳ ላዕላይ ቆራሮ': 'ET-TG-LQ',
    'ወረዳ ማእከላይ ኣድያቦ': 'ET-TG-MA',
    'ወረዳ ላዕላይ ፀለምቲ': 'ET-TG-LT',
    // 'ወረዳ ዓዲ ነብሪኢድ',
    // 'ወረዳ ዲማ',

    'ከተማ አኽሱም': 'ET-TG-AX',
    'ከተማ ራማ ዓዲ ኣርባዕተ': 'ET-TG-RT',
    'ከተማ ዓቢይ ዓዲ': 'ET-TG-AD',
    'ወረዳ ኣሕፈሮም': 'ET-TG-AF',
    'ከተማ እንትጮ': 'ET-TG-ET',
    // 'ዕዳጋ ዓርቢ',
    'ወረዳ ሓሓይለ': 'ET-TG-HH',
    'ወረዳ ቀይሕ ተኽሊ': 'ET-TG-KT',
    'ወረዳ ኣሕስኣ': 'ET-TG-AH',
    'ወረዳ ዓዴት': 'ET-TG-AD',
    'ወረዳ ዓድዋ': 'ET-TG-AD',
    'ወረዳ እምባስነይቲ': 'ET-TG-SE',
    'ወረዳ እንዳፈላሲ': 'ET-TG-EF',
    'ወረዳ እንዳባፃሕማ': 'ET-TG-EN',
    'ወረዳ እገላ': 'ET-TG-EG',
    'ወረዳ የጭላ ኣበርገለ': 'ET-TG-YA',
    'ወረዳ ጣንቋ ምላሽ': 'ET-TG-TM',
    'ወረዳ ታሕታይ ማይጨው': 'ET-TG-',
    'ከተማ ዓድዋ': 'ET-TG-AK',
    'ወርዳ ጭላ': 'ET-TG-CH',
    'ወረዳ ላዕላይ ማይጨው': 'ET-TG-LM',
    'ወረዳ ናዕዴር': 'ET-TG-ND',
    'ወረዳ ቆላ ተንቤን': 'ET-TG-QT',

    'ከተማ ውቕሮ': 'ET-TG-WQ',
    'ወረዳ ጋንታ አፈሹም': 'ET-TG-GA',
    'ወረዳ ጉሎ መኸዳ': 'ET-TG-GM',
    'ከተማ ዓዲግራት': 'ET-TG-AR',
    'ወረዳ አፅቢ': 'ET-TG-AB',
    'ከተማ ኣፅቢ': 'ET-TG-AT',
    'ወረዳ ፃዕዳ እምባ': 'ET-TG-TE',
    'ወረዳ ኢሮብ': 'ET-TG-ER',
    'ወረዳ ክልተ አውላዕሎ': 'ET-TG-KA',
    'ከተማ ሓውዜን': 'ET-TG-HT',
    'ከተማ ዕዳጋ ሓሙስ': 'ET-TG-EH',
    'ከተማ ዛላምበሳ': 'ET-TG-ZT',
    'ከተማ ፍረወይኒ': 'ET-TG-FT',
    'ወረዳ ሓውዜን': 'ET-TG-HW',
    'ወረዳ ስውሓ ሳዕሲዕ': 'ET-TG-SS',
    'ወረዳ ብዘት': 'ET-TG-BI',
    'ወረዳ ገረዓልታ': 'ET-TG-GE',
    'ወረዳ ፅራእ ወንበርታ': 'ET-TG-TW',

    'ከተማ መኾኒ': 'ET-TG-MT',
    'ከተማ ማይጨው': 'ET-TG-MK',
    'ከተማ ኣላማጣ': 'ET-TG-AM',
    'ከተማ ኮረም': 'ET-TG-KK',
    'ወረዳ ቦራ': 'ET-TG-BR',
    // 'ወረዳ ሕንጣሎ',
    'ወረዳ ሰለዋ': 'ET-TG-SW',
    'ወረዳ ራያ አላማጣ': 'ET-TG-RA',
    'ወረዳ ራያ ዓዘቦ': 'ET-TG-RA',
    'ወረዳ ነቅሰገ': 'ET-TG-NS',
    'ወረዳ አላጀ': 'ET-TG-AG',
    'ወረዳ እንዳመኾኒ': 'ET-TG-ED',
    'ወረዳ ኦፍላ': 'ET-TG-OF',
    // 'ወረዳ ወጀራት',
    'ወረዳ ዛታ': 'ET-TG-ZT',
    'ወረዳ ራያ ጨርጨር': 'ET-TG-RC',

    'ከተማ ሰቲት ሑመራ': 'ET-TG-QH',
    'ከተማ ማይ ካድራ': 'ET-TG-MT',
    'ከተማ ቆራሪት': 'ET-TG-KQ',
    'ከተማ ዳንሻ': 'ET-TG-DT',
    'ወረዳ ቃፍታ ሑመራ': 'ET-TG-HK',
    'ወረዳ ኣውሮራ': 'ET-TG-AR',
    'ወረዳ ወልቃይት': 'ET-TG-WY',
    'ወረዳ ፀገዴ': 'ET-TG-TG',
    'ከተማ ማይ ጋባ': 'ET-TG-MY',

    'ክፍለ ከተማ ሓድነት': 'ET-TG-HD',
    'ክፍለ ከተማ ቀዳማይ ወያነ': 'ET-TG-KW',
    'ክፍለ ከተማ ኲሓ': 'ET-TG-KH',
    'ክፍለ ከተማ ዓዲ ሓቂ': 'ET-TG-AH',
    'ክፍለ ከተማ ዓይደር': 'ET-TG-AY',
    'ክፍለ ከተማ ሓወልቲ': 'ET-TG-HT',
    'ክፍለ ከተማ ሰሜን': 'ET-TG-SN',

    'ከተማ ሃገረሰላም': 'ET-TG-HS',
    'ወረዳ ሰሓርቲ': 'ET-TG-SH',
    'ወረዳ ሳምረ': 'ET-TG-SR',
    'ወረዳ እንደርታ': 'ET-TG-EN',
    'ወረዳ ደጉዓ ተምቤን': 'ET-TG-DT',
    'ከተማ ዓዲ ጉደም': 'ET-TG-AG',
    'ወረዳ ሕንጣሎ': 'ET-TG-HI',
    'ወረዳ ወጀራት': 'ET-TG-WJ',

    // Add more countries and regions as needed
  };

  // final ImagePicker _imagePicker = ImagePicker();
  List<XFile>? _imagesOfheritagePath;
  final ImagePicker _imagePicker = ImagePicker();
  late String _heritageImageDescription;
  late String _heritageImagesDescription;

  late String _heritageNameValue;
  late String _localNameValue;
  final List<String> _classOfHeritage = [];
  late String _regionValue;
  String? _zoneValue;
  String? _weredaValue;
  late String _tabiaValue;
  late String _kushetValue;
  late String _uniqueNameofThePlace;
  late String _previousServiceValue;
  late String _currentServiceValue;
  late String _givenIDValue;
  String? _heritageOwnerValue;
  late String _otherOwnerValue;
  late String _gpsValue;
  late String _eastValue;
  late String _northValue;
  late String _aboveSeaLevelValue;
  late String _nameWhoFindTheHeritageValue;
  DateTime? _dateOfCreation;
  String? _wayOfKnowingHeritageAgeValue;
  late String _currentStatusOfTheHeritageValue;
  late String _heightValue;
  late String _lengthValue;
  late String _breadthValue;
  late String _areaValue;
  late String _diameterValue;
  late String _shapeValue;
  late String _numberOfGatesValue;
  late String _numberOfWindowsValue;
  late String _numberOfClassesValue;
  late String _madeFromValue;
  late String _shortDescriptionOfHeritageValue;
  late String _historyValue;
  late String _cultureValue;
  late String _artValue;
  late String _handCraftValue;
  late String _scienceValue;
  late String _otherUniquenessOfHeritageValue;

  late String _significanceOfHeritageValue;
  String? _statusOfTheHeritageValue;

  late String _otherHeritagesStatus;

  late String _ifDestructedDescriptionOfHeritageDestructionValue;
  String? _conditionOfHeritageDestructionValue;
  late String _descriptionConditionOfHeritageDestructionValue;
  String? _maintenanceValue;
  late String _reasonOfMaintenanceValue;
  late String _maintainedByValue;
  DateTime? _maintainedOn;
  late String _numberOfMaintenanceValue;
  String? _evaluationOnMaintenanceValue;
  DateTime? _startingDateOfSinceAdministeredByCurrentOwner;
  late String _evaluationAnswerDescriptionValue;
  String? _accessibilityOfHeritageValue;
  late String _descriptionOfAccessibilityHeritageValue;
  final List<String> _typesEvidences = [];
  late String _ifOtherTypeEvidenceValue;
  String? _mythValue; //newwwwwwwwwwwwwww
  late String _ifThereIsMyths; //newwwwwwwwwwwww

  late String _keeperNameValue;
  late String _keeperWorkResponsibilityValue;
  // File? _keeperSignatureValue; //new

  late String _heritageInformantNameValue;
  String? _genderValue;
  late String _ageValue;
  late String _workResponsibilityValue;
  late String _otherInformationValue;

  late String _nameOfDataCollector;
  late String _nameOfOrganization;
  late String _position;
  late String _role;
  DateTime? _registrationDateOfHeritage;
  // File? _signatureValue;
  File? _descriptiveImageOfHeritageValue;

  static const List<String> zones = [
    'ዞባ ሰሜን ምዕራብ',
    'ዞባ ማእኸል',
    'ዞባ ምብራቕ',
    'ዞባ ደቡብ',
    'ዞባ ምዕራብ',
    'ዞባ መቐለ',
    'ዞባ ደቡብ ምብራቕ',
    // Add more countries as needed
  ];
  static const Map<String, List<String>> weredas = {
    'ዞባ ሰሜን ምዕራብ': [
      // 'ወረዳ ሰለኽለካ',
      'ወረዳ ታሕታይ ኣድያቦ',
      'ወረዳ ታሕታይ ቆራሮ',
      'ወረዳ ፀለምቲ',
      'ከተማ ሽረ እንዳ ሥላሴ',
      'ከተማ ሸራሮ',
      'ከተማ ዓዲ ዳዕሮ',
      'ወረዳ ኣስገደ',
      'ከተማ እንዳባጉና',
      'ከተማ ማይ ፀብሪ',
      'ወረዳ ሰየምቲ ኣድያቦ',

      'ወረዳ ፅምብላ',
      'ወረዳ ዛና',
      'ወረዳ ላዕላይ ቆራሮ',
      'ወረዳ ማእከላይ ኣድያቦ',
      'ወረዳ ላዕላይ ፀለምቲ',
      // 'ወረዳ ዓዲ ነብሪኢድ',
      // 'ወረዳ ዲማ',

      // Add more regions for Country 1 as needed
    ],
    'ዞባ ማእኸል': [
      'ከተማ አኽሱም',
      'ከተማ ራማ ዓዲ ኣርባዕተ',
      'ከተማ ዓቢይ ዓዲ',
      'ወረዳ ኣሕፈሮም',
      'ከተማ እንትጮ',
      // 'ዕዳጋ ዓርቢ',
      'ወረዳ ሓሓይለ',
      'ወረዳ ቀይሕ ተኽሊ',
      'ወረዳ ኣሕስኣ',
      'ወረዳ ዓዴት',
      'ወረዳ ዓድዋ',
      'ወረዳ እምባስነይቲ',
      'ወረዳ እንዳፈላሲ',
      'ወረዳ እንዳባፃሕማ',
      'ወረዳ እገላ',
      'ወረዳ የጭላ',
      'ወረዳ ጣንቋ ምላሽ',
      'ወረዳ ታሕታይ ማይጨው',
      'ከተማ ዓድዋ',
      'ወርዳ ጭላ',
      'ወረዳ ላዕላይ ማይጨው',
      'ወረዳ ናዕዴር',
      'ወረዳ ቆላ ተንቤን',
    ],
    'ዞባ ምብራቕ': [
      'ከተማ ውቕሮ',
      'ወረዳ ጋንታ አፈሹም',
      'ወረዳ ጉሎ መኸዳ',
      'ከተማ ዓዲግራት',
      'ወረዳ አፅቢ',
      'ከተማ ኣፅቢ',
      'ወረዳ ፃዕዳ እምባ',
      'ወረዳ ኢሮብ',
      'ወረዳ ክልተ አውላዕሎ',
      'ከተማ ሓውዜን',
      'ከተማ ዕዳጋ ሓሙስ',
      'ከተማ ዛላምበሳ',
      'ከተማ ፍረወይኒ',
      'ወረዳ ሓውዜን',
      'ወረዳ ስውሓ ሳዕሲዕ',
      'ወረዳ ብዘት',
      'ወረዳ ገረዓልታ',
      'ወረዳ ፅራእ ወንበርታ',

      // Add more regions for Country 3 as needed
    ],
    'ዞባ ደቡብ': [
      'ከተማ መኾኒ',
      'ከተማ ማይጨው',
      'ከተማ ኣላማጣ',
      'ከተማ ኮረም',
      'ወረዳ ቦራ',
      // 'ወረዳ ሕንጣሎ',
      'ወረዳ ሰለዋ',
      'ወረዳ ራያ አላማጣ',
      'ወረዳ ራያ ዓዘቦ',
      'ወረዳ ነቅሰገ',
      'ወረዳ አላጀ',
      'ወረዳ እንዳመኾኒ',
      'ወረዳ ኦፍላ',
      // 'ወረዳ ወጀራት',
      'ወረዳ ዛታ',
      'ወረዳ ራያ ጨርጨር',
      // Add more regions for Country 3 as needed
    ],
    'ዞባ ምዕራብ': [
      'ከተማ ሰቲት ሑመራ',
      'ከተማ ማይ ካድራ',
      'ከተማ ቆራሪት',
      'ከተማ ዳንሻ',
      'ወረዳ ቃፍታ ሑመራ',
      'ወረዳ ኣውሮራ',
      'ወረዳ ወልቃይት',
      'ወረዳ ፀገዴ',
      'ከተማ ማይ ጋባ',

      // Add more regions for Country 3 as needed
    ],
    'ዞባ መቐለ': [
      'ክፍለ ከተማ ሓድነት',
      'ክፍለ ከተማ ቀዳማይ ወያነ',
      'ክፍለ ከተማ ኲሓ',
      'ክፍለ ከተማ ዓዲ ሓውሲ',
      'ክፍለ ከተማ ዓይደር',
      'ክፍለ ከተማ ሓወልቲ',
      'ክፍለ ከተማ ሰሜን',

      // Add more regions for Country 3 as needed
    ],
    'ዞባ ደቡብ ምብራቕ': [
      'ከተማ ሃገረሰላም',
      'ወረዳ ሰሓርቲ',
      'ወረዳ ሳምረ',
      'ወረዳ እንደርታ',
      'ወረዳ ደጉዓ ተምቤን',
      'ከተማ ዓዲ ጉደም',
      'ወረዳ ሕንጣሎ',
      'ወረዳ ወጀራት',
      // Add more regions for Country 3 as needed
    ],
    // Add more countries and regions as needed
  };
  // Future<void> _pickImage() async {
  //   final pickedImage =
  //       await _imagePicker.pickImage(source: ImageSource.gallery);

  //   if (pickedImage != null) {
  //     setState(() {
  //       _imageOfheritagePath = File(pickedImage.path);
  //     });
  //   }
  // }

  Future<void> _pickImages() async {
    List<XFile> pickedImages = await _imagePicker.pickMultiImage();

    setState(() {
      _imagesOfheritagePath = pickedImages;
    });
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        if (_imagesOfheritagePath == null) {
          _imagesOfheritagePath = [pickedFile];
        } else {
          _imagesOfheritagePath!.add(pickedFile);
        }
      });
    }
  }

  // Future<void> _pickImagee() async {
  //   final pickedImage =
  //       await _imagePicker.pickImage(source: ImageSource.gallery);

  //   if (pickedImage != null) {
  //     setState(() {
  //       _signatureValue = File(pickedImage.path);
  //     });
  //   }
  // }

  // Future<void> _pickImageee() async {
  //   final pickedImage =
  //       await _imagePicker.pickImage(source: ImageSource.gallery);

  //   if (pickedImage != null) {
  //     setState(() {
  //       _keeperSignatureValue = File(pickedImage.path);
  //     });
  //   }
  // }

  Future<void> _pickImagee() async {
    final pickedImage =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _descriptiveImageOfHeritageValue = File(pickedImage.path);
      });
    }
  }

  Future<void> _registerUser() async {
    // Perform any additional form validation here
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();

    const url =
        'https://repositoryformymobapp-kaleab-mezgebe.onrender.com/nonMovableData'; // Replace with your API endpoint

    try {
      final dio = Dio();
      final formData = FormData();
      formData.fields
        ..add(MapEntry('usernameValue', widget.username ?? ''))
        ..add(MapEntry('heritageImageDescription', _heritageImageDescription))
        ..add(MapEntry('heritageNameValue', _heritageNameValue))
        ..add(MapEntry('localNameValue', _localNameValue))
        ..add(MapEntry('heritageImagesDescription', _heritageImagesDescription))
        ..add(MapEntry('classOfHeritageValue',
            _classOfHeritage.isNotEmpty ? _classOfHeritage.join('፣') : ''))
        ..add(MapEntry('regionValue', _regionValue))
        ..add(MapEntry('zoneValue', _zoneValue ?? ''))
        ..add(MapEntry('weredaValue', _weredaValue ?? ''))
        ..add(MapEntry('tabiaValue', _tabiaValue))
        ..add(MapEntry('kushetValue', _kushetValue)) //not set at backend
        ..add(MapEntry(
            'uniqueNameofThePlace', _uniqueNameofThePlace)) //not set at backend
        ..add(MapEntry('previousServiceValue', _previousServiceValue))
        ..add(MapEntry('currentServiceValue', _currentServiceValue))
        ..add(MapEntry('givenIDValue', _givenIDValue))
        ..add(MapEntry('heritageOwnerValue', _heritageOwnerValue ?? ''))
        ..add(MapEntry('otherOwnerValue', _otherOwnerValue))
        ..add(MapEntry('gpsValue', _gpsValue))
        ..add(MapEntry('eastValue', _eastValue))
        ..add(MapEntry('northValue', _northValue))
        ..add(MapEntry('aboveSeaLevelValue', _aboveSeaLevelValue))
        ..add(MapEntry(
            'nameWhoFindTheHeritageValue', _nameWhoFindTheHeritageValue))
        ..add(MapEntry('dateOfCreationValue', _dateOfCreation.toString()))
        ..add(MapEntry('wayOfKnowingHeritageAgeValue',
            _wayOfKnowingHeritageAgeValue ?? ''))
        ..add(MapEntry('currentStatusOfTheHeritageValue',
            _currentStatusOfTheHeritageValue))
        ..add(MapEntry('heightValue', _heightValue))
        ..add(MapEntry('lengthValue', _lengthValue))
        ..add(MapEntry('breadthValue', _breadthValue))
        ..add(MapEntry('areaValue', _areaValue))
        ..add(MapEntry('diameterValue', _diameterValue))
        ..add(MapEntry('shapeValue', _shapeValue))
        ..add(MapEntry('numberOfGatesValue', _numberOfGatesValue))
        ..add(MapEntry('numberOfWindowsValue', _numberOfWindowsValue))
        ..add(MapEntry('numberOfClassesValue', _numberOfClassesValue))
        ..add(MapEntry('madeFromValue', _madeFromValue))
        ..add(MapEntry('shortDescriptionOfHeritageValue',
            _shortDescriptionOfHeritageValue))
        ..add(MapEntry('historyValue', _historyValue))
        ..add(MapEntry('cultureValue', _cultureValue))
        ..add(MapEntry('artValue', _artValue))
        ..add(MapEntry('handCraftValue', _handCraftValue))
        ..add(MapEntry('scienceValue', _scienceValue))
        ..add(MapEntry(
            'otherUniquenessOfHeritageValue', _otherUniquenessOfHeritageValue))
        ..add(MapEntry(
            'significanceOfHeritageValue', _significanceOfHeritageValue))
        ..add(MapEntry(
            'statusOfTheHeritageValue', _statusOfTheHeritageValue ?? ''))
        ..add(MapEntry('otherHeritagesStatus', _otherHeritagesStatus))
        ..add(MapEntry('ifDestructedDescriptionOfHeritageDestructionValue',
            _ifDestructedDescriptionOfHeritageDestructionValue))
        ..add(MapEntry('conditionOfHeritageDestructionValue',
            _conditionOfHeritageDestructionValue ?? ''))
        ..add(MapEntry('descriptionConditionOfHeritageDestructionValue',
            _descriptionConditionOfHeritageDestructionValue))
        ..add(MapEntry('maintenanceValue', _maintenanceValue ?? ''))
        ..add(MapEntry('reasonOfMaintenanceValue', _reasonOfMaintenanceValue))
        ..add(MapEntry('maintainedByValue', _maintainedByValue))
        ..add(MapEntry('maintainedOnValue', _maintainedOn.toString()))
        ..add(MapEntry('numberOfMaintenanceValue', _numberOfMaintenanceValue))
        ..add(MapEntry('evaluationOnMaintenanceValue',
            _evaluationOnMaintenanceValue ?? ''))
        ..add(MapEntry('evaluationAnswerDescriptionValue',
            _evaluationAnswerDescriptionValue))
        ..add(MapEntry('startingDateOfSinceAdministeredByCurrentOwnerValue',
            _startingDateOfSinceAdministeredByCurrentOwner.toString()))
        ..add(MapEntry('accessibilityOfHeritageValue',
            _accessibilityOfHeritageValue ?? ''))
        ..add(MapEntry(
            'descriptionOfAccessibilityHeritageValue', // not set at backend
            _descriptionOfAccessibilityHeritageValue))
        ..add(MapEntry('typesEvidencesValue',
            _typesEvidences.isNotEmpty ? _typesEvidences.join('፣') : ''))
        ..add(MapEntry('ifOtherTypeEvidenceValue', _ifOtherTypeEvidenceValue))
        ..add(MapEntry('mythValue', _mythValue ?? ''))
        ..add(MapEntry('ifThereIsMyths', _ifThereIsMyths))
        ..add(MapEntry('keeperNameValue', _keeperNameValue))
        ..add(MapEntry(
            'keeperWorkResponsibilityValue', _keeperWorkResponsibilityValue))
        ..add(
            MapEntry('heritageInformantNameValue', _heritageInformantNameValue))
        ..add(MapEntry('genderValue', _genderValue ?? ''))
        ..add(MapEntry('ageValue', _ageValue))
        ..add(MapEntry('workResponsibilityValue', _workResponsibilityValue))
        ..add(MapEntry('otherInformationValue', _otherInformationValue))
        ..add(MapEntry('nameOfDataCollector', _nameOfDataCollector))
        ..add(MapEntry('nameOfOrganization', _nameOfOrganization))
        ..add(MapEntry('position', _position))
        ..add(MapEntry('role', _role))
        ..add(MapEntry('registrationDateOfHeritageValue',
            _registrationDateOfHeritage.toString()));
      if (_imagesOfheritagePath != null) {
        for (var image in _imagesOfheritagePath!) {
          formData.files.add(MapEntry(
            'imageOfHeritage',
            MultipartFile.fromBytes(await image.readAsBytes(),
                filename: basename(image.path)),
          ));
        }
      }

      if (_descriptiveImageOfHeritageValue != null) {
        formData.files.add(MapEntry(
          'descriptiveImage',
          MultipartFile.fromBytes(
            File(_descriptiveImageOfHeritageValue!.path).readAsBytesSync(),
            filename: _descriptiveImageOfHeritageValue!.path.split('/').last,
          ),
        ));
      }

      final response = await dio.post(url, data: formData);

      if (response.statusCode == 201) {
        // Registration successful
        // print('User registered successfully');
        ScaffoldMessenger.of(context as BuildContext).showSnackBar(
          const SnackBar(
            content: Text('ምዝገባ ተሳኺዑ'),
          ),
        );
        // Clear the selected image
        // setState(() {
        //   _imageOfheritagePath = null;
        //   _signatureValue = null;
        // });
        // Clear the selected images
        setState(() {
          _imagesOfheritagePath = null;
        });
      } else {
        // Registration failed
        // print('Failed to register user');
        ScaffoldMessenger.of(context as BuildContext).showSnackBar(
          const SnackBar(
            content: Text('ምዝገባ ኣይተሳኽዐን'),
          ),
        );
      }
    } catch (error) {
      // Error occurred
      // print('Error: $error');
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(
        SnackBar(
          content: Text('Error: $error'),
        ),
      );
    }
  }

  void _toggleClassOfHeritage(String classification) {
    setState(() {
      if (_classOfHeritage.contains(classification)) {
        _classOfHeritage.remove(classification);
      } else {
        _classOfHeritage.add(classification);
      }
    });
  }

  void _toggleTypesEvidences(String typeOfEvidences) {
    setState(() {
      if (_typesEvidences.contains(typeOfEvidences)) {
        _typesEvidences.remove(typeOfEvidences);
      } else {
        _typesEvidences.add(typeOfEvidences);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('መመዝገቢ ቅጥዒ'),
        backgroundColor: Colors.blue, // Set the background color to blue
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ElevatedButton(
                            onPressed: _pickImagee,
                            child: const Text('ገላፂ ስእሊ ናይቲ ሓድጊ ኣእትው'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    if (_descriptiveImageOfHeritageValue != null)
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: SizedBox(
                                height: 100,
                                child: Image.file(
                                    _descriptiveImageOfHeritageValue!),
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            const Text('ስእሊ ናይቲ ሓድጊ'),
                          ],
                        ),
                      ),
                  ],
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'መግለፂ ስእሊ ናይቲ ሓድጊ',
                  ),
                  onSaved: (value) {
                    _heritageImageDescription = value!;
                  },
                ),
                const Text("\n1. መፍለይ እቲ ሓድጊ"),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: '1.1 ስም ብትግርኛ',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'በይዘኦም ስም ናይቲ ሓድጊ የእትው ';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _heritageNameValue = value!;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'ፍሉይ ናይ ከባቢ መፀውዒ (እንተሃልይዎ)',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'እንተሃልይዎ ይምልኡ እንተዘይሃልይዎ ድማ የብሉን ኢልኩም ምልኡ ';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _localNameValue = value!;
                  },
                ),

                const Text('\nስእሊ ናይቲ ሓድጊ'),
                ElevatedButton(
                  onPressed: _pickImage,
                  child: const Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.photo_camera),
                      ],
                    ),
                  ),
                ),
                const Text('\n'),
                ElevatedButton(
                  onPressed: _pickImages,
                  child: const Icon(Icons.folder),
                ),
                if (_imagesOfheritagePath != null)
                  Wrap(
                    spacing: 8,
                    children: [
                      for (var i = 0; i < _imagesOfheritagePath!.length; i++)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.file(
                                File(_imagesOfheritagePath![i].path)),
                          ),
                        ),
                    ],
                  ),
                // const SizedBox(height: 16.0),
                // Multiline comment box
                const Text(
                    'መግለፂ ናይቶም ዝመረፅዎም ምስልታት እቲ ሓድጊ(ካብ 2 ንላዕሊ ስእሊ ተመሪፆም ብቕደም ሰዓብን ብ፣ ብምፍላይን መግልፂ የእትው)'),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.0),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(8.0),
                    ),
                    maxLines: null,
                    onSaved: (value) {
                      _heritageImagesDescription = value!;
                    },
                  ),
                ),
                const SizedBox(height: 16.0),
                const Text('\n\n1.2 ምድብ'),
                CheckboxListTile(
                  title: const Text(
                      'ታሪኻዊ ህንፃታት፣ ሓወልትታት፣ ዑናታ፣ ኣብያተ-እምነት፣ ድልድላት፣ በዓትታት፣ መቓብራት፣ ወዘተ  (I)'),
                  value: _classOfHeritage.contains('I'),
                  onChanged: (value) => _toggleClassOfHeritage('I'),
                ),
                CheckboxListTile(
                  title: const Text('ታሪኻዊ ቦታታትን ናይ ተፈጥሮ ከባቢታትን (II)'),
                  value: _classOfHeritage.contains('II'),
                  onChanged: (value) => _toggleClassOfHeritage('II'),
                ),
                CheckboxListTile(
                  title: const Text(
                      'ስእልታት (ኣብ ሃይማኖታዊ ቦታታት፣ በዓቲ፣ መንበሪ ገዛ ወዘተ) (VII)'),
                  value: _classOfHeritage.contains('VII'),
                  onChanged: (value) => _toggleClassOfHeritage('VII'),
                ),
                CheckboxListTile(
                  title: const Text(
                      'ብኳዕቲ ኣርኪዮሎጂ ዝተረከቡ ቅርስታት፣ ቦታታት ስነዃዕትን ስነ-ጥንትን (VIII)'),
                  value: _classOfHeritage.contains('VIII'),
                  onChanged: (value) => _toggleClassOfHeritage('VIII'),
                ),

                const SizedBox(height: 16.0),
                const Text('\n1.3 አድራሻ '),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'ክልል',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'በይዘኦም ዝርከበሉ ክልል ይምልኡ';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _regionValue = value!;
                  },
                ),
                const SizedBox(height: 16.0),
                const Text('ዞባ'),
                DropdownButtonFormField<String>(
                  value: _zoneValue,
                  decoration: const InputDecoration(
                    labelText: 'ካብዞም ዝስዕቡ ዝርዝር ዞባ ይምረፁ',
                  ),
                  items: zones.map((String zonee) {
                    return DropdownMenuItem<String>(
                      value: zonee,
                      child: Text(zonee),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      _zoneValue = value;
                      _weredaValue =
                          null; // Reset birth region when birth country changes
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'በይዘኦም ዝርከበሉ ዞባ ይምረፁ';
                    }
                    return null;
                  },
                  onSaved: (String? value) {
                    _zoneValue = value;
                  },
                ),

                const SizedBox(height: 16.0),
                const Text('ወረዳ'),
                DropdownButtonFormField<String>(
                  value: _weredaValue,
                  decoration: const InputDecoration(
                    labelText: 'ካብዞም ዝስዕቡ ዝርዝር ወረዳታት ይምረፁ',
                  ),
                  items: _zoneValue != null && weredas.containsKey(_zoneValue!)
                      ? weredas[_zoneValue!]!.map((String weredaa) {
                          return DropdownMenuItem<String>(
                            value: weredaa,
                            child: Text(weredaa),
                          );
                        }).toList()
                      : [],
                  onChanged: (String? value) {
                    setState(() {
                      _weredaValue = value;
                    });
                  },
                  onSaved: (String? value) {
                    _weredaValue = value;
                  },
                ),

                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'ጣብያ',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'በይዘኦም ዝርከበሉ ጣብያ ይምልኡ';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _tabiaValue = value!;
                  },
                ),

                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'ቑሸት',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'በይዘኦም ዝርከበሉ ቑሸት ይምልኡ';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _kushetValue = value!;
                  },
                ),

                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'ፍሉይ ሽም ቦታ',
                  ),
                  onSaved: (value) {
                    _uniqueNameofThePlace = value!;
                  },
                ),

                const SizedBox(height: 16.0),
                const Text('\n\n1.4 አገልግሎት'),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'U. ናይ ቕድሚ ሐዚ',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'በይዘኦም ኣብዚ ይምልኡ';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _previousServiceValue = value!;
                  },
                ),

                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'ለ. ናይ ሐዚ (ዝተቐየረ እንተኾይኑ) ',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'በይዘኦም ኣብዚ ይምልኡ';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _currentServiceValue = value!;
                  },
                ),

                const Text('\n1.5 ናይ ቕድሚ ሐዚ መፍለይ ቑፅሪ'),

                TextFormField(
                  initialValue: WeredasIDMap[_weredaValue] ?? '',
                  decoration: const InputDecoration(
                    labelText: 'እንተነይርዎ',
                  ),
                  onTap: () {
                    // Show the initialValue when the TextFormField is tapped
                    if (WeredasIDMap[_weredaValue] != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(WeredasIDMap[_weredaValue]!),
                        ),
                      );
                    } else {
                      // Handle the case where WeredasIDMap[_weredaValue] is null
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('ንዚ $_weredaValue እዚ መፍለዪ ቁፅሪ ኣይተውሃቦን'),
                        ),
                      );
                    }
                  },
                  onSaved: (value) {
                    if (WeredasIDMap[_weredaValue] != null) {
                      _givenIDValue = WeredasIDMap[_weredaValue]!;
                    } else {
                      // Handle the case where WeredasIDMap[_weredaValue] is null
                      _givenIDValue = value!;
                    }
                  },
                ),

                const Text('\n\n2. በዓል ዋና ሓድጊ (ዋንነት)'),
                const SizedBox(height: 16.0),
                const Text('2.1 ናይቲ ሓድጊ በዓል ዋና'),
                ListTile(
                  title: const Text('ናይ ህዝቢ'),
                  leading: Radio<String>(
                    value: 'ናይ ህዝቢ',
                    groupValue: _heritageOwnerValue,
                    onChanged: (value) {
                      setState(() {
                        _heritageOwnerValue = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('ናይ መንግስቲ'),
                  leading: Radio<String>(
                    value: 'ናይ መንግስቲ',
                    groupValue: _heritageOwnerValue,
                    onChanged: (value) {
                      setState(() {
                        _heritageOwnerValue = value;
                      });
                    },
                  ),
                ),

                ListTile(
                  title: const Text('ናይ ኃይማኖት '),
                  leading: Radio<String>(
                    value: 'ናይ ኃይማኖት',
                    groupValue: _heritageOwnerValue,
                    onChanged: (value) {
                      setState(() {
                        _heritageOwnerValue = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('ናይ ውልቀ '),
                  leading: Radio<String>(
                    value: 'ናይ ውልቀ',
                    groupValue: _heritageOwnerValue,
                    onChanged: (value) {
                      setState(() {
                        _heritageOwnerValue = value;
                      });
                    },
                  ),
                ),

                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'ካልእ እንተኾይኑ ይጠቐስ',
                  ),
                  onSaved: (value) {
                    _otherOwnerValue = value!;
                  },
                ),
                const Text('\n2.2 ናይቲ ሓድጊ ናይ ካርታ መረዳእታ'),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'ጁ.ፒ.ኤስ',
                  ),
                  onSaved: (value) {
                    _gpsValue = value!;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'ምብራቕ',
                  ),
                  onSaved: (value) {
                    _eastValue = value!;
                  },
                ),

                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'ሰሜን',
                  ),
                  onSaved: (value) {
                    _northValue = value!;
                  },
                ),

                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'ብራኸ ልዕሊ ፀፍሒ ባሕሪ(ብሜትር)',
                  ),
                  onSaved: (value) {
                    _aboveSeaLevelValue = value!;
                  },
                ),
                const Text('\n\n3. ታሪክ'),
                const Text(
                    '\n3.1 ነቲ ሓድጊ ዘስረሐ፣ ዝሰርሐ፣ ወይ ድማ ዝረኸበ ውልቀ-ሰብ ወይ ኣካል ሽም'),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'ዝፍለጥ እንተኾይኑ',
                  ),
                  onSaved: (value) {
                    _nameWhoFindTheHeritageValue = value!;
                  },
                ),

                const SizedBox(height: 16.0),
                const Text('3.2 እቲ ሓድጊ ዝተሰርሐሉ ጊዜ/ዘመን (ግምታዊ ምቕማጥ ይከኣል)'),
                ListTile(
                  title: Text(
                    _dateOfCreation == null
                        ? 'እዋን/ጊዜ ኣብዚ ይምረፁ'
                        : 'ዝተሰርሐሉ/ዝተረኸበሉ ጊዜ : ${_dateOfCreation.toString().substring(0, 10)}',
                  ),
                  leading: const Icon(Icons.calendar_today),
                  onTap: () => _selectDate(context),
                ),

                const SizedBox(height: 16.0),
                const Text('\n 3.3 ዕድመ እቲ ሓድጊ ዝተነፀረሉ (ዝተፈለጠሉ) መንገዲ'),
                ListTile(
                  title: const Text('ብግምት'),
                  leading: Radio<String>(
                    value: 'ብግምት',
                    groupValue: _wayOfKnowingHeritageAgeValue,
                    onChanged: (value) {
                      setState(() {
                        _wayOfKnowingHeritageAgeValue = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('ብትኽክል '),
                  leading: Radio<String>(
                    value: 'ብትኽክል',
                    groupValue: _wayOfKnowingHeritageAgeValue,
                    onChanged: (value) {
                      setState(() {
                        _wayOfKnowingHeritageAgeValue = value;
                      });
                    },
                  ),
                ),

                ListTile(
                  title: const Text('ብኣንፃራዊ '),
                  leading: Radio<String>(
                    value: 'ብኣንፃራዊ',
                    groupValue: _wayOfKnowingHeritageAgeValue,
                    onChanged: (value) {
                      setState(() {
                        _wayOfKnowingHeritageAgeValue = value;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 16.0),
                // Multiline comment box
                const Text(
                    '\n3.4. ህልው ኩነታት እቲ ሓድጊ (ኩነታት ጉድኣት፣ ወይ ዝኾነ ለውጥታት ዘለዎ እንተኮይኑ፣ ወይ ከምዝነበሮ ድዩ ዘሎ፣ ወዘተ ዝብል) '),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.0),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(8.0),
                    ),
                    maxLines: null,
                    onSaved: (value) {
                      _currentStatusOfTheHeritageValue = value!;
                    },
                  ),
                ),
                const SizedBox(height: 16.0),
                const Text(
                    '3.5 መጠን/ዓቐን እቲ ሓድጊ (ንቲ ሓድጊ ዝምልከቱ ጥራሕ ይምላእ፣ ዘይብሉ ወይ ዘይምልከቶ እንተኾይኑ ኣይምላእን)'),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'ቁመት(ሜ)',
                  ),
                  onSaved: (value) {
                    _heightValue = value!;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'ንውሓት(ሜ)',
                  ),
                  onSaved: (value) {
                    _lengthValue = value!;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'ወርዲ(ሜ)',
                  ),
                  onSaved: (value) {
                    _breadthValue = value!;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'ስፍሓት(ሜ2)',
                  ),
                  onSaved: (value) {
                    _areaValue = value!;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'ዲያሜትር(ሜ)',
                  ),
                  onSaved: (value) {
                    _diameterValue = value!;
                  },
                ),

                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'ቅርፂ',
                  ),
                  onSaved: (value) {
                    _shapeValue = value!;
                  },
                ),

                const Text('\n'),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'በዝሒ መእተዊ በሪ (ዘለዎ እንተኮይኑ)  ',
                  ),
                  onSaved: (value) {
                    _numberOfGatesValue = value!;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'በዝሒ መሳኹቲ (ዘለዎ እንተኮይኑ)  ',
                  ),
                  onSaved: (value) {
                    _numberOfWindowsValue = value!;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'በዝሒ ክፍልታት (ዘለዎ እንተኮይኑ)  ',
                  ),
                  onSaved: (value) {
                    _numberOfClassesValue = value!;
                  },
                ),
                const Text('\n3.6 ዝተሰርሐሉ ኣቕሓ'),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'ካብ ምንታይ ዝተሰርሐ እዩ',
                  ),
                  onSaved: (value) {
                    _madeFromValue = value!;
                  },
                ),

                const SizedBox(height: 16.0),
                // Multiline comment box
                const Text('\n 3.7 ሓፂር መረዳእታ/መብራህረሂ እቲ ሓድጊ፡'),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.0),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(8.0),
                    ),
                    maxLines: null,
                    onSaved: (value) {
                      _shortDescriptionOfHeritageValue = value!;
                    },
                  ),
                ),
                const Text(
                    '\n3.8 እቲ ሓድጊ ፍሉይ ዝገብሮ (ካብቶም ተዘርዚሮም ዘለው ብኣንፃር ኣየናይ እዩ) '),
                const Text('ታሪኽ'),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.0),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(8.0),
                    ),
                    maxLines: null,
                    onSaved: (value) {
                      _historyValue = value!;
                    },
                  ),
                ),
                const Text('ባህሊ'),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.0),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(8.0),
                    ),
                    maxLines: null,
                    onSaved: (value) {
                      _cultureValue = value!;
                    },
                  ),
                ),

                const Text('ስነ-ጥበብ'),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.0),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(8.0),
                    ),
                    maxLines: null,
                    onSaved: (value) {
                      _artValue = value!;
                    },
                  ),
                ),

                const Text('ኢደ-ጥበብ'),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.0),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(8.0),
                    ),
                    maxLines: null,
                    onSaved: (value) {
                      _handCraftValue = value!;
                    },
                  ),
                ),

                const Text('ሳይንስ'),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.0),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(8.0),
                    ),
                    maxLines: null,
                    onSaved: (value) {
                      _scienceValue = value!;
                    },
                  ),
                ),

                const Text('\n ካልእ እንተሃልዩ ተብራህሪሁ ኣብዚ ይቕረብ፡'),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.0),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(8.0),
                    ),
                    maxLines: null,
                    onSaved: (value) {
                      _otherUniquenessOfHeritageValue = value!;
                    },
                  ),
                ),
                const SizedBox(height: 16.0),
                // Multiline comment box
                const Text('\n 3.9 ረብሓ እቲ ሓድጊ (Significance )'),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.0),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(8.0),
                    ),
                    maxLines: null,
                    onSaved: (value) {
                      _significanceOfHeritageValue = value!;
                    },
                  ),
                ),

                const SizedBox(height: 16.0),
                const Text('\n3.10 እቲ ሓድጊ ሐዚ ዘለዎ ኩነታት '),
                ListTile(
                  title: const Text('ፅቡቕ'),
                  leading: Radio<String>(
                    value: 'ፅቡቕ',
                    groupValue: _statusOfTheHeritageValue,
                    onChanged: (value) {
                      setState(() {
                        _statusOfTheHeritageValue = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('ደሓን'),
                  leading: Radio<String>(
                    value: 'ደሓን',
                    groupValue: _statusOfTheHeritageValue,
                    onChanged: (value) {
                      setState(() {
                        _statusOfTheHeritageValue = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('ጉድኣት ዝበፅሖ'),
                  leading: Radio<String>(
                    value: 'ጉድኣት ዝበፅሖ',
                    groupValue: _statusOfTheHeritageValue,
                    onChanged: (value) {
                      setState(() {
                        _statusOfTheHeritageValue = value;
                      });
                    },
                  ),
                ),

                ListTile(
                  title: const Text('ዘይተፈለጠ'),
                  leading: Radio<String>(
                    value: 'ዘይተፈለጠ',
                    groupValue: _statusOfTheHeritageValue,
                    onChanged: (value) {
                      setState(() {
                        _statusOfTheHeritageValue = value;
                      });
                    },
                  ),
                ),

                const SizedBox(height: 16.0),
                // Multiline comment box
                const Text('\n (ጉድኣት ዝበፅሖ እንተኮይኑ ኩነታት ጉድኣት ይገለፅ)'),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.0),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(8.0),
                    ),
                    maxLines: null,
                    onSaved: (value) {
                      _ifDestructedDescriptionOfHeritageDestructionValue =
                          value!;
                    },
                  ),
                ),
                const SizedBox(height: 16.0),
                // Multiline comment box
                const Text('ምስቲ ሓድጊ ዘለው ካልኦት ሓድግታት ኩነታቶም ምግላፅ'),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.0),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(8.0),
                    ),
                    maxLines: null,
                    onSaved: (value) {
                      _otherHeritagesStatus = value!;
                    },
                  ),
                ),
                const SizedBox(height: 16.0),
                const Text('\n\n3.11 ኩነታት ሓደጋ/ስግኣት ኣብቲ ሓድጊ '),
                ListTile(
                  title: const Text('ኣሎ'),
                  leading: Radio<String>(
                    value: 'ኣሎ',
                    groupValue: _conditionOfHeritageDestructionValue,
                    onChanged: (value) {
                      setState(() {
                        _conditionOfHeritageDestructionValue = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('የለን'),
                  leading: Radio<String>(
                    value: 'የለን',
                    groupValue: _conditionOfHeritageDestructionValue,
                    onChanged: (value) {
                      setState(() {
                        _conditionOfHeritageDestructionValue = value;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 16.0),
                // Multiline comment box
                const Text('ኣሎ እንተኮይኑ ኣብዚ ይገለፅ'),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.0),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(8.0),
                    ),
                    maxLines: null,
                    onSaved: (value) {
                      _descriptionConditionOfHeritageDestructionValue = value!;
                    },
                  ),
                ),

                const SizedBox(height: 16.0),
                const Text('\n3.12. ቅድሚ ሐዚ ዝተገበረሉ ናይ ዕቀባን ፅገና ስራሕ  '),
                ListTile(
                  title: const Text('ኣሎ'),
                  leading: Radio<String>(
                    value: 'ኣሎ',
                    groupValue: _maintenanceValue,
                    onChanged: (value) {
                      setState(() {
                        _maintenanceValue = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('የለን'),
                  leading: Radio<String>(
                    value: 'የለን',
                    groupValue: _maintenanceValue,
                    onChanged: (value) {
                      setState(() {
                        _maintenanceValue = value;
                      });
                    },
                  ),
                ),
                const Text('\nናይ ፅገና ስራሕ ተካይድሉ ዝነበረ እንተኮይኑ፤'),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: ' ምኽንያት ፅገናኡ  ',
                  ),
                  onSaved: (value) {
                    _reasonOfMaintenanceValue = value!;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: ' ዝፀገኖ ኣካል(ነቲ ፅገና ዘካየደ ኣካል)',
                  ),
                  onSaved: (value) {
                    _maintainedByValue = value!;
                  },
                ),

                const SizedBox(height: 16.0),
                const Text('ፅገና ዝተካየደሉ እዋን'),
                ListTile(
                  title: Text(
                    _maintainedOn == null
                        ? 'እዋን/ጊዜ ኣብዚ ይምረፁ'
                        : 'ፅገና ዝተካየደሉ ዕለት: ${_maintainedOn.toString().substring(0, 10)}',
                  ),
                  leading: const Icon(Icons.calendar_today),
                  onTap: () => _selectDate(context),
                ),

                const Text('\nፅገና ዝተካየደሉ በዝሒ ጊዜ'),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: ' ሓንቲ፣ ክልተ፣ ሰለስተ፣ ብዙሕ ጊዜ',
                  ),
                  onSaved: (value) {
                    _numberOfMaintenanceValue = value!;
                  },
                ),

                const SizedBox(height: 16.0),
                const Text('\n3.12.1 ግምገማ እቲ ዝተገበረ ናይ ፅገና/ምዕቃብ ስራሕ ከመይ ኔሩ ? '),
                ListTile(
                  title: const Text(' ብጣዕሚ ፅቡቕ'),
                  leading: Radio<String>(
                    value: 'ብጣዕሚ ፅቡቕ',
                    groupValue: _evaluationOnMaintenanceValue,
                    onChanged: (value) {
                      setState(() {
                        _evaluationOnMaintenanceValue = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('ፅቡቕ'),
                  leading: Radio<String>(
                    value: 'ፅቡቕ',
                    groupValue: _evaluationOnMaintenanceValue,
                    onChanged: (value) {
                      setState(() {
                        _evaluationOnMaintenanceValue = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('ማእኸላይ'),
                  leading: Radio<String>(
                    value: 'ማእኸላይ',
                    groupValue: _evaluationOnMaintenanceValue,
                    onChanged: (value) {
                      setState(() {
                        _evaluationOnMaintenanceValue = value;
                      });
                    },
                  ),
                ),

                ListTile(
                  title: const Text('ትሑት'),
                  leading: Radio<String>(
                    value: 'ትሑት',
                    groupValue: _evaluationOnMaintenanceValue,
                    onChanged: (value) {
                      setState(() {
                        _evaluationOnMaintenanceValue = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('ብጣዕሚ ትሑት'),
                  leading: Radio<String>(
                    value: 'ብጣዕሚ ትሑት',
                    groupValue: _evaluationOnMaintenanceValue,
                    onChanged: (value) {
                      setState(() {
                        _evaluationOnMaintenanceValue = value;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 16.0),
                // Multiline comment box
                const Text('\n ሕድሕድ መልሲ ብእኩልን ብቑዕን ምክንያት ኣብዚ ይደገፍ/ይገለፅ)'),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.0),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(8.0),
                    ),
                    maxLines: null,
                    onSaved: (value) {
                      _evaluationAnswerDescriptionValue = value!;
                    },
                  ),
                ),

                const SizedBox(height: 16.0),
                const Text('\n3.13 እቲ ሓድጊ በቲ ናይ ሐዚ ብበዓል ዋና ምምሕዳር ዝጀመረሉ እዋን'),
                ListTile(
                  title: Text(
                    _startingDateOfSinceAdministeredByCurrentOwner == null
                        ? 'እዋን/ጊዜ ኣብዚ ይምረፁ'
                        : 'ብናይ ሐዚ በዓል ዋና ምምሕዳር ዝጀመረሉ እዋን: ${_startingDateOfSinceAdministeredByCurrentOwner.toString().substring(0, 10)}',
                  ),
                  leading: const Icon(Icons.calendar_today),
                  onTap: () => _selectDate(context),
                ),

                const SizedBox(height: 16.0),
                const Text('\n3.14 ተበፃሓይነት እቲ ሓድጊ'),
                ListTile(
                  title: const Text(' ብጣዕሚ ፅቡቕ'),
                  leading: Radio<String>(
                    value: 'ብጣዕሚ ፅቡቕ',
                    groupValue: _accessibilityOfHeritageValue,
                    onChanged: (value) {
                      setState(() {
                        _accessibilityOfHeritageValue = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('ፅቡቕ'),
                  leading: Radio<String>(
                    value: 'ፅቡቕ',
                    groupValue: _accessibilityOfHeritageValue,
                    onChanged: (value) {
                      setState(() {
                        _accessibilityOfHeritageValue = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('ማእኸላይ'),
                  leading: Radio<String>(
                    value: 'ማእኸላይ',
                    groupValue: _accessibilityOfHeritageValue,
                    onChanged: (value) {
                      setState(() {
                        _accessibilityOfHeritageValue = value;
                      });
                    },
                  ),
                ),

                ListTile(
                  title: const Text('ትሑት'),
                  leading: Radio<String>(
                    value: 'ትሑት',
                    groupValue: _accessibilityOfHeritageValue,
                    onChanged: (value) {
                      setState(() {
                        _accessibilityOfHeritageValue = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('ብጣዕሚ ትሑት'),
                  leading: Radio<String>(
                    value: 'ብጣዕሚ ትሑት',
                    groupValue: _accessibilityOfHeritageValue,
                    onChanged: (value) {
                      setState(() {
                        _accessibilityOfHeritageValue = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('የብሉን'),
                  leading: Radio<String>(
                    value: 'የብሉን',
                    groupValue: _accessibilityOfHeritageValue,
                    onChanged: (value) {
                      setState(() {
                        _accessibilityOfHeritageValue = value;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 16.0),
                // Multiline comment box
                const Text('\n ሕድሕድ መልሲ ብእኩልን ብቑዕን ምክንያት ኣብዚ ይደገፍ/ይገለፅ)'),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.0),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(8.0),
                    ),
                    maxLines: null,
                    onSaved: (value) {
                      _descriptionOfAccessibilityHeritageValue = value!;
                    },
                  ),
                ),

                const SizedBox(height: 16.0),
                const Text('\n\n4. ተዛመድቲ መረዳእታታት እቲ ሓድጊ (ዘለውዎ እንተኮይኖም)'),

                CheckboxListTile(
                  title: const Text('መፅሓፍ'),
                  value: _typesEvidences.contains('መፅሓፍ'),
                  onChanged: (value) => _toggleTypesEvidences('መፅሓፍ'),
                ),
                CheckboxListTile(
                  title: const Text('ስእሊ/ፎቶ'),
                  value: _typesEvidences.contains('ስእሊ/ፎቶ'),
                  onChanged: (value) => _toggleTypesEvidences('ስእሊ/ፎቶ'),
                ),
                CheckboxListTile(
                  title: const Text('ካርታ'),
                  value: _typesEvidences.contains('ካርታ'),
                  onChanged: (value) => _toggleTypesEvidences('ካርታ'),
                ),
                CheckboxListTile(
                  title: const Text('መዝገብ'),
                  value: _typesEvidences.contains('መዝገብ'),
                  onChanged: (value) => _toggleTypesEvidences('መዝገብ'),
                ),
                CheckboxListTile(
                  title: const Text('ሰነድ'),
                  value: _typesEvidences.contains('ሰነድ'),
                  onChanged: (value) => _toggleTypesEvidences('ሰነድ'),
                ),
                CheckboxListTile(
                  title: const Text('ፕላን'),
                  value: _typesEvidences.contains('ፕላን'),
                  onChanged: (value) => _toggleTypesEvidences('ፕላን'),
                ),
                const SizedBox(height: 16.0),
                // Multiline comment box
                const Text('\n ካልእ እንተሃልዩ ብፍሉይ ኣብዚ ይጠቐስ፡'),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.0),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(8.0),
                    ),
                    maxLines: null,
                    onSaved: (value) {
                      _ifOtherTypeEvidenceValue = value!;
                    },
                  ),
                ),

                const Text('4.1. መረዳእታ አፈ ታሪኽ ናይቲ ሓድጊ ወይ ሓድጊ ቦታ'),
                ListTile(
                  title: const Text('ኣለዎ'),
                  leading: Radio<String>(
                    value: 'ኣለዎ',
                    groupValue: _mythValue,
                    onChanged: (value) {
                      setState(() {
                        _mythValue = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('የብሉን'),
                  leading: Radio<String>(
                    value: 'የብሉን',
                    groupValue: _mythValue,
                    onChanged: (value) {
                      setState(() {
                        _mythValue = value;
                      });
                    },
                  ),
                ),
                const Text('ዘለዎ እንተኮይኑ እቲ ኣፈ-ታሪክ ብሓፂሩ ኣብዚ ይጠቐስ፤'),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.0),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(8.0),
                    ),
                    maxLines: null,
                    onSaved: (value) {
                      _ifThereIsMyths = value!;
                    },
                  ),
                ),

                const SizedBox(height: 16.0),
                const Text('\n5. ሓላዊ እቲ ሓድጊ/ሓድጊ ቦታ'),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: '5.1 ሽም',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'በይዘኦም ሽም ይምልኡ';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _keeperNameValue = value!;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: '5.2 ስራሕ ሓላፍነት',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'በይዘኦም ስራሕ ሓላፍነት ይምልኡ';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _keeperWorkResponsibilityValue = value!;
                  },
                ),

                // const Text('\n5.3 ፌርማ'),
                // ElevatedButton(
                //   onPressed: _pickImageee,
                //   child: const Text('ፌርማ ካብ ፋይል ተጠቐም/ሚ'),
                // ),
                // const SizedBox(
                //     height: 16.0), // Add a vertical space of 16 pixels
                // if (_keeperSignatureValue != null)
                //   ClipRRect(
                //     borderRadius: BorderRadius.circular(10.0),
                //     child: SizedBox(
                //       height: 100,
                //       width: 100,
                //       child: Image.file(_keeperSignatureValue!),
                //     ),
                //   ),

                const SizedBox(height: 16.0),
                const Text('\n6. መረዳእታ ወሃቢ ኣካል'),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: '6.1 ሽም',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'በይዘኦም ሽም ይምልኡ';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _heritageInformantNameValue = value!;
                  },
                ),

                const SizedBox(height: 16.0),
                const Text('6.2 ፆታ'),
                ListTile(
                  title: const Text('ወዲ ተባዕታይ'),
                  leading: Radio<String>(
                    value: 'ወዲ ተባዕታይ ',
                    groupValue: _genderValue,
                    onChanged: (value) {
                      setState(() {
                        _genderValue = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('ጓል ኣንስተይቲ'),
                  leading: Radio<String>(
                    value: 'ጓል ኣንስተይቲ',
                    groupValue: _genderValue,
                    onChanged: (value) {
                      setState(() {
                        _genderValue = value;
                      });
                    },
                  ),
                ),

                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: '6.3 ዕድመ',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'በይዘኦም ዕድመ ይምልኡ';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _ageValue = value!;
                  },
                ),

                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: '6.4 ስራሕ ሓላፍነት',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'በይዘኦም ስራሕ ሓላፍነት ይምልኡ';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _workResponsibilityValue = value!;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: '6.5 ካልእ',
                  ),
                  onSaved: (value) {
                    _otherInformationValue = value!;
                  },
                ),

                const SizedBox(height: 16.0),
                const Text('\n7. ናይ መዝጋቢ መረዳእታ'),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: '7.1 ሽም',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'በይዘኦም ሽም ይምልኡ';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _nameOfDataCollector = value!;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: '7.2 ሽም ዝሰርሕሉ ትካል ',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ሽም ዝሰርሕሉ ትካል ምልኡ';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _nameOfOrganization = value!;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: '7.3 መደብ ስራሕ ',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'መደብ ስራሕ ይምልኡ';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _position = value!;
                  },
                ),

                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: '7.4 ስራሕ ሓላፍነት',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'በይዘኦም ስራሕ ሓላፍነት ይምልኡ';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _role = value!;
                  },
                ),

                // const Text('\nፌርማ'),
                // ElevatedButton(
                //   onPressed: _pickImagee,
                //   child: const Text('ፌርማ ካብ ፋይል ተጠቐም/ሚ'),
                // ),
                // const SizedBox(
                //     height: 16.0), // Add a vertical space of 16 pixels
                // if (_signatureValue != null)
                //   ClipRRect(
                //     borderRadius: BorderRadius.circular(10.0),
                //     child: SizedBox(
                //       height: 100,
                //       width: 100,
                //       child: Image.file(_signatureValue!),
                //     ),
                //   ),

                const SizedBox(height: 16.0),
                const Text('7.5 እቲ ሓድጊ ዝተመዝገበሉ መዓልቲ '),
                ListTile(
                  title: Text(
                    _registrationDateOfHeritage == null
                        ? 'ሰሌዳ ጊዜ'
                        : 'ሓድጊ ዝተመዝገበሉ መዓልቲ: ${_registrationDateOfHeritage.toString().substring(0, 10)}',
                  ),
                  leading: const Icon(Icons.calendar_today),
                  onTap: () => _selectDate(context),
                ),

                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      _registerUser();
                      _formKey.currentState!.reset(); // Add this line
                    }
                  },
                  child: const Text('መዝግብ'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(0),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dateOfCreation = picked;
      });
    }
    if (picked != null) {
      setState(() {
        _startingDateOfSinceAdministeredByCurrentOwner = picked;
      });
    }
    if (picked != null) {
      setState(() {
        _registrationDateOfHeritage = picked;
      });
    }
    if (picked != null) {
      setState(() {
        _maintainedOn = picked;
      });
    }
  }
}
