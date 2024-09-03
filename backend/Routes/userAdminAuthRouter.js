import express from 'express';
const router = express.Router();

router.get('/', (req, res) => {
  res.json({ message: 'Welcome Admin!' });
});

router.get('/users', (req, res) => {

    //fetches all user list

  res.json({ message: 'Admin Dashboard' });
});

export {router as userAdminAuthRouter};
