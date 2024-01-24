import 'package:bloc_tutorial/bloc/cats_cubit.dart';
import 'package:bloc_tutorial/bloc/cats_repostory.dart';
import 'package:bloc_tutorial/bloc/cats_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocCatsView extends StatefulWidget {
  const BlocCatsView({super.key});

  @override
  State<BlocCatsView> createState() => _BlocCatsViewState();
}

class _BlocCatsViewState extends State<BlocCatsView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CatsCubit(CatsRepo()),
      child: buildScaffold(context),
    );
  }

  Scaffold buildScaffold(BuildContext context) => Scaffold(
        // floatingActionButton: buildButtonCall(context),
        appBar: AppBar(
          title: const Text('Bloc Cats'),
        ),
        body: BlocConsumer<CatsCubit, CatsState>(
          listener: (context, state) {
            if (state is CatsError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  duration: const Duration(seconds: 1),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is CatsInitial) {
              return buildInitial(context);
            } else if (state is CatsLoading) {
              return buildLoading();
            } else if (state is CatsCompleted) {
              return buildComplete(state);
            } else {
              return buildError(state);
            }
          },
        ),
      );

  Center buildError(CatsState state) {
    final error = state as CatsError;
    return Center(child: Text(error.message));
  }

  ListView buildComplete(CatsCompleted state) {
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        title: Image.network(state.response[index].imageUrl as String),
        subtitle: Text(state.response[index].description as String),
      ),
      itemCount: state.response.length,
    );
  }

  Center buildLoading() => const Center(child: CircularProgressIndicator());

  Center buildInitial(BuildContext context) {
    return Center(
        child: Column(
      children: [const Text('Hello'), buildButtonCall(context)],
    ));
  }

  FloatingActionButton buildButtonCall(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.clear_all),
      onPressed: () {
        BlocProvider.of<CatsCubit>(context).getCats();
      },
    );
  }
}
