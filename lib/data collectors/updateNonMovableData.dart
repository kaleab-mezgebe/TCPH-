import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'updateNonMovableImages.dart';
import 'descrptiveImageNonMov.dart';
// import 'keeperSignatureImage.dart';

class UpdateNonmovabledata extends StatefulWidget {
  final int id;
  const UpdateNonmovabledata({super.key, required this.id});

  @override
  _UpdateNonMovableDataState createState() => _UpdateNonMovableDataState();
}

class _UpdateNonMovableDataState extends State<UpdateNonmovabledata> {
  List<String> _selectedClassifications = [];
  List<String> _selectedEvidences = [];
  DateTime? _registrationDateOfHeritage;

  DateTime? _dateOfCreation;
  DateTime? _maintainedOn;
  DateTime? _startingDateSinceAdministered;

  final TextEditingController _heritageImageDescriptionController =
      TextEditingController();
  final TextEditingController _heritageImagesDescriptionController =
      TextEditingController();
  final TextEditingController _usernameValueController =
      TextEditingController();
  final TextEditingController _heritageNameValueController =
      TextEditingController();
  final TextEditingController _localNameValueController =
      TextEditingController();
  final TextEditingController _classOfHeritageController =
      TextEditingController();
  final TextEditingController _regionValueController = TextEditingController();
  final TextEditingController _zoneValueController = TextEditingController();
  final TextEditingController _weredaValueController = TextEditingController();
  final TextEditingController _tabiaValueController = TextEditingController();
  final TextEditingController _kushetValueController = TextEditingController();
  final TextEditingController _uniqueNameofThePlaceController =
      TextEditingController();
  final TextEditingController _previousServiceValueController =
      TextEditingController();
  final TextEditingController _currentServiceValueController =
      TextEditingController();
  final TextEditingController _givenIDValueController = TextEditingController();
  final TextEditingController _heritageOwnerValueController =
      TextEditingController();
  final TextEditingController _otherOwnerValueController =
      TextEditingController();
  final TextEditingController _gpsValueController = TextEditingController();
  final TextEditingController _eastValueController = TextEditingController();
  final TextEditingController _northValueController = TextEditingController();
  final TextEditingController _aboveSeaLevelValueController =
      TextEditingController();
  final TextEditingController _nameOfHeritageOwnerValueController =
      TextEditingController();
  final TextEditingController _nameWhoFindTheHeritageValueController =
      TextEditingController();
  final TextEditingController _dateOfCreationController =
      TextEditingController();
  final TextEditingController _wayOfKnowingHeritageAgeValueController =
      TextEditingController();
  final TextEditingController _currentStatusOfTheHeritageValueController =
      TextEditingController();
  final TextEditingController _heightValueController = TextEditingController();
  final TextEditingController _lengthValueController = TextEditingController();
  final TextEditingController _breadthValueController = TextEditingController();
  final TextEditingController _areaValueController = TextEditingController();
  final TextEditingController _diameterValueController =
      TextEditingController();
  final TextEditingController _shapeValueController = TextEditingController();
  final TextEditingController _numberOfGatesValueController =
      TextEditingController();
  final TextEditingController _numberOfWindowsValueController =
      TextEditingController();
  final TextEditingController _numberOfClassesValueController =
      TextEditingController();
  final TextEditingController _madeFromController = TextEditingController();
  final TextEditingController _shortDescriptionOfHeritageValueController =
      TextEditingController();
  final TextEditingController _historyValueController = TextEditingController();
  final TextEditingController _cultureValueController = TextEditingController();
  final TextEditingController _artValueContrller = TextEditingController();
  final TextEditingController _handCraftValueController =
      TextEditingController();
  final TextEditingController _scienceValueController = TextEditingController();
  final TextEditingController _otherUniquenessOfHeritageValueController =
      TextEditingController();
  final TextEditingController _significanceOfHeritageValueController =
      TextEditingController();
  final TextEditingController _statusOfTheHeritageValueController =
      TextEditingController();
  final TextEditingController
      _ifDestructedDescriptionOfHeritageDestructionValueController =
      TextEditingController();
  final TextEditingController _otherHeritagesStatusController =
      TextEditingController();

  final TextEditingController _conditionOfHeritageDestructionValueController =
      TextEditingController();
  final TextEditingController
      _descriptionConditionOfHeritageDestructionValueController =
      TextEditingController();
  final TextEditingController _maintenanceValueController =
      TextEditingController();
  final TextEditingController _reasonOfMaintenanceValueController =
      TextEditingController();
  final TextEditingController _maintainedByValueController =
      TextEditingController();
  final TextEditingController _maintainedOnController = TextEditingController();
  final TextEditingController _numberOfMaintenanceValueController =
      TextEditingController();
  final TextEditingController _evaluationOnMaintenanceValueController =
      TextEditingController();
  final TextEditingController
      _startingDateOfSinceAdministeredByCurrentOwnerController =
      TextEditingController();
  final TextEditingController _evaluationAnswerDescriptionValueController =
      TextEditingController();
  final TextEditingController _accessibilityOfHeritageValueController =
      TextEditingController();
  final TextEditingController
      _descriptionOfAccessibilityHeritageValueController =
      TextEditingController();
  final TextEditingController _typesEvidencesController =
      TextEditingController();
  final TextEditingController _ifOtherTypeEvidenceValueController =
      TextEditingController();
  final TextEditingController _mythValueController = TextEditingController();
  final TextEditingController _ifThereIsMythsController =
      TextEditingController();
  final TextEditingController _keeperNameValueController =
      TextEditingController();
  final TextEditingController _keeperWorkResponsibilityValueController =
      TextEditingController();
  final TextEditingController _heritageInformantNameValueController =
      TextEditingController();

  final TextEditingController _genderValueController = TextEditingController();
  final TextEditingController _ageValueController = TextEditingController();
  final TextEditingController _workResponsibilityValueController =
      TextEditingController();
  final TextEditingController _otherInformationValueController =
      TextEditingController();
  final TextEditingController _nameOfDataCollectorController =
      TextEditingController();
  final TextEditingController _nameOfOrganizationController =
      TextEditingController();
  final TextEditingController _positionController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  final TextEditingController _registrationDateOfHeritageController =
      TextEditingController();

  Future<void> _fetchUserInfo() async {
    try {
      final response = await http.get(Uri.parse(
          'https://repositoryformymobapp-kaleab-mezgebe.onrender.com/fetchNonMovableData/${widget.id.toString()}'));
      if (response.statusCode == 200) {
        final userData = json.decode(response.body);
        final classOfHeritage = userData['class_of_heritage'];
        final typeOfEvidences = userData['types_evidences'];
        final registrationDate =
            DateTime.parse(userData['registration_date_of_heritage']);
        final dateOfCreation = DateTime.parse(userData['date_of_creation']);

        final maintainedOn = DateTime.parse(userData['maintained_on']);

        final startingDateSinceAdministered = DateTime.parse(
            userData['starting_date_of_since_administered_by_current_owner']);

        setState(() {
          _selectedClassifications = classOfHeritage.split('፣');
          _selectedEvidences = typeOfEvidences.split('፣');
          _registrationDateOfHeritage = registrationDate;
          _dateOfCreation = dateOfCreation;
          _maintainedOn = maintainedOn;
          _startingDateSinceAdministered = startingDateSinceAdministered;
        });
        setState(() {
          // _usernameController.text = userData['username_of_data_collector'];
          // _emailController.text = userData['heritage_name'];
          // _phoneNumberController.text = userData['local_name'];
          _heritageImageDescriptionController.text =
              userData['caption_for_image_of_heritage'];
          _usernameValueController.text =
              userData['username_of_data_collector'];
          _heritageNameValueController.text = userData['heritage_name'];
          _localNameValueController.text = userData['local_name'];
          _heritageImagesDescriptionController.text =
              userData['caption_for_image_of_heritages'];
          _classOfHeritageController.text = userData['class_of_heritage'];
          _regionValueController.text = userData['region'];
          _zoneValueController.text = userData['zone'];
          _weredaValueController.text = userData['wereda'];
          _tabiaValueController.text = userData['tabia'];
          _kushetValueController.text = userData['kushet'];
          _uniqueNameofThePlaceController.text = userData['unique_name_place'];
          _previousServiceValueController.text = userData['previous_service'];
          _currentServiceValueController.text = userData['current_service'];
          _givenIDValueController.text = userData['Given_ID'];
          _heritageOwnerValueController.text = userData['heritage_owner'];
          _otherOwnerValueController.text = userData['other_owner'];
          _gpsValueController.text = userData['gps'];
          _eastValueController.text = userData['east'];
          _northValueController.text = userData['_north'];
          _aboveSeaLevelValueController.text = userData['_above_sea_level'];
          _nameOfHeritageOwnerValueController.text =
              userData['name_of_heritage_owner'];
          _nameWhoFindTheHeritageValueController.text =
              userData['name_who_find_the_heritage'];
          _dateOfCreationController.text =
              userData['date_of_creation'].toString();
          _wayOfKnowingHeritageAgeValueController.text =
              userData['way_of_knowing_heritage_age'];
          _currentStatusOfTheHeritageValueController.text =
              userData['current_status_of_the_heritage'];
          _heightValueController.text = userData['height'].toString();
          _lengthValueController.text = userData['length'].toString();
          _breadthValueController.text = userData['breadth'].toString();
          _areaValueController.text = userData['area'].toString();
          _diameterValueController.text = userData['diameter'].toString();
          _shapeValueController.text = userData['shape'];
          _numberOfGatesValueController.text =
              userData['number_of_gates'].toString();
          _numberOfWindowsValueController.text =
              userData['number_of_windows'].toString();
          _numberOfClassesValueController.text =
              userData['number_of_classes'].toString();
          _madeFromController.text = userData['made_from'];
          _shortDescriptionOfHeritageValueController.text =
              userData['short_description_of_heritage'];
          _historyValueController.text = userData['history'];
          _cultureValueController.text = userData['culture'];
          _artValueContrller.text = userData['art'];
          _handCraftValueController.text = userData['hand_craft'];
          _scienceValueController.text = userData['science'];
          _otherUniquenessOfHeritageValueController.text =
              userData['other_uniqueness_of_heritage'];
          _significanceOfHeritageValueController.text =
              userData['significance_of_heritage'];
          _statusOfTheHeritageValueController.text =
              userData['status_of_the_heritage'];
          _ifDestructedDescriptionOfHeritageDestructionValueController.text =
              userData['if_destructed_description_of_heritage_destruction'];
          _otherHeritagesStatusController.text =
              userData['other_heritages_status'];

          _conditionOfHeritageDestructionValueController.text =
              userData['condition_of_heritage_destruction'];
          _descriptionConditionOfHeritageDestructionValueController.text =
              userData['description_condition_of_heritage_destruction'];
          _maintenanceValueController.text = userData['maintenance'];
          _reasonOfMaintenanceValueController.text =
              userData['reason_of_maintenance'];
          _maintainedByValueController.text = userData['maintained_by'];
          _maintainedOnController.text = userData['maintained_on'].toString();
          _numberOfMaintenanceValueController.text =
              userData['number_of_maintenance'];
          _evaluationOnMaintenanceValueController.text =
              userData['evaluation_on_maintenance'];
          _startingDateOfSinceAdministeredByCurrentOwnerController.text =
              userData['starting_date_of_since_administered_by_current_owner']
                  .toString();
          _evaluationAnswerDescriptionValueController.text =
              userData['evaluation_answer_description'];
          _accessibilityOfHeritageValueController.text =
              userData['accessibility_of_heritage'];
          _descriptionOfAccessibilityHeritageValueController.text =
              userData['description_Of_Accessibility_Heritage'];
          _typesEvidencesController.text = userData['types_evidences'];
          _ifOtherTypeEvidenceValueController.text =
              userData['if_other_type_evidence'];
          _mythValueController.text = userData['myth'];
          _ifThereIsMythsController.text = userData['if_there_is_myths'];
          _keeperNameValueController.text = userData['keeper_name'];
          _keeperWorkResponsibilityValueController.text =
              userData['keeper_work_responsibility'];
          _heritageInformantNameValueController.text =
              userData['heritage_informant_name'];
          _genderValueController.text = userData['gender'];
          _ageValueController.text = userData['age'].toString();
          _workResponsibilityValueController.text =
              userData['work_responsibility'];
          _otherInformationValueController.text = userData['other_information'];
          _nameOfDataCollectorController.text =
              userData['name_of_data_collector'];
          _nameOfOrganizationController.text = userData['name_of_organization'];
          _roleController.text = userData['role'];
          _positionController.text = userData['position'];
          _registrationDateOfHeritageController.text =
              userData['registration_date_of_heritage'].toString();
        });
      } else {
        // Handle error
        print('Failed to fetch user info');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _updateUserInfo() async {
    try {
      final response = await http.put(
        Uri.parse(
            'https://repositoryformymobapp-kaleab-mezgebe.onrender.com/updateNonMovableHeritage/${widget.id.toString()}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          // 'username_of_data_collector': _usernameController.text,
          // 'heritage_name': _emailController.text,
          // 'local_name': _phoneNumberController.text,

          'username_of_data_collector': _usernameValueController.text,
          'caption_for_image_of_heritage':
              _heritageImageDescriptionController.text,
          'heritage_name': _heritageNameValueController.text,
          'local_name': _localNameValueController.text,
          // 'class_of_heritage': _classOfHeritageController.text,
          // 'class_of_heritage': _classOfHeritageController.text,
          'caption_for_image_of_heritages':
              _heritageImagesDescriptionController.text,
          'class_of_heritage': _selectedClassifications.join('፣'),

          'region': _regionValueController.text,
          'zone': _zoneValueController.text,
          'wereda': _weredaValueController.text,
          'tabia': _tabiaValueController.text,
          'kushet': _kushetValueController.text,
          'unique_name_place': _uniqueNameofThePlaceController.text,

          'previous_service': _previousServiceValueController.text,
          'current_service': _currentServiceValueController.text,
          'Given_ID': _givenIDValueController.text,
          'heritage_owner': _heritageOwnerValueController.text,
          'other_owner': _otherOwnerValueController.text,
          'gps': _gpsValueController.text,
          'east': _eastValueController.text,
          '_north': _northValueController.text,
          '_above_sea_level': _aboveSeaLevelValueController.text,
          'name_of_heritage_owner': _nameOfHeritageOwnerValueController.text,
          'name_who_find_the_heritage':
              _nameWhoFindTheHeritageValueController.text,
          // 'date_of_creation': _dateOfCreationController.text,
          'date_of_creation': DateFormat('yyyy-MM-dd').format(_dateOfCreation!),

          'way_of_knowing_heritage_age':
              _wayOfKnowingHeritageAgeValueController.text,
          'current_status_of_the_heritage':
              _currentStatusOfTheHeritageValueController.text,
          'height': _heightValueController.text,
          'length': _lengthValueController.text,
          'breadth': _breadthValueController.text,
          'area': _areaValueController.text,
          'diameter': _diameterValueController.text,
          'shape': _shapeValueController.text,
          'number_of_gates': _numberOfGatesValueController.text,
          'number_of_windows': _numberOfWindowsValueController.text,
          'number_of_classes': _numberOfClassesValueController.text,
          'made_from': _madeFromController.text,
          'short_description_of_heritage':
              _shortDescriptionOfHeritageValueController.text,

          'history': _historyValueController.text,
          'culture': _cultureValueController.text,
          'art': _artValueContrller.text,
          'hand_craft': _handCraftValueController.text,
          'science': _scienceValueController.text,
          'other_uniqueness_of_heritage':
              _otherUniquenessOfHeritageValueController.text,
          'significance_of_heritage':
              _significanceOfHeritageValueController.text,
          'status_of_the_heritage': _statusOfTheHeritageValueController.text,
          'if_destructed_description_of_heritage_destruction':
              _ifDestructedDescriptionOfHeritageDestructionValueController.text,
          'other_heritages_status': _otherHeritagesStatusController.text,

          'condition_of_heritage_destruction':
              _conditionOfHeritageDestructionValueController.text,
          'description_condition_of_heritage_destruction':
              _descriptionConditionOfHeritageDestructionValueController.text,
          'maintenance': _maintenanceValueController.text,
          'reason_of_maintenance': _reasonOfMaintenanceValueController.text,
          'maintained_by': _maintainedByValueController.text,
          // 'maintained_on': _maintainedOnController.text,
          'maintained_on': DateFormat('yyyy-MM-dd').format(_maintainedOn!),

          'number_of_maintenance': _numberOfMaintenanceValueController.text,
          'evaluation_on_maintenance':
              _evaluationOnMaintenanceValueController.text,
          // 'starting_date_of_since_administered_by_current_owner':
          //     _startingDateOfSinceAdministeredByCurrentOwnerController.text,
          'starting_date_of_since_administered_by_current_owner':
              DateFormat('yyyy-MM-dd').format(_startingDateSinceAdministered!),

          'evaluation_answer_description':
              _evaluationAnswerDescriptionValueController.text,
          'accessibility_of_heritage':
              _accessibilityOfHeritageValueController.text,
          'description_Of_Accessibility_Heritage':
              _descriptionOfAccessibilityHeritageValueController.text,
          // 'types_evidences': _typesEvidencesController.text,
          'types_evidences': _selectedEvidences.join('፣'),

          'if_other_type_evidence': _ifOtherTypeEvidenceValueController.text,
          'myth': _mythValueController.text,
          'if_there_is_myths': _ifThereIsMythsController.text,
          'keeper_name': _keeperNameValueController.text,
          'keeper_work_responsibility':
              _keeperWorkResponsibilityValueController.text,

          'heritage_informant_name': _heritageInformantNameValueController.text,

          'gender': _genderValueController.text,
          'age': _ageValueController.text,
          'work_responsibility': _workResponsibilityValueController.text,
          'other_information': _otherInformationValueController.text,

          'name_of_data_collector': _nameOfDataCollectorController.text,
          'name_of_organization': _nameOfOrganizationController.text,
          'position': _positionController.text,
          'role': _roleController.text,

          //   'registration_date_of_heritage':
          //       _registrationDateOfHeritageController.text,
          'registration_date_of_heritage':
              DateFormat('yyyy-MM-dd').format(_registrationDateOfHeritage!),
        }),
      );
      if (response.statusCode == 200) {
        // Update successful
        // print('User info updated successfully');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('ብዝግባእ ተመሓይሹ'),
          ),
        );
      } else {
        // Handle error
        // print('Failed to update user info');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('ምምሕያሽ ኣይተኽኣለን'),
          ),
        );
      }
    } catch (error) {
      // print('Error: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $error'),
        ),
      );
    }
  }

  void _toggleClassOfHeritage(String classification) {
    setState(() {
      if (_selectedClassifications.contains(classification)) {
        _selectedClassifications.remove(classification);
      } else {
        _selectedClassifications.add(classification);
      }
    });
  }

  void _toggleTypesEvidences(String evidence) {
    setState(() {
      if (_selectedEvidences.contains(evidence)) {
        _selectedEvidences.remove(evidence);
      } else {
        _selectedEvidences.add(evidence);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchUserInfo(); // Fetch initial user info when the widget is first built
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('መመሓየሺ ቅጥዒ'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DescriptiveImageNonMov(
                              id: widget.id,
                            )),
                  );
                },
                child: const Text('ምስሊ ናይቲ ሓድጊ'),
              ),

              TextField(
                controller: _heritageImageDescriptionController,
                decoration: const InputDecoration(
                  labelText: 'መግለፂ ስእሊ ናይቲ ሓድጊ',
                ),
              ),
              const Text("\n1. መፍለይ እቲ ሓድጊ"),
              const SizedBox(height: 16.0),
              TextField(
                controller: _heritageNameValueController,
                decoration: const InputDecoration(
                  labelText: 'ስም ብትግርኛ',
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _localNameValueController,
                decoration: const InputDecoration(
                  labelText: 'ፍሉይ ናይ ከባቢ መፀውዒ (እንተሃልይዎ)',
                ),
              ),
              // SizedBox(height: 16.0),
              // TextField(
              //   controller: _classOfHeritageController,
              //   decoration: InputDecoration(
              //     labelText: '1.2 ምድብ',
              //   ),
              // ),
              const Text('\n'),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ImageGalleryPage(
                              id: widget.id,
                            )),
                  );
                },
                child: const Text('ምስሊታት ናይ እዚ ሓድጊ'),
              ),

              const Text(
                  'መግለፂ ናይቶም ዝመረፅዎም ስእሊ እቲ ሓድጊ(ካብ 2 ንላዕሊ ስእሊ ተመሪፆም ብ፣ ብምፍላይ መግልፂ የእትው)'),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1.0),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: TextFormField(
                  controller:
                      _heritageImagesDescriptionController, // assign the text controller here
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(8.0),
                  ),
                  maxLines: null,
                ),
              ),

              const SizedBox(height: 16.0),
              const Text('\n\n1.2 ምድብ'),
              CheckboxListTile(
                title: const Text(
                    'ታሪኻዊ ህንፃታት፣ ሓወልትታት፣ ዑናታ፣ ኣብያተ-እምነት፣ ድልድላት፣ በዓትታት፣ መቓብራት፣ ወዘተ  (I)'),
                value: _selectedClassifications.contains('I'),
                onChanged: (value) => _toggleClassOfHeritage('I'),
              ),
              CheckboxListTile(
                title: const Text('ታሪኻዊ ቦታታትን ናይ ተፈጥሮ ከባቢታትን (II)'),
                value: _selectedClassifications.contains('II'),
                onChanged: (value) => _toggleClassOfHeritage('II'),
              ),
              CheckboxListTile(
                title: const Text(
                    'ስእልታት (ኣብ ሃይማኖታዊ ቦታታት፣ በዓቲ፣ መንበሪ ገዛ ወዘተ) (VII)'),
                value: _selectedClassifications.contains('VII'),
                onChanged: (value) => _toggleClassOfHeritage('VII'),
              ),
              CheckboxListTile(
                title: const Text(
                    'ብኳዕቲ ኣርኪዮሎጂ ዝተረከቡ ቅርስታት፣ ቦታታት ስነዃዕትን ስነ-ጥንትን (VIII)'),
                value: _selectedClassifications.contains('VIII'),
                onChanged: (value) => _toggleClassOfHeritage('VIII'),
              ),

              const SizedBox(height: 16.0),
              const Text('\n1.3 አድራሻ '),
              TextField(
                controller: _regionValueController,
                decoration: const InputDecoration(
                  labelText: 'ክልል',
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _zoneValueController,
                decoration: const InputDecoration(
                  labelText: 'ዞባ',
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _weredaValueController,
                decoration: const InputDecoration(
                  labelText: 'ወረዳ',
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _tabiaValueController,
                decoration: const InputDecoration(
                  labelText: 'ጣብያ',
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _kushetValueController,
                decoration: const InputDecoration(
                  labelText: 'ቑሸት',
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _uniqueNameofThePlaceController,
                decoration: const InputDecoration(
                  labelText: 'ፍሉይ ሽም ቦታ',
                ),
              ),
              const SizedBox(height: 16.0),
              const Text('\n\n1.4 አገልግሎት'),
              TextField(
                controller: _previousServiceValueController,
                decoration: const InputDecoration(
                  labelText: 'U.ናይ ቕድሚ ሐዚ',
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _currentServiceValueController,
                decoration: const InputDecoration(
                  labelText: 'ለ. ናይ ሐዚ (ዝተቐየረ እንተኾይኑ) ',
                ),
              ),
              // SizedBox(height: 16.0),
              // TextField(
              //   controller: _givenIDValueController,
              //   decoration: InputDecoration(
              //     labelText: '1.5 ናይ ቕድሚ ሐዚ መፍለይ ቑፅሪ (እንተነይርዎ)',
              //   ),
              // ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _givenIDValueController,
                decoration: const InputDecoration(
                  labelText: '1.5 ናይ ቕድሚ ሐዚ መፍለይ ቑፅሪ (እንተነይርዎ)',
                ),
              ),
              // SizedBox(height: 16.0),
              // TextField(
              //   controller: _givenIDValueController,
              //   decoration: InputDecoration(
              //     labelText: '1.6 ናይ ሐዚ ዘለዎ መፍለይ ቑፅሪ (ዘይተውሃቦ እንተኮይኑ ሐዚ ይወሃቦ',
              //   ),
              // ),

              // SizedBox(height: 16.0),
              // const Text('\n\n2. በዓል ዋና ሓድጊ (ዋንነት)'),
              // TextField(
              //   controller: _heritageOwnerValueController,
              //   decoration: InputDecoration(
              //     labelText: '2.1 ናይቲ ሓድጊ በዓል ዋና',
              //   ),
              // ),

              const Text('\n\n2. በዓል ዋና ሓድጊ (ዋንነት)'),
              const SizedBox(height: 16.0),
              const Text('2.1 ናይቲ ሓድጊ በዓል ዋና'),
              ListTile(
                title: const Text('ናይ ህዝቢ'),
                leading: Radio<String>(
                  value: 'ናይ ህዝቢ',
                  groupValue: _heritageOwnerValueController.text,
                  onChanged: (value) {
                    setState(() {
                      _heritageOwnerValueController.text = value!;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('ናይ መንግስቲ'),
                leading: Radio<String>(
                  value: 'ናይ መንግስቲ',
                  groupValue: _heritageOwnerValueController.text,
                  onChanged: (value) {
                    setState(() {
                      _heritageOwnerValueController.text = value!;
                    });
                  },
                ),
              ),

              ListTile(
                title: const Text('ናይ ኃይማኖት '),
                leading: Radio<String>(
                  value: 'ናይ ኃይማኖት',
                  groupValue: _heritageOwnerValueController.text,
                  onChanged: (value) {
                    setState(() {
                      _heritageOwnerValueController.text = value!;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('ናይ ውልቀ '),
                leading: Radio<String>(
                  value: 'ናይ ውልቀ',
                  groupValue: _heritageOwnerValueController.text,
                  onChanged: (value) {
                    setState(() {
                      _heritageOwnerValueController.text = value!;
                    });
                  },
                ),
              ),

              const SizedBox(height: 16.0),
              TextField(
                controller: _otherOwnerValueController,
                decoration: const InputDecoration(
                  labelText: 'ካልእ እንተኾይኑ ይጠቐስ',
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _nameOfHeritageOwnerValueController,
                decoration: const InputDecoration(
                  labelText: '2.2 ናይ እቲ ሓድጊ በዓል ዋና ወይ ትካል ሽም ',
                ),
              ),
              const SizedBox(height: 16.0),
              const Text('\n '),
              TextField(
                controller: _gpsValueController,
                decoration: const InputDecoration(
                  labelText: 'ጂፒኤስ(GPS)',
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _eastValueController,
                decoration: const InputDecoration(
                  labelText: 'ምብራቕ',
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _northValueController,
                decoration: const InputDecoration(
                  labelText: 'ሰሜን',
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _aboveSeaLevelValueController,
                decoration: const InputDecoration(
                  labelText: 'ብራኸ ልዕሊ ፀፍሒ ባሕሪ(ብሜትር)',
                ),
              ),
              const SizedBox(height: 16.0),
              const Text('\n\n3. ታሪኽ'),
              const Text(
                  '\n3.1 ነቲ ሓድጊ ዘስረሐ፣ ዝሰርሐ፣ ወይ ድማ ዝረኸበ ውልቀ-ሰብ ወይ ኣካል ሽም'),
              TextField(
                controller: _nameWhoFindTheHeritageValueController,
                decoration: const InputDecoration(
                  labelText: 'ዝፍለጥ እንተኾይኑ',
                ),
              ),
              // SizedBox(height: 16.0),
              // TextField(
              //   controller: _dateOfCreationController,
              //   decoration: InputDecoration(
              //     labelText: '3.2 እቲ ሓድጊ ዝተሰርሐሉ ጊዜ/ዘመን (ግምታዊ ምቕማጥ ይከኣል)',
              //   ),
              // ),

              const SizedBox(height: 16.0),
              const Text('3.2 እቲ ሓድጊ ዝተሰርሐሉ ጊዜ/ዘመን (ግምታዊ ምቕማጥ ይከኣል)'),
              ListTile(
                title: Text(
                  _dateOfCreation == null
                      ? 'ሰሌዳ ጊዜ'
                      : 'ሓድጊ ዝተሰርሐሉ መዓልቲ: ${_dateOfCreation.toString().substring(0, 10)}',
                ),
                leading: const Icon(Icons.calendar_today),
                onTap: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: _dateOfCreation ?? DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      _dateOfCreation = pickedDate;
                    });
                  }
                },
              ),
              // SizedBox(height: 16.0),
              // const Text('\n'),
              // TextField(
              //   controller: _wayOfKnowingHeritageAgeValueController,
              //   decoration: InputDecoration(
              //     labelText: '3.3 ዕድመ እቲ ሓድጊ ዝተነፀረሉ (ዝተፈለጠሉ) መንገዲ',
              //   ),
              // ),
              const SizedBox(height: 16.0),
              const Text('\n 3.3 ዕድመ እቲ ሓድጊ ዝተነፀረሉ (ዝተፈለጠሉ) መንገዲ'),
              ListTile(
                title: const Text('ብግምት'),
                leading: Radio<String>(
                  value: 'ብግምት',
                  groupValue: _wayOfKnowingHeritageAgeValueController.text,
                  onChanged: (value) {
                    setState(() {
                      _wayOfKnowingHeritageAgeValueController.text = value!;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('ብትኽክል '),
                leading: Radio<String>(
                  value: 'ብትኽክል',
                  groupValue: _wayOfKnowingHeritageAgeValueController.text,
                  onChanged: (value) {
                    setState(() {
                      _wayOfKnowingHeritageAgeValueController.text = value!;
                    });
                  },
                ),
              ),

              ListTile(
                title: const Text('ብኣንፃራዊ '),
                leading: Radio<String>(
                  value: 'ብኣንፃራዊ',
                  groupValue: _wayOfKnowingHeritageAgeValueController.text,
                  onChanged: (value) {
                    setState(() {
                      _wayOfKnowingHeritageAgeValueController.text = value!;
                    });
                  },
                ),
              ),

              // SizedBox(height: 16.0),
              // const Text('\n'),
              // TextField(
              //   controller: _currentStatusOfTheHeritageValueController,
              //   decoration: InputDecoration(
              //     labelText:
              //         '3.4. ህልው ኩነታት እቲ ሓድጊ (ኩነታት ጉድኣት፣ ወይ ዝኾነ ለውጥታት ዘለዎ እንተኮይኑ፣ ወይ ከምዝነበሮ ድዩ ዘሎ፣ ወዘተ ዝብል) ',
              //   ),
              // ),
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
                  controller:
                      _currentStatusOfTheHeritageValueController, // assign the text controller here
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(8.0),
                  ),
                  maxLines: null,
                ),
              ),

              const SizedBox(height: 16.0),
              const Text(
                  '3.5 መጠን/ዓቐን እቲ ሓድጊ (ንቲ ሓድጊ ዝምልከቱ ጥራሕ ይምላእ፣ ዘይብሉ ወይ ዘይምልከቶ እንተኾይኑ ኣይምላእን)'),
              TextField(
                controller: _heightValueController,
                decoration: const InputDecoration(
                  labelText: 'ቁመት(ሜ)',
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _lengthValueController,
                decoration: const InputDecoration(
                  labelText: 'ንውሓት(ሜ)',
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _breadthValueController,
                decoration: const InputDecoration(
                  labelText: 'ወርዲ(ሜ)',
                ),
              ),
              const SizedBox(height: 16.0),
              const Text('\n '),
              TextField(
                controller: _areaValueController,
                decoration: const InputDecoration(
                  labelText: 'ስፍሓት(ሜ2)',
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _diameterValueController,
                decoration: const InputDecoration(
                  labelText: 'ዲያሜትር(ሜ)',
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _shapeValueController,
                decoration: const InputDecoration(
                  labelText: 'ቅርፂ',
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _numberOfGatesValueController,
                decoration: const InputDecoration(
                  labelText: 'በዝሒ መእተዊ በሪ (ዘለዎ እንተኮይኑ)',
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _numberOfWindowsValueController,
                decoration: const InputDecoration(
                  labelText: 'በዝሒ መሳኹቲ (ዘለዎ እንተኮይኑ)  ',
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _numberOfClassesValueController,
                decoration: const InputDecoration(
                  labelText: 'በዝሒ ክፍልታት (ዘለዎ እንተኮይኑ)  ',
                ),
              ),
              const SizedBox(height: 16.0),
              const Text('\n'),
              TextField(
                controller: _madeFromController,
                decoration: const InputDecoration(
                  labelText: '3.6 ዝተሰርሐሉ ኣቕሓ (ካብ ምንታይ ዝተሰርሐ እዩ)',
                ),
              ),
              // SizedBox(height: 16.0),
              // const Text('\n'),
              // TextField(
              //   controller: _shortDescriptionOfHeritageValueController,
              //   decoration: InputDecoration(
              //     labelText: '3.7 ሓፂር መረዳእታ/መብራህረሂ እቲ ሓድጊ፡',
              //   ),
              // ),

              const SizedBox(height: 16.0),
              // Multiline comment box
              const Text('\n 3.7 ሓፂር መረዳእታ/መብራህረሂ እቲ ሓድጊ፡'),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1.0),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: TextFormField(
                  controller:
                      _shortDescriptionOfHeritageValueController, // assign the text controller here
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(8.0),
                  ),
                  maxLines: null,
                ),
              ),

              // SizedBox(height: 16.0),
              // const Text(
              //     '\n3.8 እቲ ሓድጊ ፍሉይ ዝገብሮ (ካብቶም ተዘርዚሮም ዘለው ብኣንፃር ኣየናይ እዩ) '),
              // TextField(
              //   controller: _historyValueController,
              //   decoration: InputDecoration(
              //     labelText: 'ታሪኽ',
              //   ),
              // ),
              // SizedBox(height: 16.0),
              // TextField(
              //   controller: _cultureValueController,
              //   decoration: InputDecoration(
              //     labelText: 'ባህሊ',
              //   ),
              // ),
              // SizedBox(height: 16.0),
              // TextField(
              //   controller: _artValueContrller,
              //   decoration: InputDecoration(
              //     labelText: 'ስነ-ጥበብ',
              //   ),
              // ),
              // SizedBox(height: 16.0),
              // const Text('\n '),
              // TextField(
              //   controller: _handCraftValueController,
              //   decoration: InputDecoration(
              //     labelText: 'ኢደ-ጥበብ',
              //   ),
              // ),
              // SizedBox(height: 16.0),
              // const Text('\n '),
              // TextField(
              //   controller: _scienceValueController,
              //   decoration: InputDecoration(
              //     labelText: 'ሳይንስ',
              //   ),
              // ),
              // SizedBox(height: 16.0),
              // TextField(
              //   controller: _otherUniquenessOfHeritageValueController,
              //   decoration: InputDecoration(
              //     labelText: 'ካልእ እንተሃልዩ ተብራህሪሁ ኣብዚ ይቕረብ፡',
              //   ),
              // ),

              const Text(
                  '\n3.8 እቲ ሓድጊ ፍሉይ ዝገብሮ (ካብቶም ተዘርዚሮም ዘለው ብኣንፃር ኣየናይ እዩ) '),
              const Text('ታሪኽ'),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1.0),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: TextFormField(
                  controller:
                      _historyValueController, // assign the text controller here
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(8.0),
                  ),
                  maxLines: null,
                ),
              ),
              const Text('ባህሊ'),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1.0),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: TextFormField(
                  controller:
                      _cultureValueController, // assign the text controller here
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(8.0),
                  ),
                  maxLines: null,
                ),
              ),

              const Text('ስነ-ጥበብ'),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1.0),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: TextFormField(
                  controller:
                      _artValueContrller, // assign the text controller here
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(8.0),
                  ),
                  maxLines: null,
                ),
              ),

              const Text('ኢደ-ጥበብ'),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1.0),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: TextFormField(
                  controller:
                      _handCraftValueController, // assign the text controller here
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(8.0),
                  ),
                  maxLines: null,
                ),
              ),

              const Text('ሳይንስ'),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1.0),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: TextFormField(
                  controller:
                      _scienceValueController, // assign the text controller here
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(8.0),
                  ),
                  maxLines: null,
                ),
              ),
              const Text('\n ካልእ እንተሃልዩ ተብራህሪሁ ኣብዚ ይቕረብ፡'),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1.0),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: TextFormField(
                  controller:
                      _otherUniquenessOfHeritageValueController, // assign the text controller here
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(8.0),
                  ),
                  maxLines: null,
                ),
              ),

              // SizedBox(height: 16.0),
              // const Text('\n  '),
              // TextField(
              //   controller: _significanceOfHeritageValueController,
              //   decoration: InputDecoration(
              //     labelText: '3.9 ረብሓ እቲ ሓድጊ (Significance )',
              //   ),
              // ),

              const SizedBox(height: 16.0),
              // Multiline comment box
              const Text('\n 3.9 ረብሓ እቲ ሓድጊ (Significance )'),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1.0),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: TextFormField(
                  controller:
                      _significanceOfHeritageValueController, // assign the text controller here
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(8.0),
                  ),
                  maxLines: null,
                ),
              ),

              // SizedBox(height: 16.0),
              // const Text('\n '),
              // TextField(
              //   controller: _statusOfTheHeritageValueController,
              //   decoration: InputDecoration(
              //     labelText: '3.10 እቲ ሓድጊ ሐዚ ዘለዎ ኩነታት',
              //   ),
              // ),

              const SizedBox(height: 16.0),
              const Text('\n3.10 እቲ ሓድጊ ሐዚ ዘለዎ ኩነታት '),
              ListTile(
                title: const Text('ፅቡቕ'),
                leading: Radio<String>(
                  value: 'ፅቡቕ',
                  groupValue: _statusOfTheHeritageValueController.text,
                  onChanged: (value) {
                    setState(() {
                      _statusOfTheHeritageValueController.text = value!;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('ደሓን'),
                leading: Radio<String>(
                  value: 'ደሓን',
                  groupValue: _statusOfTheHeritageValueController.text,
                  onChanged: (value) {
                    setState(() {
                      _statusOfTheHeritageValueController.text = value!;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('ጉድኣት ዝበፅሖ'),
                leading: Radio<String>(
                  value: 'ጉድኣት ዝበፅሖ',
                  groupValue: _statusOfTheHeritageValueController.text,
                  onChanged: (value) {
                    setState(() {
                      _statusOfTheHeritageValueController.text = value!;
                    });
                  },
                ),
              ),

              ListTile(
                title: const Text('ዘይተፈለጠ'),
                leading: Radio<String>(
                  value: 'ዘይተፈለጠ',
                  groupValue: _statusOfTheHeritageValueController.text,
                  onChanged: (value) {
                    setState(() {
                      _statusOfTheHeritageValueController.text = value!;
                    });
                  },
                ),
              ),
              // SizedBox(height: 16.0),
              // TextField(
              //   controller:
              //       _ifDestructedDescriptionOfHeritageDestructionValueController,
              //   decoration: InputDecoration(
              //     labelText: '(ጉድኣት ዝበፅሖ እንተኮይኑ ኩነታት ጉድኣት ይገለፅ)',
              //   ),
              // ),
              const SizedBox(height: 16.0),
              // Multiline comment box
              const Text('\n (ጉድኣት ዝበፅሖ እንተኮይኑ ኩነታት ጉድኣት ይገለፅ)'),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1.0),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: TextFormField(
                  controller:
                      _ifDestructedDescriptionOfHeritageDestructionValueController, // assign the text controller here
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(8.0),
                  ),
                  maxLines: null,
                ),
              ),
              const SizedBox(height: 16.0),
              // Multiline comment box
              const Text('\n ምስቲ ሓድጊ ዘለው ካልኦት ሓድግታት ኩነታቶም ምግላፅ'),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1.0),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: TextFormField(
                  controller:
                      _otherHeritagesStatusController, // assign the text controller here
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(8.0),
                  ),
                  maxLines: null,
                ),
              ),

              // SizedBox(height: 16.0),
              // const Text('\n\n '),
              // TextField(
              //   controller: _conditionOfHeritageDestructionValueController,
              //   decoration: InputDecoration(
              //     labelText: '3.11 ኩነታት ሓደጋ/ስግኣት ኣብቲ ሓድጊ',
              //   ),
              // ),
              const SizedBox(height: 16.0),
              const Text('\n\n3.11 ኩነታት ሓደጋ/ስግኣት ኣብቲ ሓድጊ '),
              ListTile(
                title: const Text('ኣሎ'),
                leading: Radio<String>(
                  value: 'ኣሎ',
                  groupValue:
                      _conditionOfHeritageDestructionValueController.text,
                  onChanged: (value) {
                    setState(() {
                      _conditionOfHeritageDestructionValueController.text =
                          value!;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('የለን'),
                leading: Radio<String>(
                  value: 'የለን',
                  groupValue:
                      _conditionOfHeritageDestructionValueController.text,
                  onChanged: (value) {
                    setState(() {
                      _conditionOfHeritageDestructionValueController.text =
                          value!;
                    });
                  },
                ),
              ),

              // SizedBox(height: 16.0),
              // TextField(
              //   controller:
              //       _descriptionConditionOfHeritageDestructionValueController,
              //   decoration: InputDecoration(
              //     labelText: 'ኣሎ እንተኮይኑ ኣብዚ ይገለፅ',
              //   ),
              // ),
              const SizedBox(height: 16.0),
              // Multiline comment box
              const Text('ኣሎ እንተኮይኑ ኣብዚ ይገለፅ'),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1.0),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: TextFormField(
                  controller:
                      _descriptionConditionOfHeritageDestructionValueController, // assign the text controller here
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(8.0),
                  ),
                  maxLines: null,
                ),
              ),
              // SizedBox(height: 16.0),
              // const Text('\n  '),
              // TextField(
              //   controller: _maintenanceValueController,
              //   decoration: InputDecoration(
              //     labelText: '3.12 ቅድሚ ሐዚ ዝተገበረሉ ናይ ዕቀባን ፅገና ስራሕ',
              //   ),
              // ),
              const SizedBox(height: 16.0),
              const Text('\n3.12. ቅድሚ ሐዚ ዝተገበረሉ ናይ ዕቀባን ፅገና ስራሕ  '),
              ListTile(
                title: const Text('ኣሎ'),
                leading: Radio<String>(
                  value: 'ኣሎ',
                  groupValue: _maintenanceValueController.text,
                  onChanged: (value) {
                    setState(() {
                      _maintenanceValueController.text = value!;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('የለን'),
                leading: Radio<String>(
                  value: 'የለን',
                  groupValue: _maintenanceValueController.text,
                  onChanged: (value) {
                    setState(() {
                      _maintenanceValueController.text = value!;
                    });
                  },
                ),
              ),

              const SizedBox(height: 16.0),
              const Text('\nናይ ፅገና ስራሕ ተካይድሉ ዝነበረ እንተኮይኑ፤'),
              TextField(
                controller: _reasonOfMaintenanceValueController,
                decoration: const InputDecoration(
                  labelText: ' ምኽንያት ፅገናኡ  ',
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _maintainedByValueController,
                decoration: const InputDecoration(
                  labelText: ' ዝፀገኖ ኣካል(ነቲ ፅገና ዘካየደ ኣካል)',
                ),
              ),
              // SizedBox(height: 16.0),
              // TextField(
              //   controller: _maintainedOnController,
              //   decoration: InputDecoration(
              //     labelText: 'ፅገና ዝተካየደሉ እዋን',
              //   ),
              // ),

              const SizedBox(height: 16.0),
              const Text('ፅገና ዝተካየደሉ እዋን'),
              ListTile(
                title: Text(
                  _maintainedOn == null
                      ? 'ሰሌዳ ጊዜ'
                      : 'ፅገና ዝተካየደሉ መዓልቲ: ${_maintainedOn.toString().substring(0, 10)}',
                ),
                leading: const Icon(Icons.calendar_today),
                onTap: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: _maintainedOn ?? DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      _maintainedOn = pickedDate;
                    });
                  }
                },
              ),
              const Text('\nፅገና ዝተካየደሉ በዝሒ ጊዜ'),
              TextField(
                controller: _numberOfMaintenanceValueController,
                decoration: const InputDecoration(
                  labelText: 'ሓንቲ፣ ክልተ፣ሰለስተ፣ ብዙሕ ጊዜ',
                ),
              ),
              // SizedBox(height: 16.0),
              // const Text('\n'),
              // TextField(
              //   controller: _evaluationOnMaintenanceValueController,
              //   decoration: InputDecoration(
              //     labelText: '3.12.1  ግምገማ እቲ ዝተገበረ ናይ ፅገና/ምዕቃብ ስራሕ ከመይ ኔሩ ? ',
              //   ),
              // ),
              const SizedBox(height: 16.0),
              const Text('\n3.12.1 ግምገማ እቲ ዝተገበረ ናይ ፅገና/ምዕቃብ ስራሕ ከመይ ኔሩ ? '),
              ListTile(
                title: const Text(' ብጣዕሚ ፅቡቕ'),
                leading: Radio<String>(
                  value: 'ብጣዕሚ ፅቡቕ',
                  groupValue: _evaluationOnMaintenanceValueController.text,
                  onChanged: (value) {
                    setState(() {
                      _evaluationOnMaintenanceValueController.text = value!;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('ፅቡቕ'),
                leading: Radio<String>(
                  value: 'ፅቡቕ',
                  groupValue: _evaluationOnMaintenanceValueController.text,
                  onChanged: (value) {
                    setState(() {
                      _evaluationOnMaintenanceValueController.text = value!;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('ማእኸላይ'),
                leading: Radio<String>(
                  value: 'ማእኸላይ',
                  groupValue: _evaluationOnMaintenanceValueController.text,
                  onChanged: (value) {
                    setState(() {
                      _evaluationOnMaintenanceValueController.text = value!;
                    });
                  },
                ),
              ),

              ListTile(
                title: const Text('ትሑት'),
                leading: Radio<String>(
                  value: 'ትሑት',
                  groupValue: _evaluationOnMaintenanceValueController.text,
                  onChanged: (value) {
                    setState(() {
                      _evaluationOnMaintenanceValueController.text = value!;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('ብጣዕሚ ትሑት'),
                leading: Radio<String>(
                  value: 'ብጣዕሚ ትሑት',
                  groupValue: _evaluationOnMaintenanceValueController.text,
                  onChanged: (value) {
                    setState(() {
                      _evaluationOnMaintenanceValueController.text = value!;
                    });
                  },
                ),
              ),

              // SizedBox(height: 16.0),
              // TextField(
              //   controller: _evaluationAnswerDescriptionValueController,
              //   decoration: InputDecoration(
              //     labelText: 'ሕድሕድ መልሲ ብእኩልን ብቑዕን ምክንያት ኣብዚ ይደገፍ/ይገለፅ)',
              //   ),
              // ),
              const SizedBox(height: 16.0),
              // Multiline comment box
              const Text('\n ሕድሕድ መልሲ ብእኩልን ብቑዕን ምክንያት ኣብዚ ይደገፍ/ይገለፅ)'),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1.0),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: TextFormField(
                  controller:
                      _evaluationAnswerDescriptionValueController, // assign the text controller here
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(8.0),
                  ),
                  maxLines: null,
                ),
              ),

              // SizedBox(height: 16.0),
              // const Text('\n'),
              // TextField(
              //   controller:
              //       _startingDateOfSinceAdministeredByCurrentOwnerController,
              //   decoration: InputDecoration(
              //     labelText: '3.13 እቲ ሓድጊ በቲ ናይ ሐዚ ብበዓል ዋና ምምሕዳር ዝጀመረሉ እዋን',
              //   ),
              // ),

              const SizedBox(height: 16.0),
              const Text('3.15 እቲ ሓድጊ በቲ ናይ ሐዚ ብበዓል ዋና ምምሕዳር ዝጀመረሉ እዋን'),
              ListTile(
                title: Text(
                  _startingDateSinceAdministered == null
                      ? 'ሰሌዳ ጊዜ'
                      : 'ብበዓል ዋና ምምሕዳር ዝጀመረሉ እዋን: ${_startingDateSinceAdministered.toString().substring(0, 10)}',
                ),
                leading: const Icon(Icons.calendar_today),
                onTap: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate:
                        _startingDateSinceAdministered ?? DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      _startingDateSinceAdministered = pickedDate;
                    });
                  }
                },
              ),

              // SizedBox(height: 16.0),
              // const Text('\n'),
              // TextField(
              //   controller: _accessibilityOfHeritageValueController,
              //   decoration: InputDecoration(
              //     labelText: '3.14 ተበፃሓይነት እቲ ሓድጊ',
              //   ),
              // ),

              const SizedBox(height: 16.0),
              const Text('\n3.14 ተበፃሓይነት እቲ ሓድጊ'),
              ListTile(
                title: const Text(' ብጣዕሚ ፅቡቕ'),
                leading: Radio<String>(
                  value: 'ብጣዕሚ ፅቡቕ',
                  groupValue: _accessibilityOfHeritageValueController.text,
                  onChanged: (value) {
                    setState(() {
                      _accessibilityOfHeritageValueController.text = value!;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('ፅቡቕ'),
                leading: Radio<String>(
                  value: 'ፅቡቕ',
                  groupValue: _accessibilityOfHeritageValueController.text,
                  onChanged: (value) {
                    setState(() {
                      _accessibilityOfHeritageValueController.text = value!;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('ማእኸላይ'),
                leading: Radio<String>(
                  value: 'ማእኸላይ',
                  groupValue: _accessibilityOfHeritageValueController.text,
                  onChanged: (value) {
                    setState(() {
                      _accessibilityOfHeritageValueController.text = value!;
                    });
                  },
                ),
              ),

              ListTile(
                title: const Text('ትሑት'),
                leading: Radio<String>(
                  value: 'ትሑት',
                  groupValue: _accessibilityOfHeritageValueController.text,
                  onChanged: (value) {
                    setState(() {
                      _accessibilityOfHeritageValueController.text = value!;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('ብጣዕሚ ትሑት'),
                leading: Radio<String>(
                  value: 'ብጣዕሚ ትሑት',
                  groupValue: _accessibilityOfHeritageValueController.text,
                  onChanged: (value) {
                    setState(() {
                      _accessibilityOfHeritageValueController.text = value!;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('የብሉን'),
                leading: Radio<String>(
                  value: 'የብሉን',
                  groupValue: _accessibilityOfHeritageValueController.text,
                  onChanged: (value) {
                    setState(() {
                      _accessibilityOfHeritageValueController.text = value!;
                    });
                  },
                ),
              ),

              // SizedBox(height: 16.0),
              // const Text('\n'),
              // TextField(
              //   controller: _descriptionOfAccessibilityHeritageValueController,
              //   decoration: InputDecoration(
              //     labelText: 'ሕድሕድ መልሲ ብእኩልን ብቑዕን ምክንያት ኣብዚ ይደገፍ/ይገለፅ)',
              //   ),
              // ),

              const SizedBox(height: 16.0),
              // Multiline comment box
              const Text('\n ሕድሕድ መልሲ ብእኩልን ብቑዕን ምክንያት ኣብዚ ይደገፍ/ይገለፅ)'),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1.0),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: TextFormField(
                  controller:
                      _descriptionOfAccessibilityHeritageValueController, // assign the text controller here
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(8.0),
                  ),
                  maxLines: null,
                ),
              ),

              // SizedBox(height: 16.0),
              // const Text('\n'),
              // TextField(
              //   controller: _typesEvidencesController,
              //   decoration: InputDecoration(
              //     labelText: '4.ተዛመድቲ መረዳእታታት እቲ ሓድጊ (ዘለውዎ እንተኮይኖም)',
              //   ),
              // ),

              const SizedBox(height: 16.0),
              const Text('\n\n4. ተዛመድቲ መረዳእታታት እቲ ሓድጊ (ዘለውዎ እንተኮይኖም)'),

              CheckboxListTile(
                title: const Text('መፅሓፍ'),
                value: _selectedEvidences.contains('መፅሓፍ'),
                onChanged: (value) => _toggleTypesEvidences('መፅሓፍ'),
              ),
              CheckboxListTile(
                title: const Text('ስእሊ/ፎቶ'),
                value: _selectedEvidences.contains('ስእሊ/ፎቶ'),
                onChanged: (value) => _toggleTypesEvidences('ስእሊ/ፎቶ'),
              ),
              CheckboxListTile(
                title: const Text('ካርታ'),
                value: _selectedEvidences.contains('ካርታ'),
                onChanged: (value) => _toggleTypesEvidences('ካርታ'),
              ),
              CheckboxListTile(
                title: const Text('መዝገብ'),
                value: _selectedEvidences.contains('መዝገብ'),
                onChanged: (value) => _toggleTypesEvidences('መዝገብ'),
              ),
              CheckboxListTile(
                title: const Text('ሰነድ'),
                value: _selectedEvidences.contains('ሰነድ'),
                onChanged: (value) => _toggleTypesEvidences('ሰነድ'),
              ),
              CheckboxListTile(
                title: const Text('ፕላን'),
                value: _selectedEvidences.contains('ፕላን'),
                onChanged: (value) => _toggleTypesEvidences('ፕላን'),
              ),
              // SizedBox(height: 16.0),
              // const Text('\n'),
              // TextField(
              //   controller: _ifOtherTypeEvidenceValueController,
              //   decoration: InputDecoration(
              //     labelText: 'ካልእ እንተሃልዩ ብፍሉይ ኣብዚ ይጠቐስ፡',
              //   ),
              // ),
              // const SizedBox(height: 16.0),
              // // Multiline comment box
              // const Text('\n ካልእ እንተሃልዩ ብፍሉይ ኣብዚ ይጠቐስ፡'),
              // Container(
              //   decoration: BoxDecoration(
              //     border: Border.all(width: 1.0),
              //     borderRadius: BorderRadius.circular(4.0),
              //   ),
              //   child: TextFormField(
              //     decoration: const InputDecoration(
              //       border: InputBorder.none,
              //       contentPadding: EdgeInsets.all(8.0),
              //     ),
              //     maxLines: null,
              //     onSaved: (value) {
              //       _ifOtherTypeEvidenceValueController.text = value!;
              //     },
              //   ),
              // ),
              const SizedBox(height: 16.0),
              const Text('\n ካልእ እንተሃልዩ ብፍሉይ ኣብዚ ይጠቐስ፡'),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1.0),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: TextFormField(
                  controller:
                      _ifOtherTypeEvidenceValueController, // assign the text controller here
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(8.0),
                  ),
                  maxLines: null,
                ),
              ),
              // SizedBox(height: 16.0),
              // TextField(
              //   controller: _mythValueController,
              //   decoration: InputDecoration(
              //     labelText: 'ኣፈ ታሪኽ',
              //   ),
              // ),
              const Text('4.1. መረዳእታ አፈ ታሪኽ ናይቲ ሓድጊ ወይ ሓድጊ ቦታ'),
              ListTile(
                title: const Text('ኣለዎ'),
                leading: Radio<String>(
                  value: 'ኣለዎ',
                  groupValue: _mythValueController.text,
                  onChanged: (value) {
                    setState(() {
                      _mythValueController.text = value!;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('የብሉን'),
                leading: Radio<String>(
                  value: 'የብሉን',
                  groupValue: _mythValueController.text,
                  onChanged: (value) {
                    setState(() {
                      _mythValueController.text = value!;
                    });
                  },
                ),
              ),

              // SizedBox(height: 16.0),
              // TextField(
              //   controller: _ifThereIsMythsController,
              //   decoration: InputDecoration(
              //     labelText: 'ኣፈ ታሪኽ እንተሃልይዎ ኣብዚ ይገለፅ',
              //   ),
              // ),

              const Text('ዘለዎ እንተኮይኑ እቲ ኣፈ-ታሪክ ብሓፂሩ ኣብዚ ይጠቐስ፤'),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1.0),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: TextFormField(
                  controller:
                      _ifThereIsMythsController, // assign the text controller here
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(8.0),
                  ),
                  maxLines: null,
                ),
              ),

              const SizedBox(height: 16.0),
              const Text('\n5. ሓላዊ እቲ ሓድጊ/ሓድጊ ቦታ'),
              TextField(
                controller: _keeperNameValueController,
                decoration: const InputDecoration(
                  labelText: '5.1 ሽም',
                ),
              ),

              // SizedBox(height: 16.0),
              // TextField(
              //   controller: _keeperWorkResponsibilityValueController,
              //   decoration: InputDecoration(
              //     labelText: '5.2 ስራሕ ሓላፍነት\n',
              //   ),
              // ),
              // ElevatedButton(
              //   onPressed: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) => Keepersignatureimage(
              //                 id: widget.id,
              //               )),
              //     );
              //   },
              //   child: Text('ፌርማ'),
              // ),
              const SizedBox(height: 16.0),
              const Text('\n6. መረዳእታ ወሃቢ ኣካል'),
              TextField(
                controller: _heritageInformantNameValueController,
                decoration: const InputDecoration(
                  labelText: '6.1 ሽም ',
                ),
              ),
              // SizedBox(height: 16.0),
              // TextField(
              //   controller: _genderValueController,
              //   decoration: InputDecoration(
              //     labelText: '6.2 ፆታ',
              //   ),
              // ),

              const SizedBox(height: 16.0),
              const Text('6.2 ፆታ'),
              ListTile(
                title: const Text('ወዲ ተባዕታይ'),
                leading: Radio<String>(
                  value: 'ወዲ ተባዕታይ ',
                  groupValue: _genderValueController.text,
                  onChanged: (value) {
                    setState(() {
                      _genderValueController.text = value!;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('ጓል ኣንስተይቲ'),
                leading: Radio<String>(
                  value: 'ጓል ኣንስተይቲ',
                  groupValue: _genderValueController.text,
                  onChanged: (value) {
                    setState(() {
                      _genderValueController.text = value!;
                    });
                  },
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _ageValueController,
                decoration: const InputDecoration(
                  labelText: '6.3 ዕድመ',
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _workResponsibilityValueController,
                decoration: const InputDecoration(
                  labelText: '6.4 ስራሕ ሓላፍነት',
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _otherInformationValueController,
                decoration: const InputDecoration(
                  labelText: '6.5 ካልእ',
                ),
              ),
              const SizedBox(height: 16.0),
              const Text('\n7. ናይ መዝጋቢ መረዳእታ'),
              TextField(
                controller: _nameOfDataCollectorController,
                decoration: const InputDecoration(
                  labelText: '7.1 ሽም',
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _nameOfOrganizationController,
                decoration: const InputDecoration(
                  labelText: '7.2 ሽም ዝሰርሕሉ ትካል',
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _positionController,
                decoration: const InputDecoration(
                  labelText: '7.3 መደብ ስራሕ ',
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _roleController,
                decoration: const InputDecoration(
                  labelText: '7.4 ስራሕ ሓላፍነት ',
                ),
              ),
              const Text('\n'),

              // ElevatedButton(
              //   onPressed: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) => Signatureimagenonmov(
              //                 id: widget.id,
              //               )),
              //     );
              //   },
              //   child: Text('ፌርማ'),
              // ),
              // SizedBox(height: 16.0),
              // TextField(
              //   controller: _registrationDateOfHeritageController,
              //   decoration: InputDecoration(
              //     labelText: '7.5. እቲ ሓድጊ ዝተመዝገበሉ መዓልቲ ',
              //   ),
              // ),
              const SizedBox(height: 16.0),
              const Text('7.5 እቲ ሓድጊ ዝተመዝገበሉ መዓልቲ '),
              ListTile(
                title: Text(
                  _registrationDateOfHeritage == null
                      ? 'ሰሌዳ ጊዜ'
                      : 'ሓድጊ ዝተመዝገበሉ መዓልቲ: ${_registrationDateOfHeritage.toString().substring(0, 10)}',
                ),
                leading: const Icon(Icons.calendar_today),
                onTap: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: _registrationDateOfHeritage ?? DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      _registrationDateOfHeritage = pickedDate;
                    });
                  }
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _updateUserInfo,
                child: const Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
