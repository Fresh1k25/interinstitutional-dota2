# Interinstitutional Dota 2 — GitHub Pages + Supabase

## Файли
- `index.html` — публічний сайт.
- `admin.html` — адмін-панель з входом.
- `supabase-config.js` — сюди вставляються URL та publishable key Supabase.
- `supabase.sql` — таблиці та RLS-політики.

## 1. Створи Supabase project
1. Створи проєкт у Supabase.
2. Відкрий SQL Editor та встав весь `supabase.sql`, виконай.
3. В Authentication → Users створи ОДНОГО користувача для себе (email + пароль).
4. Скопіюй його User UID.
5. У SQL Editor виконай:
   `insert into public.admins (id) values ('ТВІЙ-USER-UUID');`
6. За бажанням вимкни публічну реєстрацію нових користувачів у Authentication settings.
7. В Project Settings → API скопіюй Project URL та Publishable key. Встав їх у `supabase-config.js`.

## 2. GitHub
1. Створи репозиторій.
2. Завантаж `index.html`, `admin.html`, `supabase-config.js`, `supabase.sql`.
3. Settings → Pages → Deploy from branch → `main` → `/root`.
4. Відкрий URL GitHub Pages.

## 3. Як працює доступ
- `index.html` доступний усім.
- `admin.html` показує форму входу.
- Навіть якщо хтось відкриє код, змінювати teams/matches через базу зможе лише користувач, якого ти додав у `public.admins`.
- Пароль у HTML не зберігається.
- Рахунки зберігаються у Supabase, тому всі відвідувачі бачать однакові результати.
- Публічна сторінка оновлює дані кожні 5 секунд.

## Важливо
Не вставляй у `supabase-config.js` secret/service-role key. Для браузерного сайту потрібен publishable key.
