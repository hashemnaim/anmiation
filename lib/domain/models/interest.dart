import 'package:equatable/equatable.dart';
import 'package:vario/data/interests_data.dart';

class Interest extends Equatable {
  final String label;
  final String id;
  final String emoji;

  String get answerText => '$emoji $label';

  const Interest(this.label, this.id, this.emoji);

  @override
  List<Object> get props => [id, label];

  static final List<Interest> all = [
    kTechnologieInterest,
    kNachhaltigkeitInterest,
    kBusinessInterest,
    kMedizinInterest,
    kKuenstlicheIntelligenzInterest,
    kShoppingInterest,
    kBiotechnologieInterest,
    kBlockchainInterest,
    kUnterhaltungInterest,
    kFinanzenInterest,
    kModeInterest,
    kGamingInterest,
    kReisenInterest,
    kImmobilienInterest,
    kSportInterest,
    kSocialMediaInterest,
    kLuxusInterest,
    kRaumfahrtInterest,
    kVirtualRealityInterest,
    k420Interest,
    kEssenUndTrinkenInterest,
  ];
}
