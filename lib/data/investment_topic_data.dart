part of '../domain/models/investment_item/investment_topic.dart';

//https://docs.google.com/spreadsheets/d/1DmQNzmIwArVnNslmH9XhTbUlBAz05V36wg_vp4UzeJY/edit#gid=2060099317

final Map<Interest, List<InvestmentTopic>> interestsTopicConnection = {
  kTechnologieInterest: [
    kDigitalisierungTopic,
    kAutomatisierungTopic,
    kCloudTopic,
    kIOTTopic,
    kCyberSecurityTopic,
  ],
  kNachhaltigkeitInterest: [
    kNachhaltigkeitTopic,
    kErneuerbareEnergienTopic,
    kElectromobilityTopic,
    kRecyclingTopic,
    kWasserstoffTopic,
    kSharingEconomyTopic,
  ],
  kBusinessInterest: [kBusinessTopic],
  kMedizinInterest: [kGesundheitTopic],
  kKuenstlicheIntelligenzInterest: [kAITopic],
  kShoppingInterest: [kECommerceTopic],
  kBiotechnologieInterest: [kBiotechnologieTopic],
  kBlockchainInterest: [kBlockchainTopic],
  kUnterhaltungInterest: [kUnterhaltungTopic],
  kEssenUndTrinkenInterest: [kFoodDrinksTopic],
  kFinanzenInterest: [kFinanztechnologieTopic],
  kModeInterest: [kModeBeautyTopic],
  kGamingInterest: [kGamingTopic],
  kReisenInterest: [kReisenFreizeitTopic],
  kImmobilienInterest: [kImmobilienTopic],
  kSportInterest: [kSportTopic],
  kSocialMediaInterest: [kSocialMediaTopic],
  kLuxusInterest: [kLuxusTopic],
  kRaumfahrtInterest: [kRaumfahrtTopic],
  kVirtualRealityInterest: [kVirtualRealityTopic],
  k420Interest: [kCannabisTopic],
};

final kDigitalisierungTopic = InvestmentTopic(
    'Digitalisierung', "Digitalisierung", "#295FCC", "desktop_computer");
final kZeitlosTopic =
    InvestmentTopic('Zeitlos', "Zeitlos", "#6B8299", "mantelpiece_clock");
final kNachhaltigkeitTopic =
    InvestmentTopic('Nachhaltigkeit', "Nachhaltigkeit", "#5FCC29", "seedling");
final kBusinessTopic =
    InvestmentTopic('Business', "Business", "#CC7A29", "briefcase");
final kGesundheitTopic =
    InvestmentTopic('Gesundheit', "Gesundheit", "#CC2929", "pill");
final kAutomatisierungTopic = InvestmentTopic(
    'Automatisierung', "Automatisierung", "#295FCC", "desktop_computer");
final kCloudTopic =
    InvestmentTopic('Cloud', "Cloud", "#295FCC", "desktop_computer");
final kKrisensicherTopic =
    InvestmentTopic('Krisensicher', "Krisensicher", "#4429CC", "lock");
final kAITopic = InvestmentTopic(
    'KünstlicheIntelligenz', "Künstliche Intelligenz", "#CC2996", "robot_face");
final kErneuerbareEnergienTopic = InvestmentTopic(
    'renewable energies', "Erneuerbare Energien", "#5FCC29", "seedling");
final kECommerceTopic =
    InvestmentTopic('ECommerce', "E-Commerce", "#CCB129", "shopping_trolley");
final kBiotechnologieTopic =
    InvestmentTopic('Biotechnologie', "Biotechnologie", "#29CC96", "dna");
final kBlockchainTopic =
    InvestmentTopic('Blockchain', "Blockchain", "#B129CC", "₿");
final kUnterhaltungTopic =
    InvestmentTopic('Unterhaltung', "Unterhaltung", "#CC5F29", "tv");
final kElectromobilityTopic = InvestmentTopic(
    'Elektromobilität', "Elektromobilität", "#5FCC29", "seedling");
final kFoodDrinksTopic = InvestmentTopic(
    'NahrungGetränke', "Nahrung & Getränke", "#2996CC", "drooling_face");
final kFinanztechnologieTopic = InvestmentTopic(
    'Finanztechnologie', "Finanztechnologie", "#7B29CC", "credit_card");
final kIOTTopic =
    InvestmentTopic('IOT', "Internet der Dinge", "#295FCC", "desktop_computer");
final kModeBeautyTopic =
    InvestmentTopic('ModeBeauty', "Mode & Beauty", "#D675B1", "handbag");
final kGamingTopic =
    InvestmentTopic('Gaming', "Gaming", "#29CC5F", "video_game");
final kReisenFreizeitTopic = InvestmentTopic(
    'ReisenFreizeit', "Reisen & Freizeit", "#7A993D", "world_map");
final kImmobilienTopic =
    InvestmentTopic('Immobilien', "Immobilien", "#CC295F", "office");
final kSportTopic =
    InvestmentTopic('Sport', "Sport", "#CC4429", "woman-running");
final kRecyclingTopic =
    InvestmentTopic('Recycling', "Recycling", "#5FCC29", "seedling");
final kSocialMediaTopic =
    InvestmentTopic('social media', "Social Media", "#BFBF26", "iphone");
final kThemenuebergreifendTopic = InvestmentTopic('Themenübergreifend',
    "Themenübergreifend", "#999999", "globe_with_meridians");
final kLuxusTopic = InvestmentTopic('Luxus', "Luxus", "#B9AD56", "gem");
final kWasserstoffTopic =
    InvestmentTopic('Wasserstoff', "Wasserstoff", "#5FCC29", "seedling");
final kCyberSecurityTopic = InvestmentTopic(
    'CyberSecurity', "Cyber Security", "#295FCC", "desktop_computer");
final kSharingEconomyTopic =
    InvestmentTopic('SharingEconomy', "Sharing Economy", "#5FCC29", "seedling");
final kRaumfahrtTopic =
    InvestmentTopic('Raumfahrt', "Raumfahrt", "#CC29B1", "rocket");
final kVirtualRealityTopic =
    InvestmentTopic('VirtualReality', "Virtual Reality", "#5C996F", "goggles");
final kCannabisTopic =
    InvestmentTopic('Cannabis', "Cannabis", "#29C45F", "herb");
