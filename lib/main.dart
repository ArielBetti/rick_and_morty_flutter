import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_flutter/widgets/custom_scroll_behavior.dart';
import 'package:rick_and_morty_flutter/widgets/person_card.dart';

import 'blocs/rick_and_morty_bloc.dart';

void main() {
  runApp(const MyApp());
}

Widget _buildLoading() => const Center(child: CircularProgressIndicator());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      scrollBehavior: CustomScrollBehavior(),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor:  Color.fromRGBO(30, 41, 59, 1),
          title: const Text('Rick and Morty'),
        ),
        backgroundColor: Color.fromRGBO(15, 23, 42, 1),
        body: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final RickAndMortyBloc _rickAndMortyBloc = RickAndMortyBloc();

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    _rickAndMortyBloc.add(GetRickAndMortyCharacterList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (_) => _rickAndMortyBloc,
        child: BlocListener<RickAndMortyBloc, RickAndMortyState>(
          listener: (context, state) {
            if (state is RickAndMortyError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message!),
                ),
              );
            }
          },
          child: BlocBuilder<RickAndMortyBloc, RickAndMortyState>(
            builder: (context, state) {
              if (state is RickAndMortyInitial) {
                return _buildLoading();
              } else if (state is RickAndMortyLoading) {
                return _buildLoading();
              } else if (state is RickAndMortyLoaded) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.data.length,
                  itemBuilder: (context, index) => Wrap(
                    direction: Axis.vertical,
                    children: [
                      PersonCard(
                          name: state.data[index].name.toString(),
                          status: state.data[index].status.toString(),
                          lastLocation:
                              state.data[index].location!.name.toString(),
                          species: state.data[index].species.toString(),
                          imageUrl: state.data[index].image.toString()),
                    ],
                  ),
                );
              } else if (state is RickAndMortyError) {
                return Container();
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}
