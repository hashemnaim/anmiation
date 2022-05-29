part of 'asset_news_cubit.dart';

abstract class AssetNewsState extends Equatable {
  const AssetNewsState();

  @override
  List<Object> get props => [];
}

class AssetNewsInitial extends AssetNewsState {}

class AssetNewsLoading extends AssetNewsState {}

class AssetNewsLoaded extends AssetNewsState {
  final List<AnalysisArticle> articles;

  AssetNewsLoaded(this.articles);

  @override
  List<Object> get props => [articles];
}

class AssetNewsError extends AssetNewsState {
  // @override
  // final GlobalErrorData error;

  // AssetNewsError(this.error);

  // @override
  // List<Object> get props => [error];
}
