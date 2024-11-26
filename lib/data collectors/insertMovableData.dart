import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class RegistrationFormMovableData extends StatefulWidget {
  // const RegistrationFormMovableData({super.key});
  final String? username;
  const RegistrationFormMovableData({super.key, required this.username});

  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationFormMovableData> {
  final _formKey = GlobalKey<FormState>();

  // File? _imageOfheritagePath;
  // final ImagePicker _imagePicker = ImagePicker();

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

  List<XFile>? _imagesOfheritagePath;
  final ImagePicker _imagePicker = ImagePicker();

  late String _heritageImageDescription;
  late String _heritageNameValue;
  late String _localNameValue;
  late String _heritageImagesDescription;

  final List<String> _classOfHeritage = [];
  late String _regionValue;
  String? _zoneValue;
  String? _weredaValue = '';
  late String _tabiaValue;
  late String _kushetValue;
  late String _uniqueNameofThePlace;
  late String _previousServiceValue;
  late String _currentServiceValue;
  late String _givenIDValue = '';
  String? _heritageOwnerValue;
  late String _otherOwnerValue;
  late String _nameOfHeritageOwnerValue;
  String? _placeOfTheHeritageValue;
  late String _otherPlaceValue;
  late String _nameWhoFindTheHeritageValue;
  DateTime? _dateOfCreation;
  String? _wayOfKnowingHeritageAgeValue;
  String? _wayOfHeritageFindingValue;
  late String _currentStatusOfTheHeritageValue;
  late String _heightValue;
  late String _lengthValue;
  late String _breadthValue;
  late String _areaValue;
  late String _diameterValue;
  late String _thicknessValue;
  late String _shapeValue;
  late String _colorValue;
  late String _numberOfPagesValue;
  late String _numberOfWordsValue;
  late String _numberOfPhrasesValue;
  late String _numberOfPicturesValue;
  late String _numberPillarsValue;
  String? _decorationValue;
  late String _hasDecorationValue;
  final List<String> _madeFrom = [];
  late String _madeFromOtherValue;
  late String _shortDescriptionOfHeritageValue;
  final List<String> _uniquenessOfHeritage = [];
  late String _otherUniquenessOfHeritageValue;
  late String _significanceOfHeritageValue;
  String? _statusOfTheHeritageValue;
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
//  File? _signatureValue;
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

  Future<void> _pickImagee() async {
    final pickedImage =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _descriptiveImageOfHeritageValue = File(pickedImage.path);
      });
    }
  }

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

  Future<void> _registerUser() async {
    // Perform any additional form validation here
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();

    const url =
        'https://repositoryformymobapp-kaleab-mezgebe.onrender.com/movableData'; // Replace with your API endpoint

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
        ..add(MapEntry('nameOfHeritageOwnerValue', _nameOfHeritageOwnerValue))
        ..add(
            MapEntry('placeOfTheHeritageValue', _placeOfTheHeritageValue ?? ''))
        ..add(MapEntry('otherPlaceValue', _otherPlaceValue))
        ..add(MapEntry(
            'nameWhoFindTheHeritageValue', _nameWhoFindTheHeritageValue))
        ..add(MapEntry('dateOfCreationValue', _dateOfCreation.toString()))
        ..add(MapEntry('wayOfKnowingHeritageAgeValue',
            _wayOfKnowingHeritageAgeValue ?? ''))
        ..add(MapEntry(
            'wayOfHeritageFindingValue', _wayOfHeritageFindingValue ?? ''))
        ..add(MapEntry('currentStatusOfTheHeritageValue',
            _currentStatusOfTheHeritageValue))
        ..add(MapEntry('heightValue', _heightValue))
        ..add(MapEntry('lengthValue', _lengthValue))
        ..add(MapEntry('breadthValue', _breadthValue))
        ..add(MapEntry('areaValue', _areaValue))
        ..add(MapEntry('diameterValue', _diameterValue))
        ..add(MapEntry('thicknessValue', _thicknessValue))
        ..add(MapEntry('shapeValue', _shapeValue))
        ..add(MapEntry('colorValue', _colorValue))
        ..add(MapEntry('numberOfPagesValue', _numberOfPagesValue))
        ..add(MapEntry('numberOfWordsValue', _numberOfWordsValue))
        ..add(MapEntry('numberOfPhrasesValue', _numberOfPhrasesValue))
        ..add(MapEntry('numberOfPicturesValue', _numberOfPicturesValue))
        ..add(MapEntry('numberPillarsValue', _numberPillarsValue))
        ..add(MapEntry('decorationValue', _decorationValue ?? ''))
        ..add(MapEntry(
            'hasDecorationValue', _hasDecorationValue)) // not set at backend
        ..add(MapEntry(
            'madeFromValue', _madeFrom.isNotEmpty ? _madeFrom.join('፣') : ''))
        ..add(MapEntry('madeFromOtherValue', _madeFromOtherValue))
        ..add(MapEntry('shortDescriptionOfHeritageValue',
            _shortDescriptionOfHeritageValue))
        ..add(MapEntry(
            'uniquenessOfHeritageValue',
            _uniquenessOfHeritage.isNotEmpty
                ? _uniquenessOfHeritage.join('፣')
                : ''))
        ..add(MapEntry(
            'otherUniquenessOfHeritageValue', _otherUniquenessOfHeritageValue))
        ..add(MapEntry(
            'significanceOfHeritageValue', _significanceOfHeritageValue))
        ..add(MapEntry(
            'statusOfTheHeritageValue', _statusOfTheHeritageValue ?? ''))
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

        setState(() {
          _imagesOfheritagePath = null;
        });
      } else {
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

  void _toggleMadeFrom(String made) {
    setState(() {
      if (_madeFrom.contains(made)) {
        _madeFrom.remove(made);
      } else {
        _madeFrom.add(made);
      }
    });
  }

  void _toggleUniquenessOfHeritage(String uniqueness) {
    setState(() {
      if (_uniquenessOfHeritage.contains(uniqueness)) {
        _uniquenessOfHeritage.remove(uniqueness);
      } else {
        _uniquenessOfHeritage.add(uniqueness);
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
                  onSaved: (value) {
                    _localNameValue = value!;
                  },
                ),

                const Text('\nተወሰኽቲ ስእሊታት ናይቲ ሓድጊ'),
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
                  title: const Text('ውፅኢታት ጥበብ፣ ስእልታት፣ ቅርፃቕርፂ ወዘተ (III)'),
                  value: _classOfHeritage.contains('III'),
                  onChanged: (value) => _toggleClassOfHeritage('III'),
                ),
                CheckboxListTile(
                  title: const Text('መፃሕፍትን ሰነዳትን (IV)'),
                  value: _classOfHeritage.contains('IV'),
                  onChanged: (value) => _toggleClassOfHeritage('IV'),
                ),
                CheckboxListTile(
                  title: const Text(
                      'ናይ ባህሊ ናውቲ፣ኣልባሳት፣ናይ ጦር መሳርሒታት፣ቅርፃ ቅርፅታት፣መጋየፅታት ሃይማኖታዊን ዓለማዊን መገልገሊ ናውቲ (V) '),
                  value: _classOfHeritage.contains('V'),
                  onChanged: (value) => _toggleClassOfHeritage('V'),
                ),
                CheckboxListTile(
                  title: const Text(
                      'ብዃዕቲ ዝተረኸቡ ተንቀሳቐስቲ ሓድግታት ስነ-ጥንትን ኣርኪኦሎጅን (ርካቦታት ስነ-ጥንትን ኣርኪኦሎጅን) (VI)'),
                  value: _classOfHeritage.contains('VI'),
                  onChanged: (value) => _toggleClassOfHeritage('VI'),
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
                      return 'በይዘኦም ምረፁ ';
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
                      // _givenIDValue = WeredasIDMap[_weredaValue]!;
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
                  onSaved: (value) {
                    _previousServiceValue = value!;
                  },
                ),

                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'ለ. ናይ ሐዚ (ዝተቐየረ እንተኾይኑ) ',
                  ),
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

                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: '2.2 ናይ እቲ ሓድጊ በዓል ዋና ወይ ትካል ሽም ',
                  ),
                  onSaved: (value) {
                    _nameOfHeritageOwnerValue = value!;
                  },
                ),

                const SizedBox(height: 16.0),
                const Text('\n 2.3 እቲ ሓድጊ ዝርከበሉ ቀዋሚ ቦታ'),
                ListTile(
                  title: const Text('ሙዝየም'),
                  leading: Radio<String>(
                    value: 'ሙዝየም',
                    groupValue: _placeOfTheHeritageValue,
                    onChanged: (value) {
                      setState(() {
                        _placeOfTheHeritageValue = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('መኽዝን(ግምጃ ቤት) '),
                  leading: Radio<String>(
                    value: 'መኽዝን(ግምጃ ቤት)',
                    groupValue: _placeOfTheHeritageValue,
                    onChanged: (value) {
                      setState(() {
                        _placeOfTheHeritageValue = value;
                      });
                    },
                  ),
                ),

                ListTile(
                  title: const Text('ቤተ-እምነት '),
                  leading: Radio<String>(
                    value: 'ቤተ-እምነት',
                    groupValue: _placeOfTheHeritageValue,
                    onChanged: (value) {
                      setState(() {
                        _placeOfTheHeritageValue = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('ውልቀ-ገዛ '),
                  leading: Radio<String>(
                    value: 'ውልቀ-ገዛ',
                    groupValue: _placeOfTheHeritageValue,
                    onChanged: (value) {
                      setState(() {
                        _placeOfTheHeritageValue = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('ግዝያዊ መዕቖቢ/መፅንሒ '),
                  leading: Radio<String>(
                    value: 'ግዝያዊ መዕቖቢ/መፅንሒ',
                    groupValue: _placeOfTheHeritageValue,
                    onChanged: (value) {
                      setState(() {
                        _placeOfTheHeritageValue = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('ቤት-ፅሕፈት መንግስቲ/ትካል '),
                  leading: Radio<String>(
                    value: 'ቤት-ፅሕፈት መንግስቲ/ትካል',
                    groupValue: _placeOfTheHeritageValue,
                    onChanged: (value) {
                      setState(() {
                        _placeOfTheHeritageValue = value;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'ካልእ ይጠቐስ',
                  ),
                  onSaved: (value) {
                    _otherPlaceValue = value!;
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
                const Text('\n 3.4 እቲ ሓድጊ ዝተረኸበሉ ኩነታት'),
                ListTile(
                  title: const Text('ብዃዕቲ'),
                  leading: Radio<String>(
                    value: 'ብዃዕቲ',
                    groupValue: _wayOfHeritageFindingValue,
                    onChanged: (value) {
                      setState(() {
                        _wayOfHeritageFindingValue = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('ብውህብቶ '),
                  leading: Radio<String>(
                    value: 'ብውህብቶ',
                    groupValue: _wayOfHeritageFindingValue,
                    onChanged: (value) {
                      setState(() {
                        _wayOfHeritageFindingValue = value;
                      });
                    },
                  ),
                ),

                ListTile(
                  title: const Text('ብውርሲ '),
                  leading: Radio<String>(
                    value: 'ብውርሲ',
                    groupValue: _wayOfHeritageFindingValue,
                    onChanged: (value) {
                      setState(() {
                        _wayOfHeritageFindingValue = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('ብዕድጊት'),
                  leading: Radio<String>(
                    value: 'ብዕድጊት',
                    groupValue: _wayOfHeritageFindingValue,
                    onChanged: (value) {
                      setState(() {
                        _wayOfHeritageFindingValue = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('ብልቓሕ '),
                  leading: Radio<String>(
                    value: 'ብልቓሕ',
                    groupValue: _wayOfHeritageFindingValue,
                    onChanged: (value) {
                      setState(() {
                        _wayOfHeritageFindingValue = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('ብሓደራ '),
                  leading: Radio<String>(
                    value: 'ብሓደራ',
                    groupValue: _wayOfHeritageFindingValue,
                    onChanged: (value) {
                      setState(() {
                        _wayOfHeritageFindingValue = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('ኣይፍለጥን '),
                  leading: Radio<String>(
                    value: 'ኣይፍለጥን',
                    groupValue: _wayOfHeritageFindingValue,
                    onChanged: (value) {
                      setState(() {
                        _wayOfHeritageFindingValue = value;
                      });
                    },
                  ),
                ),

                const SizedBox(height: 16.0),
                // Multiline comment box
                const Text(
                    '\n3.5. ህልው ኩነታት እቲ ሓድጊ (ኩነታት ጉድኣት፣ ወይ ዝኾነ ለውጥታት ዘለዎ እንተኮይኑ፣ ወይ ከምዝነበሮ ድዩ ዘሎ፣ ወዘተ ዝብል) '),
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
                    '3.6 መጠን/ዓቐን እቲ ሓድጊ (ንቲ ሓድጊ ዝምልከቱ ጥራሕ ይምላእ፣ ዘይብሉ ወይ ዘይምልከቶ እንተኾይኑ ኣይምላእን)'),
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
                    labelText: 'ርጉዲ',
                  ),
                  onSaved: (value) {
                    _thicknessValue = value!;
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
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'ሕብሪ',
                  ),
                  onSaved: (value) {
                    _colorValue = value!;
                  },
                ),
                const Text('\n'),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'በዝሒ ገፅ (ዘለዎ እንተኮይኑ)  ',
                  ),
                  onSaved: (value) {
                    _numberOfPagesValue = value!;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'በዝሒ ቃላት (ዘለዎ እንተኮይኑ)  ',
                  ),
                  onSaved: (value) {
                    _numberOfWordsValue = value!;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'በዝሒ ሓረጋት (ዘለዎ እንተኮይኑ)  ',
                  ),
                  onSaved: (value) {
                    _numberOfPhrasesValue = value!;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'በዝሒ ስእልታት (ዘለዎ እንተኮይኑ)  ',
                  ),
                  onSaved: (value) {
                    _numberOfPicturesValue = value!;
                  },
                ),

                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'በዝሒ ዓምድታት (ንመፅሓፍ እንተሃሊይዎ)',
                  ),

                  // },
                  onSaved: (value) {
                    _numberPillarsValue = value!;
                  },
                ),
                const Text('\n\n3.7 መመላኽዒ'),
                const SizedBox(height: 16.0),
                ListTile(
                  title: const Text('ኣለዎ'),
                  leading: Radio<String>(
                    value: 'ኣለዎ',
                    groupValue: _decorationValue,
                    onChanged: (value) {
                      setState(() {
                        _decorationValue = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('የብሉን'),
                  leading: Radio<String>(
                    value: 'የብሉን',
                    groupValue: _decorationValue,
                    onChanged: (value) {
                      setState(() {
                        _decorationValue = value;
                      });
                    },
                  ),
                ),

                const SizedBox(height: 16.0),
                // Multiline comment box
                const Text('\n ኣለዎ እንተኾይኑ ዝርዝሩ ኣብዚ ይጠቐስ፤'),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.0),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'ኣብዚ ይጠቐስ',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(8.0),
                    ),
                    maxLines: null,
                    onSaved: (value) {
                      _hasDecorationValue = value!;
                    },
                  ),
                ),

                const SizedBox(height: 16.0),
                const Text('\n3.8 ዝተሰርሐሉ ኣቕሓ (ካብ ምንታይ ዝተሰርሐ እዩ)'),
                CheckboxListTile(
                  title: const Text('ወርቂ'),
                  value: _madeFrom.contains('ወርቂ'),
                  onChanged: (value) => _toggleMadeFrom('ወርቂ'),
                ),
                CheckboxListTile(
                  title: const Text('ብሪ'),
                  value: _madeFrom.contains('ብሪ'),
                  onChanged: (value) => _toggleMadeFrom('ብሪ'),
                ),
                CheckboxListTile(
                  title: const Text('ነሓስ'),
                  value: _madeFrom.contains('ነሓስ'),
                  onChanged: (value) => _toggleMadeFrom('ነሓስ'),
                ),
                CheckboxListTile(
                  title: const Text('ሓፂን'),
                  value: _madeFrom.contains('ሓፂን'),
                  onChanged: (value) => _toggleMadeFrom('ሓፂን'),
                ),
                CheckboxListTile(
                  title: const Text('ዕንፀይቲ'),
                  value: _madeFrom.contains('ዕንፀይቲ'),
                  onChanged: (value) => _toggleMadeFrom('ዕንፀይቲ'),
                ),
                CheckboxListTile(
                  title: const Text('ጭቃ/ሸኽላ'),
                  value: _madeFrom.contains('ጭቃ/ሸኽላ'),
                  onChanged: (value) => _toggleMadeFrom('ጭቃ/ሸኽላ'),
                ),
                CheckboxListTile(
                  title: const Text('እምኒ'),
                  value: _madeFrom.contains('እምኒ'),
                  onChanged: (value) => _toggleMadeFrom('እምኒ'),
                ),
                CheckboxListTile(
                  title: const Text('ጨርቂ'),
                  value: _madeFrom.contains('ጨርቂ'),
                  onChanged: (value) => _toggleMadeFrom('ጨርቂ'),
                ),
                CheckboxListTile(
                  title: const Text('ቖርበት'),
                  value: _madeFrom.contains('ቖርበት'),
                  onChanged: (value) => _toggleMadeFrom('ቖርበት'),
                ),
                CheckboxListTile(
                  title: const Text('ቐርኒ'),
                  value: _madeFrom.contains('ቐርኒ'),
                  onChanged: (value) => _toggleMadeFrom('ቐርኒ'),
                ),
                CheckboxListTile(
                  title: const Text('ወረቐት'),
                  value: _madeFrom.contains('ወረቐት'),
                  onChanged: (value) => _toggleMadeFrom('ወረቐት'),
                ),

                CheckboxListTile(
                  title: const Text('መስተዋት'),
                  value: _madeFrom.contains('መስተዋት'),
                  onChanged: (value) => _toggleMadeFrom('መስተዋት'),
                ),
                CheckboxListTile(
                  title: const Text('ጎማ'),
                  value: _madeFrom.contains('ጎማ'),
                  onChanged: (value) => _toggleMadeFrom('ጎማ'),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'ካልእ (ይጠቐስ)',
                  ),
                  onSaved: (value) {
                    _madeFromOtherValue = value!;
                  },
                ),

                const SizedBox(height: 16.0),
                // Multiline comment box
                const Text('\n 3.9 ሓፂር መረዳእታ/መብራህረሂ እቲ ሓድጊ፡'),
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

                const SizedBox(height: 16.0),
                const Text('\n3.10 እቲ ሓድጊ ፍሉይን ተደናቕን ዝገብሮ '),

                CheckboxListTile(
                  title: const Text('ዕድመ'),
                  value: _uniquenessOfHeritage.contains('ዕድመ'),
                  onChanged: (value) => _toggleUniquenessOfHeritage('ዕድመ'),
                ),
                CheckboxListTile(
                  title: const Text('ጥበብ ኣሰራርሕኡ'),
                  value: _uniquenessOfHeritage.contains('ጥበብ ኣሰራርሕኡ'),
                  onChanged: (value) =>
                      _toggleUniquenessOfHeritage('ጥበብ ኣሰራርሕኡ'),
                ),
                CheckboxListTile(
                  title: const Text('ዝተስርሐሉ ኣቕሓ/ንጥረ-ነገር'),
                  value: _uniquenessOfHeritage.contains('ዝተስርሐሉ ኣቕሓ/ንጥረ-ነገር'),
                  onChanged: (value) =>
                      _toggleUniquenessOfHeritage('ዝተስርሐሉ ኣቕሓ/ንጥረ-ነገር'),
                ),
                CheckboxListTile(
                  title: const Text('መልክዑ'),
                  value: _uniquenessOfHeritage.contains('መልክዑ'),
                  onChanged: (value) => _toggleUniquenessOfHeritage('መልክዑ'),
                ),
                CheckboxListTile(
                  title: const Text('ቅርፁ'),
                  value: _uniquenessOfHeritage.contains('ቅርፁ'),
                  onChanged: (value) => _toggleUniquenessOfHeritage('ቅርፁ'),
                ),

                CheckboxListTile(
                  title: const Text('ሕብሩ'),
                  value: _uniquenessOfHeritage.contains('ሕብሩ'),
                  onChanged: (value) => _toggleUniquenessOfHeritage('ሕብሩ'),
                ),
                CheckboxListTile(
                  title: const Text('ዘለዎ ትርጉም(ትሕዝቶ)'),
                  value: _uniquenessOfHeritage.contains('ዘለዎ ትርጉም(ትሕዝቶ)'),
                  onChanged: (value) =>
                      _toggleUniquenessOfHeritage('ዘለዎ ትርጉም(ትሕዝቶ)'),
                ),
                const SizedBox(height: 16.0),
                // Multiline comment box
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
                const Text('\n 3.11 ረብሓ እቲ ሓድጊ (Significance )'),
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
                const Text('\n3.12 እቲ ሓድጊ ሐዚ ዘለዎ ኩነታት '),
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
                const Text('\n\n3.13. ኩነታት ሓደጋ/ስግኣት ኣብቲ ሓድጊ '),
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
                const Text('\n3.14. ቅድሚ ሐዚ ዝተገበረሉ ናይ ዕቀባን ፅገና ስራሕ  '),
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
                const Text('\n3.14.1 ግምገማ እቲ ዝተገበረ ናይ ፅገና/ምዕቃብ ስራሕ ከመይ ኔሩ ? '),
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
                const Text('\n3.15 እቲ ሓድጊ በቲ ናይ ሐዚ ብበዓል ዋና ምምሕዳር ዝጀመረሉ እዋን'),
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
                const Text('\n3.16 ተበፃሓይነት እቲ ሓድጊ'),
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
                  title: const Text('ኣፈ-ታሪኽ'),
                  value: _typesEvidences.contains('ኣፈ-ታሪኽ'),
                  onChanged: (value) => _toggleTypesEvidences('ኣፈ-ታሪኽ'),
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
                const SizedBox(height: 16.0),
                const Text('\n5. መረዳእታ ወሃቢ ኣካል'),
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
                    _heritageInformantNameValue = value!;
                  },
                ),
                const SizedBox(height: 16.0),
                const Text('5.2 ፆታ'),
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
                    labelText: '5.3 ዕድመ',
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
                    labelText: '5.4 ስራሕ ሓላፍነት',
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
                    labelText: '5.5 ካልእ',
                  ),
                  onSaved: (value) {
                    _otherInformationValue = value!;
                  },
                ),

                const SizedBox(height: 16.0),
                const Text('\n6. ናይ መዝጋቢ መረዳእታ'),
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
                    _nameOfDataCollector = value!;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: '6.2 ሽም ዝሰርሕሉ ትካል ',
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
                    labelText: '6.3 መደብ ስራሕ ',
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
                    labelText: '6.4 ስራሕ ሓላፍነት',
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

                const SizedBox(height: 16.0),
                const Text('6.5 እቲ ሓድጊ ዝተመዝገበሉ መዓልቲ '),
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
