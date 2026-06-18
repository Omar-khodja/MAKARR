

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:makarr/feature/pymente/data/datasource/subscription%20_datasource.dart';
import 'package:makarr/feature/pymente/data/repository/subscription_repo.dart';
import 'package:makarr/feature/pymente/domain/usecase/subscription_usecase.dart';

final subscriptionDataSource = Provider((ref) => SubSubscriptionDatasource(),);
final subSubscriptionrepo = Provider((ref) => SubscriptionRepo(dataSource: ref.read(subscriptionDataSource)),);


final subSubscriptionUserCase = Provider((ref) => SubscriptionUsecase(repo: ref.read(subSubscriptionrepo)),);