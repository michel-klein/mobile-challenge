import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_challenge/models/filter_gender.dart';
import 'package:mobile_challenge/models/person.dart';
import 'package:mobile_challenge/models/person_list.dart';
import 'package:mobile_challenge/models/state_gender.dart';
import 'package:mobile_challenge/screens/details_screen.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

class PersonListWidget extends StatelessWidget {
  // final bool filterGender;

  // personListWidget(this.filterGender);

  const PersonListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final genderSelection = Provider.of<StateGender>(context);
    print(genderSelection.stateGender.filterFemale.toString() + genderSelection.stateGender.filterMale.toString());
    final provider = Provider.of<PersonList>(context);
    final List<Person> loadedPerson = provider.items;

    _openDetailsModal(BuildContext context, Person person) {
      showModalBottomSheet(
        backgroundColor: Theme.of(context).colorScheme.background,
        context: context,
        isScrollControlled: true,
        builder: (_) {
          return FractionallySizedBox(
              heightFactor: 0.7, child: DetailsScreen(person: person));
        },
      );
    }

    return loadedPerson.isEmpty
        ? Container()
        : ListView.builder(
            itemCount: loadedPerson.length,
            itemBuilder: (ctx, index) {
              final Person person = loadedPerson[index];
              return InkWell(
                onTap: () => _openDetailsModal(context, person),
                child: Card(
                  color: Theme.of(context).colorScheme.secondary,
                  elevation: 5,
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(person.imageUrl),
                      ),
                      title: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '${person.firstName} ${person.lastName}',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                toBeginningOfSentenceCase(person.gender)!,
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              Text(
                                DateFormat('dd/MM/yyyy')
                                    .format(DateTime.parse(person.birthDate)),
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
  }
}
