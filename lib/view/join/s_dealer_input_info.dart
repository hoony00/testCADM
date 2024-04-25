import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DealerInputScreen extends ConsumerStatefulWidget {
  const DealerInputScreen({super.key});


  @override
  ConsumerState<DealerInputScreen> createState() => _DealerUploadState();
}

class _DealerUploadState extends ConsumerState<DealerInputScreen> {
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
