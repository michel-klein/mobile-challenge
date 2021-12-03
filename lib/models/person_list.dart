import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as html;

import 'filter_gender.dart';
import 'person.dart';

class PersonList with ChangeNotifier {
  List<Person> _items = [];
  List<Person> _cacheItems = [];
  static const String _url = 'https://randomuser.me/api/?results=50';

  int get personCount {
    return _cacheItems.length;
  }

  List<Person> get items => [..._cacheItems];

  void FilterGenderItems(FilterGender filterGender) {
    final personFemale =
        _items.where((person) => person.gender == 'female').toList();
    print(personFemale);
    final personMale =
        _items.where((person) => person.gender == 'male').toList();
    print(personMale);
    List<Person> listGender = [];

    if (filterGender.filterMale && filterGender.filterFemale) {
      listGender = [..._items];
    } else if (filterGender.filterMale) {
      listGender = [...personMale];
    } else if (filterGender.filterFemale) {
      listGender = [...personFemale];
    }

    _cacheItems = [...listGender];

    notifyListeners();
  }

  void filterCountry(String country) {
    List<Person> personCountry = [];
    final filterPerson =
        _items.where((person) => person.country == country).toList();

    if (filterPerson.isNotEmpty) {
      personCountry = [...filterPerson];
    }

    if (country.isEmpty) {
      _cacheItems = [..._items];
    } else {
      _cacheItems = [...personCountry];
    }

    notifyListeners();
  }

  Future<void> loadPerson() async {
    final response = await html.get(Uri.parse(_url));
    if (response.body == 'null') return;

    final result = jsonDecode(response.body)['results'];
    result.forEach((persondata) {
      final nameData = persondata['name'];
      final locationData = persondata['location'];
      final streetData = locationData['street'];
      final birthData = persondata['dob'];
      final idData = persondata['id'];
      final pictureOptions = persondata['picture'];

      _items.add(Person(
        imageUrl: pictureOptions['large']?.toString() ?? '',
        firstName: nameData['first']?.toString() ?? '',
        lastName: nameData['last']?.toString() ?? '',
        email: persondata['email']?.toString() ?? '',
        gender: persondata['gender']?.toString() ?? '',
        birthDate: birthData['date']?.toString() ?? '',
        phone: persondata['phone']?.toString() ?? '',
        streetNumber: streetData['number']?.toString() ?? '',
        streetName: streetData['name']?.toString() ?? '',
        city: locationData['city']?.toString() ?? '',
        state: locationData['state']?.toString() ?? '',
        country: locationData['country']?.toString() ?? '',
        idName: idData['name']?.toString() ?? '',
        idValue: idData['value']?.toString() ?? '',
      ));
    });
    _cacheItems = [..._items];
    notifyListeners();
  }
}
