import 'dart:math';

// calculating the mean
double mean(List<double> xs) => xs.reduce((a, b) => a + b) / xs.length;

// calculating the sdt of a sample
double stdSample(List<double> xs) {
  if (xs.length < 2) {
    return 0.0;
  }
  final m = mean(xs);
  final v =
      xs.map((x) => ((x - m) * (x + m))).reduce((a, b) => a + b) /
      (xs.length - 1);
  return sqrt(v);
}
