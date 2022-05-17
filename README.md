## Description
Oversecured Vulnerable iOS App is an iOS app that aggregates all the platform's known and popular security vulnerabilities.

## List of vulnerabilities
This section only includes the list of vulnerabilities, without a detailed description or proof of concept. Examples from this intentionally vulnerable app will receive detailed examination and analysis on [our blog](https://blog.oversecured.com/).

1. Enabled iTunes file sharing allowing to browse and access files from `Documents` directory in file `Info.plist`.
2. Session theft via `ovia://deeplink/webview?url=...` deeplink.
3. Overwriting of arbitrary files via `ovia://deeplink/save?data=...&name=...` deeplink.
4. Memory corruption via `ovia://deeplink/save?data=...&name=...&offset=...` deeplink.
5. HTML injection via `ovia://deeplink/alert?message=...` deeplink.
6. Hardcoded AES encryption key and IV in file `Crypto.swift`.
7. Enabled (not disabled) caching in `NetworkCalls.swift` that saved credentials onto the device.
8. Insecure ATS configuration allowing insecure connections in file `Info.plist`.
9. Dumping the cache file to a public storage in file `MainViewController.swift`.

---------------------------------------
*Licensed under the Simplified BSD License*

*Copyright (c) 2022, Oversecured Inc*

https://oversecured.com/
