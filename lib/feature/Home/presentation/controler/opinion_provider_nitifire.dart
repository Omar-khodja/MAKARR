import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:makarr/feature/Home/domain/entities/opinion.dart';
import 'package:makarr/feature/Home/domain/usecase/pinion_usecase.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:makarr/feature/Home/presentation/controler/post_provider.dart';

class OpinionProviderNitifire extends StateNotifier<AsyncValue<Opinion>> {
  OpinionProviderNitifire({required this.opinion})
    : super(const AsyncValue.loading());
  final OpinionUsecase opinion;

  Future<bool> setOpinion(Opinion opinio) async {
    state = const AsyncValue.loading();

    final resulr = await opinion.call(opinio);
    return  resulr.fold(
      (failure) {
           state = AsyncValue.error(failure.message, StackTrace.current);
           Fluttertoast.showToast(
        msg: 'Somthing went worng try again late!',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
        return false;
      },
      (opinio){

      Fluttertoast.showToast(
        msg: 'Opinion set successfully',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
      return true;
      } 
    );
  }
}

final opinionProvider =
    StateNotifierProvider<OpinionProviderNitifire, AsyncValue<Opinion>>(
      (ref) =>
          OpinionProviderNitifire(opinion: ref.read(opinionUsecaseProvider)),
    );
