import db from './firebaseConfig.js';

async function testFirestoreConnection() {
    try {
        // Perform a simple read operation from a known collection
        const testCollection = 'users'; // Replace with your test collection name
        const snapshot = await db.collection(testCollection).get();
    
        if (snapshot.empty) {
            console.log('No documents found in the collection.');
        } else {
            snapshot.forEach(doc => {
                console.log(`Document ID: ${doc.id}`, doc.data());
            });
        }
    
        console.log('Firestore is connected and operational.');
    } catch (error) {
        console.error('Error connecting to Firestore:', error);
    }
}

testFirestoreConnection();
