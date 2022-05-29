import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:pedantic/pedantic.dart';
import 'package:vario/domain/models/investment_item/backend/swipe_screen_data_model.dart';

import '../domain/models/currency.dart';
import '../domain/models/investment_item/country.dart';
import '../domain/models/investment_item/investment_item.dart';
import '../domain/models/investment_item/investment_topic.dart';
import '../domain/models/investment_item/rating.dart';
import '../domain/models/investment_item/regions.dart';
import '../domain/models/investment_item/sector.dart';
import '../domain/models/investment_item/stock.dart';

import '../domain/models/investment_item/stock_risk_class.dart';

import '../locator.dart';

/// Used especially for swiping on the [SwipeScreen].
class InvestmentItemService {
  /// Queue of all suggestions that might be relevant for the user and that can be swiped.
  final List<InvestmentItem> _upcomingSwipeItems = [];

  /// Queue of all suggestions that might be relevant for the user and that can be swiped.
  List<InvestmentItem> get upcomingSwipeItems => _upcomingSwipeItems;

  Future<List<Stock>> getDummyData() async {
    await (Future.delayed(Duration(milliseconds: 1500)));
    return [
      Stock.fromBackend(
          'TSLA',
          SwipeScreenDataModel.fromJson(json.decode(
              '{"name":"Tesla","logoUrl":"https://storage.googleapis.com/vario-dev-assets/logos/TSLA.svg?X-Goog-Algorithm=GOOG4-RSA-SHA256&X-Goog-Credential=firebase-adminsdk-cfp7v%40vario-dev.iam.gserviceaccount.com%2F20211112%2Fauto%2Fstorage%2Fgoog4_request&X-Goog-Date=20211112T165631Z&X-Goog-Expires=172801&X-Goog-SignedHeaders=host&X-Goog-Signature=7ea9cd4d816d508c3c6ce3a442cb676106d50c1fd64ef50807180b30e12bf5bd9c7db918d435d76c2d8848dc107e9a76fd72e7f5d4a9be151331d0856151e8e6e6800559328430bf6651b2559496e11aff3476b97a376f2942f75e0da0c4dc070750e469aaf5abdc79ccf7f5218704e714ab3bceda7d1bb284a78d3e19891b0f9bbc5254bcffdf7da26acad268a8d6eff4ef3d257143ae655053acb945e85d8b0f6528ace64b4d3bc60d16b71cfa81e602e5a1dc28f35c9c90bb176f6ea5fcf58fde97ff9712bfe42d513aed0eff64938905a5b68e3cbfeec2fe7e2b5776644c2f61df561d6a7e79e7ebd129e445e383e84a2ca4f9154e1c34c41fb9f518da4b","logoFileType":"svg","colorHexCode":"E82127","pictureUrl":"https://storage.googleapis.com/vario-dev-assets/images/TSLA.jpg?X-Goog-Algorithm=GOOG4-RSA-SHA256&X-Goog-Credential=firebase-adminsdk-cfp7v%40vario-dev.iam.gserviceaccount.com%2F20211112%2Fauto%2Fstorage%2Fgoog4_request&X-Goog-Date=20211112T165631Z&X-Goog-Expires=172801&X-Goog-SignedHeaders=host&X-Goog-Signature=080125a511c67e9352906b913d4ab610a103edf5d4ff4266bf5c0b2b9ec699f14d9a715ce7ecfd238368bba991fab8e538e2ee844b6f8e590e15b9ced55f3a8cb27c0828f281ce97eafa2fc16ff3ddaf4fab294156e15c85db42e0fc123c9ff0354f7b67457f05c8d048dbbfd3a89ad785b3b2340210fa20a890b76bf3f4810133adec2917df00c20a8393b60beaf38c2193a5e733bf3eccdeb61605ca0cf2a6de8597fa099fe60cdaf31616bb8dc44bd04f0a8bd9d33a5fe456d5b7d4053cff2fdc72cbe94f7bf99ac058045c5ad751211499d1443f71d4c58ed2e88ee9d63da9bc31675a3cb8d77e68f28676de414309de09024dec52f1de47fec264c7eb37","description":"Tesla ist der führende Hersteller von luxuriösen Elektroautos und sowie von Stromspeicher- und Photovoltaikanlagen. Geführt wird Tesla vom visionären Unternehmer Elon Musk.","country":"US","countryEmoji":"flag-us","region":{"id":"northAmerica","name":"Nordamerika"},"sector":{"id":"durables","name":"Gebrauchsgüter","emoji":"shopping_bags","color":"#0DB39E"},"riskClass":"growth","topics":[{"id":"Elektromobilität","name":"Elektromobilität","emoji":"seedling","color":"#5FCC29"},{"id":"Nachhaltigkeit","name":"Nachhaltigkeit","emoji":"seedling","color":"#5FCC29"},{"id":"Künstliche Intelligenz","name":"Künstliche Intelligenz","emoji":"robot_face","color":"#CC2996"},{"id":"Erneuerbare Energien","name":"Erneuerbare Energien","emoji":"seedling","color":"#5FCC29"},{"id":"Automatisierung","name":"Automatisierung","emoji":"desktop_computer","color":"#295FCC"},{"id":"Recycling","name":"Recycling","emoji":"seedling","color":"#5FCC29"},{"id":"Luxus","name":"Luxus","emoji":"gem","color":"#B9AD56"}],"varioScore":6,"ratingScore":0.8098842884764115,"arguments":["Visionärer Gründer und Chef","Möchten die Welt nachhaltiger machen","Innovative Produkte"],"currency":"EUR","pricePerStock":742.9429799999999,"value":604534804552.0,"returnPerYear":1.4473408782821404,"returnYearsCount":10,"currentSalesGrowth":0.28309870615998056,"ticker":"TSLA","performance":214.11301799916285}'))),
      Stock.fromBackend(
          'VZ',
          SwipeScreenDataModel.fromJson(json.decode(
              '{"name":"Verizon Communications","logoUrl":"https://storage.googleapis.com/vario-dev-assets/logos/VZ.svg?X-Goog-Algorithm=GOOG4-RSA-SHA256&X-Goog-Credential=firebase-adminsdk-cfp7v%40vario-dev.iam.gserviceaccount.com%2F20211112%2Fauto%2Fstorage%2Fgoog4_request&X-Goog-Date=20211112T165633Z&X-Goog-Expires=172801&X-Goog-SignedHeaders=host&X-Goog-Signature=03ab5da6514dbb2130b6d80bbc3f002528947d71d7d09fe70614a161a1ec47211f2fdb1b82ce6854b403acf24758e65c3325ef5bd7e050d9fbbeb6d62f615775cb9ae23071edc06a378a334a627fb4e617eb2cb5c286656bc4880153b36cbdd4227e577b6422a3ba33130df014d093c7a0297f57d172765895760da097ce16fe60f6d61d14771caa077645a04814c8525ad021f32b0683f1544294f36093cb76a7bc314449ac90056ac5766b8fc1439d57726738cafd66e663172eff2041e116ef5efa0b0ffeaf03385939baffce7f74ee67492fa4766203f69eb746a16009aae7a6156d82bfa924086727b434bbb86061d3c28399d979ee03938444cb3da83e","logoFileType":"svg","colorHexCode":"FF2A0B","pictureUrl":"https://storage.googleapis.com/vario-dev-assets/images/VZ.jpg?X-Goog-Algorithm=GOOG4-RSA-SHA256&X-Goog-Credential=firebase-adminsdk-cfp7v%40vario-dev.iam.gserviceaccount.com%2F20211112%2Fauto%2Fstorage%2Fgoog4_request&X-Goog-Date=20211112T165633Z&X-Goog-Expires=172801&X-Goog-SignedHeaders=host&X-Goog-Signature=1680f73c636c660da275d8a8d0eb2271b89d88107329e70732e05752e50cc4fc7e1c8c05ebeb9353e14938f1cb3ef66f906fb9ef856732b01dc4994690c7928a9b94f5ffff49b2925bd606dd1de586fb3e40aa1688a23d7caf366c2b2ba5e2f63f511f5585f2a854c336623ca518bb071153aebbb52f60db0151e0ddf2156a60ce3f2330a6883000a451805984b7f5939581a4743e0d2f95e7f489ee89aa75488d3f6a5215088fedc10a7ee914c0151524fdc90c2c998b61a25175df6cee8fdc718ba1908f0a98367eadbdd592fcc1bccb38a594e3a590c5782b786260d808787cae5954371a8c957a57d1f059d399ff58d4dd9f69fc8e87aca54c05d746cb50","description":"Verizon ist ein weltweit führender Mobilfunk- Internet-, und Festnetzanbieter. Es vertreibt aber auch zum Geschäft passende Geräte wie z.B Apple und Samsung Produkte.","country":"US","countryEmoji":"flag-us","region":{"id":"northAmerica","name":"Nordamerika"},"sector":{"id":"communication","name":"Kommunikation","emoji":"iphone","color":"#F1C453"},"riskClass":"standard","topics":[{"id":"Digitalisierung","name":"Digitalisierung","emoji":"desktop_computer","color":"#295FCC"},{"id":"Internet der Dinge","name":"Internet der Dinge","emoji":"desktop_computer","color":"#295FCC"},{"id":"Business","name":"Business","emoji":"briefcase","color":"#CC7A29"}],"varioScore":7,"ratingScore":0.0,"arguments":["Etablierter Anbieter in den USA","Internetfähige Geräte nehmen noch zu","Profiteur der Digitalisierung"],"currency":"EUR","pricePerStock":46.002741,"value":197130616300.2,"returnPerYear":0.04826899675161535,"returnYearsCount":0,"currentSalesGrowth":-0.027118027118027133,"ticker":"VZ","performance":5.638447303581102}'))),
      Stock.fromBackend(
          'QS',
          SwipeScreenDataModel.fromJson(json.decode(
              '{"name":"Quantumscape","logoUrl":"https://storage.googleapis.com/vario-dev-assets/logos/QS.svg?X-Goog-Algorithm=GOOG4-RSA-SHA256&X-Goog-Credential=firebase-adminsdk-cfp7v%40vario-dev.iam.gserviceaccount.com%2F20211112%2Fauto%2Fstorage%2Fgoog4_request&X-Goog-Date=20211112T165628Z&X-Goog-Expires=172800&X-Goog-SignedHeaders=host&X-Goog-Signature=23d93ed3f48a85a42acf321a99cda30afad6f9a3470a16b40d9fc39dbcd47e5e7f911713fc83fa8d8e2ed4f39fdf12499c19b57d5dd032f6f2ed3326af9a36b52b368f1d2d6e04215f3788a61e6cdecbcfca7b7fe0522862adc4244bfb64a03c123642f390116fada3364632e7ed8de947be442e9a2b5fb360755d1dc22e7ee8915535c6b6d0f7bcde038cdb7c5ce9bc655bdf9d68feb783b4f5b83a00d0dcf7b24cf60017a2de35a116bf6facd3a2da14758fe6ecb1641aae6532512cc972dc051a73087059a11c7545f641fb60a3b2666223ef509b225fee4e1883cba0ce12247429ecfd4a4fa281acb1d172cab61c4edd968f245412471ec73244f3823a64","logoFileType":"svg","colorHexCode":"0B5848","pictureUrl":"https://storage.googleapis.com/vario-dev-assets/images/QS.jpg?X-Goog-Algorithm=GOOG4-RSA-SHA256&X-Goog-Credential=firebase-adminsdk-cfp7v%40vario-dev.iam.gserviceaccount.com%2F20211112%2Fauto%2Fstorage%2Fgoog4_request&X-Goog-Date=20211112T165628Z&X-Goog-Expires=172800&X-Goog-SignedHeaders=host&X-Goog-Signature=32d7b67b5f4c0f789954f3017b14f43ab9f23855a5d0d6df53725ddd606465914a33d8c653db012de3654a55dc1ad1b55b35ec24a7c4638227885f1ccf3b56f2304b02166969adbaa283cce569a1df33ba615fcedadfc9efa9685e772e979f6a10136263a7e789c468afe26df1edf04ec9e2f72239f72501272bd027028cba73946038598cfb954867128efa3eab0dc7bc00cdf439061c2259bd56aaeda21aadd2ac649bd5a12704ca299329908697ae6d7375036e46ffceceddfe2bfa8da1f9cc7f1a4f3c4aae73476c06cad73dfe4b3a51228c783d1f3f0ca3b6ccb10a94effee36562eb4b0d08799104baf7da32171adeaf52c6150747da670673622e0242","description":"QuantumScape Corp beschäftigt sich mit der Entwicklung von Lithium-Feststoffbatterien der nächsten Generation für den Einsatz in Elektrofahrzeugen.","country":"US","countryEmoji":"flag-us","region":{"id":"northAmerica","name":"Nordamerika"},"sector":{"id":"durables","name":"Gebrauchsgüter","emoji":"shopping_bags","color":"#0DB39E"},"riskClass":"speculative","topics":[{"id":"Erneuerbare Energien","name":"Erneuerbare Energien","emoji":"seedling","color":"#5FCC29"},{"id":"Elektromobilität","name":"Elektromobilität","emoji":"seedling","color":"#5FCC29"},{"id":"Nachhaltigkeit","name":"Nachhaltigkeit","emoji":"seedling","color":"#5FCC29"}],"varioScore":8,"ratingScore":0.0016177917525753206,"arguments":["Vielleicht die Superbatterie der Zukunft","Könnte E-Autos revolutionieren","Volkswagen hat investiert"],"currency":"EUR","pricePerStock":21.572634,"value":8486408478.240001,"returnPerYear":0.19797225186766276,"returnYearsCount":0,"currentSalesGrowth":null,"ticker":"QS","performance":2.8717171717171714}'))),
      Stock.fromBackend(
          'RMS',
          SwipeScreenDataModel.fromJson(json.decode(
              '{"name":"Hermes","logoUrl":"https://storage.googleapis.com/vario-dev-assets/logos/RMS.PA.svg?X-Goog-Algorithm=GOOG4-RSA-SHA256&X-Goog-Credential=firebase-adminsdk-cfp7v%40vario-dev.iam.gserviceaccount.com%2F20211112%2Fauto%2Fstorage%2Fgoog4_request&X-Goog-Date=20211112T165628Z&X-Goog-Expires=172801&X-Goog-SignedHeaders=host&X-Goog-Signature=202e7dac54a022df2ce6d55972add05e31ed4bd28949c23497846b458c22ffe826600955e2716146701a0ccd3917eed391fc56eee708fe75db0df8d9170a46a73664b2439e366c8aec678480dab1ad91cf203dbfd57c6ff030343af4c6c6e85f48d31acb0f35fc8b2a34308f9dff8202945d071815c0e1e7f74c762bd36858249879eb751b97c06435a936a443c1ad02c3df443b9e36856cd33fc21c1de42f26512da8094ae6e3ae724d5766c40cfc41c0fdc32d27ec80591d4ba6051c20aa73d23d33084069f35a9060735b3eb590d6bfbd8bb4384baf15cf371293e638aec646d8ae4766c4aa2570172ecd918f01c331b83c97606b03b87e97ca2452d39378","logoFileType":"svg","colorHexCode":"D76F2C","pictureUrl":"https://storage.googleapis.com/vario-dev-assets/images/RMS.PA.jpg?X-Goog-Algorithm=GOOG4-RSA-SHA256&X-Goog-Credential=firebase-adminsdk-cfp7v%40vario-dev.iam.gserviceaccount.com%2F20211112%2Fauto%2Fstorage%2Fgoog4_request&X-Goog-Date=20211112T165628Z&X-Goog-Expires=172801&X-Goog-SignedHeaders=host&X-Goog-Signature=47580ae833b38becb4d5c0890820f4471ec003f8e2d7b04b857b19daa8511d4f3ddefd5b54f62d58405742ef58d7bba80f96ad3a8973117927688de84d3e96aff27404ccd0dba1d353d41a982832054d99e1fa47e0a77c3e148cdadccec74262e64ff6d0f808586cc964c7586945c245b02723ed3d57dd2d6fb39b62d7aa1632a7a588463d344d303d99e49730356346fb63c024287206b09e5e8b3313502a86f3ed06780c359700641e763fa33c921463fb17d98d074e545c3da71543b3e7b9b05be08a6f69a54d13f283cf726e2aae3948de8db933cad2b98910be77cae2c3bbd501aae5919427b48c8b9b6a8889fde6bde47294d06249d96b0ecb7007806a","description":"Hermès ist ein weltweit führendes Luxusunternehmen, das sich im Familienbesitz der 6. Generation befindet.","country":"FR","countryEmoji":"flag-fr","region":{"id":"europe","name":"Europa"},"sector":{"id":"durables","name":"Gebrauchsgüter","emoji":"shopping_bags","color":"#0DB39E"},"riskClass":"defensive","topics":[{"id":"Luxus","name":"Luxus","emoji":"gem","color":"#B9AD56"},{"id":"Mode & Beauty","name":"Mode & Beauty","emoji":"handbag","color":"#D675B1"},{"id":"Krisensicher","name":"Krisensicher","emoji":"lock","color":"#4429CC"},{"id":"Zeitlos","name":"Zeitlos","emoji":"mantelpiece_clock","color":"#6B8299"}],"varioScore":6,"ratingScore":0.0,"arguments":["Führender Luxuskonzern","Starkes Wachstum in Asien","Luxus gilt als krisensicher"],"currency":"EUR","pricePerStock":1478.5,"value":0.0,"returnPerYear":0.20087298286176053,"returnYearsCount":10,"currentSalesGrowth":-0.07176685940087746,"ticker":"RMS","performance":29.15500713848664}'))),
      Stock.fromBackend(
          'COUR',
          SwipeScreenDataModel.fromJson(json.decode(
              '{"name":"Coursera","logoUrl":"https://storage.googleapis.com/vario-dev-assets/logos/COUR.svg?X-Goog-Algorithm=GOOG4-RSA-SHA256&X-Goog-Credential=firebase-adminsdk-cfp7v%40vario-dev.iam.gserviceaccount.com%2F20211112%2Fauto%2Fstorage%2Fgoog4_request&X-Goog-Date=20211112T165615Z&X-Goog-Expires=172800&X-Goog-SignedHeaders=host&X-Goog-Signature=4a49ff1d864696a0c46d354c79e386867a4125f237e04159a86a142825762008436b398f9a5c2c8de948a415f48c1d15ab1e48ee416a8ec9a6e1e1630a699a4b818441937e59698da3d545e2141abb35c5a0398e4d74a7934c408f2364dcac236d46f996dcc3c92c8dd0252bf3972deb10cca7baed880a52152a2fae91fdae730e2fd0ba61c554010c2b617a6e679fcda58124c6a593a88b62d7d275cc14966387d570cb7b318b8f6cdc8a603ee196c75e995dadedfb1892dfc9489eb7dd6889ca4927872cd5bbf3af437061ea55689f28242a05c8ea3699a98377d2402d6fd277c9b6c23aa752292d507d3a998d662787ef5f42ff24ebe4b79501041a674ecf","logoFileType":"svg","colorHexCode":"717172","pictureUrl":"https://storage.googleapis.com/vario-dev-assets/images/COUR.jpg?X-Goog-Algorithm=GOOG4-RSA-SHA256&X-Goog-Credential=firebase-adminsdk-cfp7v%40vario-dev.iam.gserviceaccount.com%2F20211112%2Fauto%2Fstorage%2Fgoog4_request&X-Goog-Date=20211112T165615Z&X-Goog-Expires=172800&X-Goog-SignedHeaders=host&X-Goog-Signature=04682cbac5a690a182ce2bc50d3c9ad97bfbe518cdd0ce0df498a5c8bb7d2f032e93a4b3b9e7bd7dd181b70205566aa478590b3dfa554fa4d88c67e4b05583ff4eb7a8215335a40c96f2580351e5ec4e8eb52b52dfe691c835f6f18b81e730e56e1c49fd005d4a5de0a9fe50d47a46c6e1f7e0589847572e93f09a30295f9f01eedad9364ec7062248bb9a44ad299301207474e8eab4901c1db911603623d91efe428ab5fd63b9ab848b41b0bf72bc388320057b00d63b885f6abc1465d064746e77d80ce2fb8aa08b7043f303934c35d08f526513da1c141daf8933957c1eff3a0bfa640b2af5fdc2d5d03f6c8c7f22c54abf429806a28de7293bb74b43bec2","description":"Coursera ist die führende Lernplatform für Online-Weiterbildungskurse. User können hier Kurse absolvieren, sowie Zertifikate und echte Universitäts-Abschlüsse erhalten.","country":"US","countryEmoji":"flag-us","region":{"id":"northAmerica","name":"Nordamerika"},"sector":{"id":"consumables","name":"Konsumgüter","emoji":"beverage_box","color":"#16DB93"},"riskClass":"speculative","topics":[{"id":"Digitalisierung","name":"Digitalisierung","emoji":"desktop_computer","color":"#295FCC"}],"varioScore":7,"ratingScore":0.05741836098856654,"arguments":["Führende Platform für Weiterbildungen","Partner wie Stanford oder das MIT","Reduziert die globale Ungleichheit"],"currency":"EUR","pricePerStock":28.449329999999996,"value":3781730166.329808,"returnPerYear":-0.29400000000000004,"returnYearsCount":0,"currentSalesGrowth":0.591613298555943,"ticker":"COUR","performance":-0.2226666666666668}'))),
    ];
  }

  bool isFetching = false;
  Future<void> fetchNextSwipes(int amount) async {
    //avoid multiple reloading
    if (isFetching) return;
    isFetching = true;

    try {
      // //get the [amount] most relevant investments.
      // final List<InvestmentItem> investmentSuggestions =
      //     await locator<ScoringService>().getSortedInvestmentSuggestions();
      // // remove all previous occurences
      // investmentSuggestions.removeWhere((element) =>
      //     locator<MatchingService>().hasItemBeenSwipedBefore(element));

      // final List<InvestmentItem> mostRelevantItems =
      //     investmentSuggestions.take(amount).toList();

      final List<InvestmentItem> mostRelevantWithData = await getDummyData();
      // await locator<InvestmentItemService>()
      //     .getFrontendDetails(mostRelevantItems);
      _upcomingSwipeItems.addAll(mostRelevantWithData);
    } finally {
      isFetching = false;
    }
  }

  /// deletes all upcoming swipes, but remains the current one.
  ///
  /// triggered after a filter has been updated.
  void clearSwipeQueue({bool clearAll = false}) {
    if (clearAll) {
      _upcomingSwipeItems.clear();
      return;
    }
    if (_upcomingSwipeItems.isNotEmpty)
      _upcomingSwipeItems.removeRange(1, _upcomingSwipeItems.length);
  }

  /// triggered after a swipe is completed.
  void dismissCurrentItem() {
    assert(_upcomingSwipeItems.isNotEmpty,
        "only call this function when swiping.");
    _upcomingSwipeItems.removeAt(0);
  }
}
