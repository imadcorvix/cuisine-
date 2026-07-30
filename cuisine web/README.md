# Massif Cuisines — site

## Fichiers
- `index.html` — site public
- `admin.html` — gestion des photos (protégé par PIN, voir plus bas)
- `assets/hero.jpg` — photo de fond du hero
- `assets/icon.png` — icône extraite du logo
- `supabase-setup.sql` — script à exécuter une seule fois dans Supabase

## 1. Supabase (déjà fait pour toi)
1. Ouvre ton projet Supabase → **SQL Editor** → New query.
2. Colle tout le contenu de `supabase-setup.sql` → **Run**.
3. Ça crée la table `gallery_items` + le bucket de stockage `gallery`, avec les autorisations nécessaires.

## 2. GitHub + Vercel
1. Crée un nouveau repo GitHub, upload les 4 fichiers/dossiers ci-dessus (garde `assets/` tel quel).
2. Sur Vercel : New Project → importe le repo → aucune config nécessaire (site statique) → Deploy.
3. Le site sera en ligne à une URL du type `massif-cuisines.vercel.app`.

## 3. Avant de publier
- **Change le code PIN** dans `admin.html` (cherche `ADMIN_PIN = '2026'` tout en haut du `<script>`) pour un code que toi seul connais.
- **Remplace les coordonnées de contact** dans `index.html` (téléphone, WhatsApp, email) — cherche le commentaire `TODO Imad` dans la section Contact.
- Va sur `tonsite.vercel.app/admin.html` pour commencer à ajouter des photos par catégorie.

## À savoir sur la sécurité de l'admin
Le PIN protège juste l'accès à l'interface — ce n'est pas une vraie authentification. Techniquement, quelqu'un qui aurait l'URL Supabase et la clé publique pourrait écrire directement dans la table sans passer par le PIN. Pour un outil interne comme celui-ci, c'est un compromis raisonnable (comme ton outil CAC Saftiee). Si un jour tu veux verrouiller ça plus sérieusement avec une vraie connexion, dis-le moi.
