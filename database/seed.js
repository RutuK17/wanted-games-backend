import sqlite3 from 'sqlite3';
import path from 'path';
import bcrypt from 'bcryptjs';
import fs from 'fs';
import { fileURLToPath } from 'url';
import dotenv from 'dotenv';

dotenv.config();

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const dbPath = process.env.DB_PATH || path.join(__dirname, 'website.db');
const schemaPath = path.join(__dirname, 'schema.sql');

/**
 * Database initialization and seeding function
 * Creates tables and populates with initial data
 */
async function initializeDatabase() {
    // Create a new database connection
    const db = new sqlite3.Database(dbPath, async (err) => {
        if (err) {
            console.error('Error connecting to database:', err);
            process.exit(1);
        }
        console.log('Connected to SQLite database');
    });

    try {
        // Read schema file and execute SQL statements
        const schema = fs.readFileSync(schemaPath, 'utf8');
        
        // Promisify database operations
        const runAsync = (sql) => new Promise((resolve, reject) => {
            db.run(sql, (err) => {
                if (err) reject(err);
                else resolve();
            });
        });

        // Execute each schema statement
        const statements = schema.split(';').filter(stmt => stmt.trim());
        for (let statement of statements) {
            await runAsync(statement);
        }

        // Create default admin account
        const hashedPassword = await bcrypt.hash('admin123', 10);
        await runAsync(`
            INSERT OR IGNORE INTO admins (username, password)
            VALUES ('admin', '${hashedPassword}')
        `);

        // Insert sample content
        const sampleContents = [
            {
                title: 'Welcome to Our Website',
                body: 'This is our first article. We hope you enjoy your stay!',
            },
            {
                title: 'Getting Started Guide',
                body: 'Here are some tips to help you get started with our platform...',
            }
        ];

        for (let content of sampleContents) {
            await runAsync(`
                INSERT INTO contents (title, body, created_by)
                VALUES (
                    '${content.title}',
                    '${content.body}',
                    (SELECT id FROM admins WHERE username = 'admin')
                )
            `);
        }

        console.log('Database seeded successfully!');
        console.log('Default admin credentials:');
        console.log('Username: admin');
        console.log('Password: admin123');

    } catch (error) {
        console.error('Error seeding database:', error);
    } finally {
        // Close database connection
        db.close((err) => {
            if (err) {
                console.error('Error closing database:', err);
            } else {
                console.log('Database connection closed');
            }
        });
    }
}

// Run the initialization
initializeDatabase(); 