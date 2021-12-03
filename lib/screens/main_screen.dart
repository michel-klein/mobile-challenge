import 'package:flutter/material.dart';
import 'package:mobile_challenge/components/filter_dialog.dart';
import 'package:mobile_challenge/components/person_list_widget.dart';
import 'package:mobile_challenge/models/person_list.dart';
import 'package:provider/provider.dart';

class mainScreen extends StatefulWidget {
  const mainScreen({Key? key}) : super(key: key);

  @override
  State<mainScreen> createState() => _mainScreenState();
}

class _mainScreenState extends State<mainScreen> {
  bool _isLoading = true;
  final _countryController = TextEditingController();

  _submitForm() {
    final country = _countryController.text;   

    Provider.of<PersonList>(context, listen: false).filterCountry(country);
  }

  @override
  void initState() {
    super.initState();
    Provider.of<PersonList>(context, listen: false)
        .loadPerson()
        .then((value) => setState(() {
              _isLoading = false;
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          title: Text('Pessoas Cadastradas | Pharma Inc.'),
        ),
        body: LayoutBuilder(
          builder: (ctx, constraints) {
            return Column(
              children: [
                Container(
                  height: constraints.maxHeight * 0.20,
                  child: Center(child: Image.asset('assets/logo.png')),
                ),
                _isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Column(
                        children: [
                          Container(
                            height: constraints.maxHeight * 0.1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextField(
                                      controller: _countryController,
                                      onSubmitted: (_) => _submitForm(),
                                      decoration: InputDecoration(
                                        labelText: 'Country search',
                                        suffixIcon: Icon(Icons.person_search_sharp),
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) => FilterDialog());
                                  },
                                  icon: Icon(Icons.filter_alt),
                                  iconSize: 36,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: constraints.maxHeight * 0.6,
                            child: PersonListWidget(),
                          ),
                          Container(
                            height: constraints.maxHeight * 0.1,
                            child: TextButton(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(Icons.cached),
                                  ),
                                  Text('Carregar mais'),
                                ],
                              ),
                              onPressed: () {
                                Provider.of<PersonList>(context, listen: false)
                                    .loadPerson();
                              },
                            ),
                          ),
                        ],
                      ),
              ],
            );
          },
        ));
  }
}
