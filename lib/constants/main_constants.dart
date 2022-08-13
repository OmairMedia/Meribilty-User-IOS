import 'package:geolocator/geolocator.dart';
import 'package:get_storage/get_storage.dart';
import 'package:localstorage/localstorage.dart';

final box = GetStorage('box');
final LocalStorage storage = new LocalStorage('box');
final LocalStorage chatstorage = new LocalStorage('chatbox');
Position? userPosition;
var name;
