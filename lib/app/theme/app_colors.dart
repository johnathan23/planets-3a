import 'package:flutter/material.dart';

const Color kWhite = Color(0xFFFFFFFF);
const Color kBlack = Color(0xFF020632);
const Color kGrey = Color(0xFF6C6C6C);
const Color kBlue = Color(0xFF0D6FCA);
const Color kBlue02 = Color(0xFF0D6CC8);
const Color kBlue03 = Color(0xFF0E6CC7);
const Color kPurple = Color(0xFF4B0384);
const Color kViolet = Color(0xFF26006F);

const List<Color> _kBackground = [kBlue, kViolet, kPurple];

const List<Color> _kBackground02 = [kBlue03, kPurple];

const LinearGradient kBackgroundGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: _kBackground,
);

const LinearGradient kBackgroundGradient02 = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: _kBackground02,
);
