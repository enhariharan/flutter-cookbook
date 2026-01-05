import 'dart:math';

class NumberStream {
  Stream<int> getNumbers() async* {
    yield* Stream.periodic(
      const Duration(seconds: 1),
      (int t) {
        Random random = Random();
        int num = random.nextInt(100);
        return num;
      },
    );
  }
}