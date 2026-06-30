# 🏗️ Architecture
<img width="80%" alt="image_2026-06-30_01-09-17" src="https://github.com/user-attachments/assets/810f379c-0654-4e65-8aa3-a779765abd30" />


# Built with
- [GoRouter](https://pub.dev/packages/go_router)
- [Riverpod](https://pub.dev/packages/flutter_riverpod)
- [Relational DB -> Drift](https://pub.dev/packages/drift)
- [NoSql DB -> Shared Preferences](https://pub.dev/packages/shared_preferences)
- [Flutter Localization](https://pub.dev/packages/flutter_localization)
- [Freezed](https://pub.dev/packages/freezed)
- [Flutter OSM Plugin](https://pub.dev/packages/flutter_osm_plugin)
- [Image Picker](https://pub.dev/packages/image_picker)
- [Image Cropper](https://pub.dev/packages/image_cropper)

# Media

<img width="23%" alt="Screenshot_2026-06-30-23-19-55-796_com" src="https://github.com/user-attachments/assets/94a5863a-9d70-4fc8-9124-996321d54244" />
<img width="23%" alt="Screenshot_2026-06-30-23-20-05-948_com" src="https://github.com/user-attachments/assets/b4148426-fcf3-41da-b7b2-a1ae45c40ab1" />
<img width="23%" alt="Screenshot_2026-06-30-23-20-12-893_com" src="https://github.com/user-attachments/assets/aa204478-a317-4f71-83ab-8d01df1de9b2" />
<img width="23%" alt="Screenshot_2026-06-30-23-20-15-269_com" src="https://github.com/user-attachments/assets/fc95423a-738f-4e4f-838e-e09674f686ba" />


<img width="23%" alt="Screenshot_2026-06-30-23-25-34-257_com" src="https://github.com/user-attachments/assets/8338b57c-a777-4f79-8c6f-3e6359263993" />
<img width="23%" alt="Screenshot_2026-06-30-23-26-31-721_com" src="https://github.com/user-attachments/assets/bda6201d-941c-40c8-a584-1ffc2bef83ed" />
<img width="23%" alt="Screenshot_2026-06-30-23-31-26-206_com" src="https://github.com/user-attachments/assets/8ab05b75-ae36-4eca-8d09-15c695408be1" />
<img width="23%" alt="Screenshot_2026-06-30-23-31-32-574_com" src="https://github.com/user-attachments/assets/f9548838-8de0-416d-b4e6-6e01a8b211c5" />


https://github.com/user-attachments/assets/504cf52b-6a64-457f-ad61-76714a4e49e5

# Persistence

This app use two local persistence strategies:

- `drift` for structured memo storage with a relational table, primary keys, dates, media and optional coordinates.
- `shared_preferences` for lightweight theme preference storage.

This shows the ability to choose storage tools based on the data.

# State Management

This app use `flutter_riverpod`, `riverpod_annotation` for dependency injection and reactive state provider. Some providers are:

- `MemoListNotifier` for loading and refreshing the memo home page.
- `AddMemoNotifier` for form state, validation, saving and list synchronization.
- `AppThemeNotifier` for light/dark theme switching.

