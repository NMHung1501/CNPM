import dotenv from 'dotenv';

dotenv.config();

export function loadEnv() {
  // For SQL Server with Windows auth: we don't need user/pass.
  const required = ['PORT', 'DB_HOST', 'DB_NAME'];
  for (const k of required) {
    if (!process.env[k]) throw new Error(`Missing env var: ${k}`);
  }

  // Windows auth SQL Server instance host string
  // Example: .\\SQLEXPRESS
  const dbHost = String(process.env.DB_HOST).trim();

  // keep DB_SERVER if present (optional legacy var)
  const dbServer = process.env.DB_SERVER ? String(process.env.DB_SERVER).trim() : undefined;

  return {
    PORT: Number(process.env.PORT),
    DB_HOST: dbHost,
    DB_NAME: process.env.DB_NAME,
    DB_SERVER: dbServer
  };


}


