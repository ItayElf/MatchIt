import 'package:hashids2/hashids2.dart';

const appPortNumber = 1664;

int ipToNumber(String ip) {
  int number = 0;
  ip.split(".").forEach((element) {
    number = number << 8 | int.parse(element);
  });
  return number;
}

String numberToIp(int number) {
  return List.generate(4, (index) => (number >> (3 - index) * 8) & 0xff)
      .join(".");
}

String ipToHashId(String ip) {
  return HashIds().encode(ipToNumber(ip));
}

String hashIdToIp(String hash) {
  return numberToIp(HashIds().decode(hash).first);
}
