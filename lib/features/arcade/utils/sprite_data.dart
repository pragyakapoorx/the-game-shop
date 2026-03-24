import 'package:flutter/material.dart';

class SpriteData {
  static const Map<String, Color> palette = {
    'W': Color(0xFFf0e8d0), 'S': Color(0xFFc8b896), 'D': Color(0xFFa07848),
    'R': Color(0xFFc83030), 'r': Color(0xFFe05050), 'B': Color(0xFF3850b8),
    'b': Color(0xFF5070d8), 'G': Color(0xFF386830), 'g': Color(0xFF58a848),
    'T': Color(0xFFc87a2a), 't': Color(0xFFf5b930), 'K': Color(0xFF181410),
    'k': Color(0xFF302820), 'M': Color(0xFF804888), 'm': Color(0xFFc070c8),
    'N': Color(0xFF504030), 'n': Color(0xFF786858), 'E': Color(0xFF50c848),
    'e': Color(0xFF78e868), 'Y': Color(0xFFd0c820), 'y': Color(0xFFf0e840),
    'O': Color(0xFFc85818), 'C': Color(0xFF50b8c8), 'P': Color(0xFFd870a8),
    'X': Color(0xFF202020),
  };

  static const List<String> hero = [
    '_____BBBBB______','____BBBBBBB_____','____BWWWWWb_____','___BBWSSSWB_____',
    '___BWSSDSSBB____','___BWSSKSSb_____','____WSSSSW______','___BBBBBBBBB____',
    '__BBBBBBBBBBB___','__BbBBBBBBBbB___','__BBBBtBBBBBB___','___BBBBBBBBB____',
    '___BBB___BBB____','___BBB___BBB____','__KBBB___BBBK___','__KWWW___WWWK___',
    '__KKKK___KKKK___'
  ];

  static const List<String> troll = [
    '____GGGGGGGGG___','___GGGGGGGGGGG__','__GGGgggggggGGG_','_GGGgGGGGGGgGGG_',
    '_GGgGGKKGKKGGgG_','_GGgGGGRGGGGGgG_','_GGgGGGGGGGGGgG_','_GGgGKKKKKKGGgG_',
    '__GGGgggggggGG__','__GGGGGGGGGGG___','_GGGGGGGGGGGGG__','GGGGnnnnnnnnGGG_',
    'GGGGnnnnnnnnGGG_','_GGGGnnnnnnGGG__','__GGGGGGGGGGGG__','___GGGG__GGGG___',
    '___GGGG__GGGG___','__KGGG____GGGK__','__KKKKK__KKKKK__'
  ];

  static const List<String> witch = [
    '____MMMMM_______','___MMMMMMM______','__MMMMMMMMm_____','__MmMWWWWMM_____',
    '__MMWSSrSWM_____','__MMWSSKSWm_____','___mWSSSSW______','__MMMMMMMMMM____',
    '_MMMMMMMMMMm____','_MmMMmMmMmMM____','_MMMMMtMMMMM____','__MMMMMMMMMM____',
    '___MMM___MMM____','___MMM___MMM____','__KMMM___MMMK___','__KWWW___WWWK___',
    '__KKKK___KKKK___'
  ];

  static const List<String> golem = [
    '__NNNNNNNNNNN___','_NNNnnnnnnnNNN__','_NNnNNNNNNNnNN__','_NNnNKKKKKNnNN__',
    '_NNnNKYYKKNnNN__','_NNnNKKKKKNnNN__','_NNnNNNNNNNnNN__','_NNNnnnnnnnNNN__',
    '_NNNNNNNNNNNNN__','NNNNNNNNNNNNNNN_','NNNnnnnnnnnnNNN_','NNNnNNNNNNNnNNN_',
    'NNNnNNNNNNNnNNN_','NNNnnnnnnnnnNNN_','NNNNNNNNNNNNNNN_','__NNN_____NNN___',
    '__NNN_____NNN___','__NNN_____NNN___','_KNNN_____NNNK__','_KKKK_____KKKK__'
  ];

  static const List<String> knight = [
    '___KKnKKKKn_____','__KKKnnnnnKK____','__KKKnWWWnKK____','__KKnWYYYWnKK___',
    '__KKnWRKRWnKK___','__KKnWWWWWnKK___','___KKKnnnKKK____','__KKKKnnnKKKK___',
    '_KKKKKnnnKKKKK__','_KKKKKnnnKKKKK__','_KKnKKKnKKKnKK__','_KKKKKKnKKKKKK__',
    '__KKKKK_KKKKK___','__KKNNN_NNNKK___','__KKNNN_NNNKK___','__KKNNN_NNNKK___',
    '__KKNNN_NNNKK___','__KKNNN_NNNKK___','__KKKKK_KKKKK___'
  ];

  static const List<String> dragon = [
    '_______RRRR_____','______RRrRRR____','______RrRrRR____','_____RRRRRRRr___',
    '____RRRKKRKRrr__','____RRRRYRRRrr__','___RRRRRRRRRr___','__RRRRRRRRRRr___',
    '_RRRRRRRRRRRR___','RRRRRRrrrrRRRR__','RRRRRRrrrrRRRRr_','_RRRRRRrrRRRRR__',
    '__RRRRRRRRRRRR__','___RRRRrRRRRR___','____RRRrRRRR____','_____RRrRRR_____',
    '____rRRrRRRr____','___rrRRrRRrr____','____rrrrrrrr____'
  ];

  static const List<String> mazeHero = [
    '__BBB___','_BWWWB__','_BWSWB__','_BWWWB__','__BBB___','_BBBBB__','_BtBBB__',
    '__BBB___','__B_B___','_KB_BK__','_KW_WK__'
  ];

  // --- NEW MAZE SPRITES ---
  static const List<String> skel = [
    '___WWWWW____','__WWKWKWW___','__WWWWWWW___','__WWWRWWW___','___WWWWW____',
    '___WWWWW____','__WWWWWWW___','_WWWWWWWWW__','___WW_WW____','___WW_WW____',
    '___WW_WW____','__KWW_WWK___','__KKKK_KKK__'
  ];

  static const List<String> gem = [
    '__eEe___','_eEEEe__','eEEEEEe_','eEEEEEe_','_eEEEe__','__eEe___'
  ];

  static const List<String> keyItem = [
    '__tTTt______','_tTtTTt_____','_tTKTTt_____','_tTtTTt_____','__tTTt__tt__',
    '________tt__','________tt__'
  ];

  static const List<String> door = [
    'NNNNNNNNNNNN','NTttttttttTN','NtNNNNNNNNtN','NtNKKKKKNNtN','NtNKSSSSKNtN',
    'NtNKSSSSKNtN','NtNKSSSSKNtN','NtNKKKKKNNtN','NtNNNNNNNNtN','NtNNNKNNNNtN',
    'NtNNNKNNNNtN','NtNNNNNNNNtN','NTttttttttTN','NNNNNNNNNNNN'
  ];
}