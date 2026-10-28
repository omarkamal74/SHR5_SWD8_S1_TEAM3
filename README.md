<div align="center">

# 📝 Flutter To-Do List Mini Project

> **تطبيق احترافي لإدارة المهام اليومية، تم تطويره كـ مشروع مصغر (Mini Project) لترسيخ معمارية التطبيقات، إدارة الحالة بـ Cubit، والتعامل الاحترافي مع قواعد البيانات المحلية.**

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)
![SQLite](https://img.shields.io/badge/sqlite-%2307405e.svg?style=for-the-badge&logo=sqlite&logoColor=white)

</div>

---

## 📖 نبذة عن المشروع (About The Project)

تطبيق **To-Do List** هو تطبيق هاتفي مصمم خصيصاً لمساعدة المستخدمين على تنظيم مهامهم اليومية بكفاءة وسرعة فائقة. تم بناء المشروع بمعمارية نظيفة تركز على فصل طبقة واجهة المستخدم عن منطق البرمجة وإدارة الحالة، مع ربط التطبيق بقاعدة بيانات محلية (`SQLite`) لضمان حفظ البيانات واستمراريتها حتى بعد إغلاق التطبيق.

---

## 👥 فريق العمل (Project Team)

عمر كمال
احمد اسامه 
محمد عطيه 
نور السيد
عهدالسعيد

---

## 🛠️ التقنيات والمكتبات المستخدمة (Tech Stack)

* **Framework:** [Flutter](https://flutter.dev/) (Dart Language)
* **State Management:** `flutter_bloc` (Cubit Architecture) - لإدارة الحالات وتحديث الشاشة بسلاسة.
* **Local Database:** `sqflite` - للتعامل مع قاعدة بيانات SQLite محلياً.
* **Architecture Pattern:** Clean separation of concerns (Views, Cubits, Models, Widgets, Database).

---

## ✨ المميزات والخصائص الرئيسية (Key Features)

* **➕ إضافة وإدارة المهام:** واجهة مخصصة لإدخال المهام الجديدة وعرضها بشكل منظم.
* **🔄 إدارة الحالة بـ Cubit:** فصل كامل لبيانات التطبيق ومنطق الحالات عن واجهة المستخدم لضمان كود نظيف وقابل للصيانة.
* **🗄️ التخزين المحلي عبر Database:** تخزين دائم وآمن للمهام باستخدام قاعدة بيانات محلية بحيث لا تضيع البيانات نهائياً.
* **🎨 مكونات مرنة (Widgets):** استخدام واجهات وعناصر مخصصة قابلة لإعادة الاستخدام داخل تطبيقك.

---

## 📂 هيكلة المشروع المعمارية (Project Architecture)

تم تنظيم المشروع داخل فولدر الـ `lib` بطريقة هندسية دقيقة لتسهيل قراءة الكود والتطوير:

```text
lib/
│
├── cubit/          # يحتوي على ملفات الـ Cubit و States الخاصة بإدارة الحالة
├── models/         # نماذج البيانات (Data Models) لتنظيم هيكل المهمة
├── views/          # الشاشات الرئيسية والصفحات الخاصة بالتطبيق
├── widgets/        # العناصر والمكونات الرسومية المتكررة (Reusable Widgets)
├── database/       # ملفات الاتصال وإدارة قاعدة بيانات SQLite محلياً
└── main.dart       # نقطة بداية تشغيل التطبيق (App Entry Point)
