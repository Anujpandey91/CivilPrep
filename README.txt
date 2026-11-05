CIVILPREP + SUPABASE SETUP
==========================

FILES
- index.html: complete CivilPrep app with Supabase email/password auth and cloud sync.
- supabase_setup.sql: database table and Row Level Security policies.

STEP 1 — CREATE A SUPABASE PROJECT
1. Go to https://supabase.com and create a project.
2. Open Project Settings > API (or Data API / API Keys, depending on dashboard version).
3. Copy the Project URL.
4. Copy the anon/public key (sometimes labelled publishable key).
   NEVER use the service_role or secret key in this HTML file.

STEP 2 — CREATE THE DATABASE TABLE
1. In Supabase, open SQL Editor > New query.
2. Open supabase_setup.sql from this package.
3. Copy its complete contents into the SQL Editor and click Run.
4. Confirm that public.civilprep_user_data was created.

STEP 3 — ADD YOUR PROJECT KEYS TO index.html
Open index.html in VS Code and find:

const SUPABASE_URL = 'https://YOUR_PROJECT_ID.supabase.co';
const SUPABASE_ANON_KEY = 'YOUR_SUPABASE_ANON_OR_PUBLISHABLE_KEY';

Replace the first placeholder with your Project URL and the second with your anon/public (or publishable) key. Keep the quotation marks. Do not paste a service_role/secret key.

STEP 4 — ENABLE EMAIL AUTH
1. Supabase Dashboard > Authentication > Providers > Email.
2. Ensure Email provider is enabled.
3. For production, configure the Site URL and Redirect URLs under Authentication > URL Configuration.
4. Add your GitHub Pages URL, for example:
   https://Anujpandey91.github.io/CivilPrep/
   You may also add http://localhost:5500 for local testing.
5. Email confirmation may be enabled. If it is, new users must confirm their email before signing in.

STEP 5 — PUBLISH ON GITHUB PAGES
1. Replace your repository's existing index.html with this configured index.html.
2. Commit and push the change.
3. Open the GitHub Pages URL and create an account / sign in.

HOW SYNC WORKS
- Before signing in, the app continues to save to this browser's localStorage.
- On the first sign-in, the current browser's CivilPrep data is uploaded to that account.
- After that, changes are automatically saved to Supabase (debounced by 700 ms).
- When you sign in on another browser/device, that account's cloud data is loaded.
- Signing out does not erase the local browser copy.
- The existing JSON export/import backup remains available.

IMPORTANT DATA BEHAVIOUR
The first successful sign-in to a new account seeds that account from the current browser's local data. If the account already has cloud data, that cloud copy replaces the currently loaded app data. Export a JSON backup before switching accounts or devices if you need to preserve separate local progress.

SECURITY
- The browser uses only the anon/public (or publishable) key. This key is designed to be exposed in frontend apps; security comes from Authentication plus the RLS policies in the SQL file.
- NEVER put your Supabase service_role key or any secret key in index.html, GitHub, or browser code.
- The SQL policies ensure each authenticated user can access only the row whose user_id matches their own auth.uid().
