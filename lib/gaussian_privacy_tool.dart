import 'dart:math';

// std => noise ampedance (انحراف معیار - شدت نویز)
// mean => average ((مرکز توزیع) میانگین)

double gaussianGenerator(Random rng, {double mean = 0.0, required double std}) {
  // random generated number between 0 and 1 (not 1)
  final u1 = max(rng.nextDouble(), 1e-12);
  final u2 = rng.nextDouble();
  // Box Muller Transform for generating guassian number
  final z0 = sqrt(-2.0 * log(u1)) * cos(2.0 * pi * u2);
  return (mean + (z0 * std));
}
