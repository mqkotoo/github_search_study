import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';

class NetworkErrorView extends StatelessWidget {
  const NetworkErrorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 30),
        _errorComponent(
          context: context,
          errorIcon: Icons.wifi_off,
          errorTitle: S.of(context).networkError,
          errorDetail: S.of(context).networkErrorDetail,
        ),
      ],
    );
  }

  //表示するエラーのかたまり
  Widget _errorComponent(
      {required BuildContext context,
        required IconData errorIcon,
        required String errorTitle,
        String? errorDetail}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(errorIcon, size: 80),
        const SizedBox(height: 15),
        Text(
          errorTitle,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        if (errorDetail != null) Text(errorDetail),
      ],
    );
  }

}

class ErrorView extends StatelessWidget {
  const ErrorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const SizedBox(height: 30),
        _errorComponent(
          context: context,
          errorIcon: Icons.error_outline,
          errorTitle: S.of(context).errorOccurred,
          errorDetail: S.of(context).errorOccurredDetail,
        ),
      ],
    );
  }

  //表示するエラーのかたまり
  Widget _errorComponent(
      {required BuildContext context,
        required IconData errorIcon,
        required String errorTitle,
        String? errorDetail}) {
    return Column(
      children: <Widget>[
        Icon(errorIcon, size: 80),
        const SizedBox(height: 15),
        Text(
          errorTitle,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        if (errorDetail != null) Text(errorDetail),
      ],
    );
  }

}
