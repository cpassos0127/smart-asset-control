
const { Pool } = require('pg');
const fs = require('fs');
const path = require('path');

const pool = new Pool({
  user: 'postgres',
  host: '34.39.135.229',
  database: 'smart',
  password: 'oqGFfSXDwXLNDuZ',
  port: 5432,
  ssl: {
    rejectUnauthorized: true,
    ca: fs.readFileSync(path.join(__dirname, 'certs', 'server-ca.pem')).toString()
  }
});

module.exports = pool;
