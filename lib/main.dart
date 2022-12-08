import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  const MyHomePage(title: 'Flutter Demo Home Page'),
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
                  itemCount: state.data.length,
                  itemBuilder: (context, index) => Stack(
                    children: [
                      Text(state.data[index].name.toString())
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
