-- Admin users table
-- Stores admin credentials and metadata
CREATE TABLE IF NOT EXISTS admins (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT UNIQUE NOT NULL,      -- Unique username for login
    password TEXT NOT NULL,             -- Hashed password
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Gallery table
CREATE TABLE IF NOT EXISTS gallery (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    sort_id INTEGER NOT NULL,          -- Sorting order 
    image BLOB NOT NULL             -- Image data stored as BLOB
);

-- Games table
CREATE TABLE IF NOT EXISTS games (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    sort_id INTEGER NOT NULL,    -- Unique identifier (e.g., 1, 2, 3)
    title TEXT NOT NULL,               -- Game title
    description_1 TEXT NOT NULL,       -- First game description
    description_2 TEXT NOT NULL,       -- Second game description
    background_color TEXT NOT NULL,    -- Background color for the game section
    text_color TEXT NOT NULL,          -- Text color for the game section
    url TEXT,                  -- URL for the game
    image_main BLOB NOT NULL,          -- Main game image
    image_1 BLOB,                       -- Additional game image 1
    image_2 BLOB,                       -- Additional game image 2
    image_3 BLOB                        -- Additional game image 3
);

-- Contact table
CREATE TABLE IF NOT EXISTS email (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    address TEXT NOT NULL              -- Email address
);

-- Misc images table
CREATE TABLE IF NOT EXISTS media (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    label TEXT UNIQUE NOT NULL,         -- Unique identifier (e.g., 'map', 'building')
    image BLOB NOT NULL                 -- Contact-related image data
);

-- Social media links table
CREATE TABLE IF NOT EXISTS social (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    sort_id INTEGER NOT NULL,          -- Added sort_id for ordering
    image BLOB NOT NULL,                -- Social media icon
    url TEXT NOT NULL                  -- Social media profile URL
);

-- Phone numbers table
CREATE TABLE IF NOT EXISTS phone (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    sort_id INTEGER NOT NULL,          -- Sorting order
    image BLOB NOT NULL,               -- Phone icon/image
    number TEXT NOT NULL               -- Phone number as string
);

-- About table
CREATE TABLE IF NOT EXISTS about (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    sort_id INTEGER NOT NULL,          -- Sorting order
    title TEXT NOT NULL,               -- Section title
    image BLOB NOT NULL,               -- Section image
    paragraph_1 TEXT,          -- First text block
    paragraph_2 TEXT,          -- Second text block
    paragraph_3 TEXT          -- Third text block
);

-- Home table
CREATE TABLE IF NOT EXISTS home (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    sort_id INTEGER NOT NULL,          -- Sorting order
    image BLOB NOT NULL,               -- Hero or section image
    header TEXT NOT NULL,              -- Section header text
    paragraph_1 TEXT,                  -- First paragraph of content
    paragraph_2 TEXT,                  -- Second paragraph of content
    action TEXT                        -- Call to action text or button label
);
