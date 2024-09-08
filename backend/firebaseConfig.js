import admin from 'firebase-admin';
import { fileURLToPath } from 'url';
import path from 'path';
import { readFileSync } from 'fs';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const serviceAccountPath = path.join(__dirname, 'learning-firebase-7c5ed-firebase-adminsdk-jnnn7-1a66045eb1.json');
const serviceAccount = JSON.parse(readFileSync(serviceAccountPath, 'utf8'));

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://learning-firebase-7c5ed-default-rtdb.firebaseio.com" // Replace with your database URL
});

const db = admin.firestore();

// export default db;

export {db , admin, serviceAccount}