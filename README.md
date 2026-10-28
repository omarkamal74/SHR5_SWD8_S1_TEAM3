<div align="center">

# 📝 Flutter To-Do List Mini Project

> **تطبيق احترافي متكامل لإدارة المهام اليومية، تم تطويره كـ مشروع مصغر (Mini Project) لترسيخ المعمارية النظيفة، إدارة الحالة باحترافية، والتعامل الآمن مع قواعد البيانات المحلية.**

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)
![SQLite](https://img.shields.io/badge/sqlite-%2307405e.svg?style=for-the-badge&logo=sqlite&logoColor=white)

</div>

---

## 📖 نظرة عامة على المشروع (About The Project)

تطبيق **To-Do List** هو تطبيق هاتفي ذكي تم تصميمه خصيصاً لمساعدة المستخدمين على إدارة وتنظيم مهامهم اليومية بكفاءة وثبات عاليين. تم بناء هذا المشروع وفقاً لأفضل الممارسات البرمجية في تطوير تطبيقات الفلاتر (Flutter Best Practices)، حيث يركز على فصل طبقات التطبيق تماماً (Separation of Concerns)، مما يضمن كوداً نظيفاً، قابلاً للتوسع، وسهل الصيانة والتطوير مستقبلاً.

---

## 👥 فريق العمل والمساهمون (Project Team)

نخبة من المطورين الذين عملوا بتعاون وتناغم لإخراج هذا المشروع بأفضل صورة برمجية وتصميمية:

* 👑 **عمر كمال عبد الحميد** *(Team Leader & Lead Developer)*
* 💻 **أحمد أسامة** *(Flutter Developer)*
* 💻 **محمد عطية** *(Flutter Developer)*
* 💻 **نور السيد** *(Flutter Developer)*
* 💻 **عهد السعيد** *(Flutter Developer)*

---

## 🛠️ التقنيات والمكتبات المستخدمة (Tech Stack & Architecture)

تم استخدام منظومة تقنية متكاملة ومستقرة تلبي احتياجات الأداء العالي:

* **Framework:** [Flutter](https://flutter.dev/) (مدعوم بلغة Dart القياسية).
* **State Management:** `flutter_bloc` (Cubit Architecture) لإدارة الحالة بكفاءة تامة وفصل منطق الأعمال عن واجهة المستخدم (UI Logic Separation).
* **Local Database:** `sqflite` لتوفير قاعدة بيانات محلية (SQLite) قوية وآمنة تضمن حفظ واسترجاع البيانات بسلاسة.
* **Architecture Pattern:** Clean & Modular Architecture (فصل الملفات إلى Cubit, Models, Views, Widgets, Database).

---

## ✨ المميزات والخصائص التقنية (Key Features)

* **🔄 إدارة الحالة الذكية (Cubit):** متابعة التحديثات اللحظية على الشاشة وتغيير حالة المهام فوراً دون حدوث أي استهلاك زائد للموارد أو إعادة بناء غير مبررة للـ Widgets.
* **🗄️ التخزين المحلي الآمن (Local Persistence):** تكامل تام مع قواعد بيانات SQLite المحلية لضمان بقاء المهام محفوظة ودائمة الصلاحية حتى عند إغلاق التطبيق تماماً أو إعادة تشغيل الجهاز.
* **➕ إضافة وتعديل وحذف سلس:** واجهات مرنة تتيح للمستخدم إضافة مهمة جديدة، تعديل حالتها (مكتملة / قيد التنفيذ)، أو حذفها بضغطة زر واحدة.
* **🎨 تجربة مستخدم مرنة (UX/UI):** واجهات عصرية ونظيفة ومصممة بعناية لتوفير راحة بصرية وسهولة في التعامل لجميع المستخدمين.

---

## 📂 هيكلة فولدرات المشروع (Project Directory Structure)

تم تنظيم المشروع هندسياً لتسهيل تتبع الملفات والصيانة البرمجية:

```text
lib/
│
├── cubit/          # يحتوي على ملفات الـ Cubit والـ States الخاصة بإدارة الحالة
├── models/         # نماذج البيانات (Data Models) لهيكلة كائنات المهام وتعاملات قاعدة البيانات
├── views/          # الشاشات الرئيسية والصفحات المرئية للتطبيق
├── widgets/        # المكونات الرسومية المتكررة والقابلة لإعادة الاستخدام (Reusable Widgets)
├── database/       # خدمات الاتصال، التهيئة، وإدارة عمليات قاعدة بيانات SQLite
└── main.dart       # نقطة بداية تشغيل التطبيق وربط مزودات الحالة (App Entry Point)
