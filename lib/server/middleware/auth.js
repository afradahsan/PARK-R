const jwt = require('jsonwebtoken');

const auth = async (req, res, next) => {
  try {
    console.log('Middleware');
    const token = req.header('auth-token');
    if (!token)
      return res.status(401).json({ msg: 'No Auth token, Access Denied' });

    const verified = jwt.verify(token, 'passwordKey');
    console.log('Verified JWT:', verified); // Log the verified object
    if (!verified)
      return res.status(401).json({ msg: 'Token verification failed, Auth Denied' });

    req.user = verified.id;
    req.token = token;
    next(); // Call next() to proceed to the next middleware or route handler
  } catch (e) {
    console.error('Error in authentication middleware:', e.message);
    res.status(500).json({ error: e.message });
  }
};

module.exports = auth;
