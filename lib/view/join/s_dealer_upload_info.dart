import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DealerUploadScreen extends ConsumerStatefulWidget {
  const DealerUploadScreen({super.key});


  @override
  ConsumerState<DealerUploadScreen> createState() => _DealerUploadScreenState();
}

class _DealerUploadScreenState extends ConsumerState<DealerUploadScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DealerUpload'),
      ),
      body: Center(
        child: Text('DealerUpload'),
      ),
    );
  }
}
