import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_challenge/models/person.dart';

class DetailsScreen extends StatelessWidget {
  final Person person;
  const DetailsScreen({
    Key? key,
    required this.person,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Align(
        alignment: Alignment.center,
        child: Container(
          height: 1000,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 100,
                backgroundImage: NetworkImage(person.imageUrl),
              ),
              Text(
                '${person.firstName} ${person.lastName}',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                color: Theme.of(context).colorScheme.secondary,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text('Email: ${person.email}', style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),),
                        Divider(color: Theme.of(context).colorScheme.primary),
                        Text(
                            'Gender: ${toBeginningOfSentenceCase(person.gender)!}', style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),),
                        Divider(color: Theme.of(context).colorScheme.primary),
                        Text(
                            'Birth Date: ${DateFormat('dd/MM/yyyy').format(DateTime.parse(person.birthDate))}', style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),),
                        Divider(color: Theme.of(context).colorScheme.primary),
                        Text('Phone Number: ${person.phone}', style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),),
                        Divider(color: Theme.of(context).colorScheme.primary),
                        Text('Country: ${person.country}', style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),),
                        Divider(color: Theme.of(context).colorScheme.primary),
                        Text(
                            'Address: ${person.streetName}, ${person.streetNumber} - ${person.city}', style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),),
                        Divider(color: Theme.of(context).colorScheme.primary),
                        Text(
                            'Id (Institution): ${person.idValue} (${person.idName})', style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      Align(
        alignment: Alignment.topRight,
        child: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
    ]);
  }
}
