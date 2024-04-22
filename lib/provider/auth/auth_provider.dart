


import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/m_auth.dart';

final authProvider = StateProvider<AuthModel>((ref)=> AuthModel(uid: 'admin1234'));

