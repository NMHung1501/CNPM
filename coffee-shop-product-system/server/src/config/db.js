import sql from 'mssql';

export async function startServer(app, env) {
  try {
    // Reading directly from process.env to bypass object mapping errors
    const config = {
      server: process.env.DB_HOST || process.env.DB_SERVER || 'localhost',
      database: process.env.DB_NAME || process.env.DB_DATABASE || 'DB_Coffee',
      user: process.env.DB_USER || process.env.DB_USERNAME || 'sa', 
      password: process.env.DB_PASSWORD || process.env.DB_PASS || 'Hung15012006@', 
      port: parseInt(process.env.DB_PORT) || 1433,
      options: {
        trustServerCertificate: true,             
        encrypt: false                            
      }
    };

    // Establishing the connection pool
    const pool = await sql.connect(config);
    
    // Testing the connection
    await pool.request().query('SELECT 1 AS ok');

    console.log('DB connected');
    app.locals.pool = pool;

    // Starting the Express web server
    app.listen(env.PORT || 5000, () => {
      console.log(`Server listening on port ${env.PORT || 5000}`);
    });
  } catch (err) {
    console.error('DB connection failed:', err);
    process.exit(1);
  }
}