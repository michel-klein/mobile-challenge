import 'package:flutter/material.dart';
import 'package:mobile_challenge/models/filter_gender.dart';
import 'package:mobile_challenge/models/person_list.dart';
import 'package:mobile_challenge/models/state_gender.dart';
import 'package:provider/provider.dart';

class FilterDialog extends StatefulWidget {
  const FilterDialog({Key? key}) : super(key: key);

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  @override
  Widget build(BuildContext context) {
    final genderSelection = Provider.of<StateGender>(context);
    FilterGender filterGender = genderSelection.filterGender;

    return Dialog(
      child: Container(
        height: 200,
        child: Stack(children: [
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Filter by gender:'),
                SwitchListTile.adaptive(
                    title: Text('Male'),
                    value: filterGender.filterMale,
                    onChanged: (value) {
                      setState(() {
                        filterGender.filterMale = value;
                        Provider.of<StateGender>(context, listen: false)
                            .changeFilterGender(filterGender);
                        Provider.of<PersonList>(context, listen: false)
                            .FilterGenderItems(filterGender);
                      });
                    }),
                SwitchListTile.adaptive(
                    title: Text('Female'),
                    value: filterGender.filterFemale,
                    onChanged: (value) {
                      setState(() {
                        filterGender.filterFemale = value;
                        Provider.of<StateGender>(context, listen: false)
                            .changeFilterGender(filterGender);
                        Provider.of<PersonList>(context, listen: false)
                            .FilterGenderItems(filterGender);
                      });
                    }),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: Icon(Icons.close),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ]),
      ),
    );
  }
}
