// ♦️🎯 1. Creating Dates

// Current date & time
const now = new Date();

// Specific date (year, monthIndex, day, hour, minute, second, ms)
const specificDate = new Date(2025, 8, 2, 14, 30); // Month is 0-based (8 = September)

// From timestamp (ms since 1970-01-01 UTC)
const fromTimestamp = new Date(1693651200000);

// From date string
const fromString = new Date('2025-09-02T14:30:00Z');

// Invalid date
const invalidDate = new Date('invalid-date'); // Invalid Date


// ♦️🎯 2. Get Methods

const d = new Date();

// Full year
d.getFullYear();       // 2025

// Month (0–11)
d.getMonth();          // 8 (September)

// Day of month (1–31)
d.getDate();           // 2

// Day of week (0–6, Sunday=0)
d.getDay();            // 2 (Tuesday)

// Hours (0–23)
d.getHours();

// Minutes (0–59)
d.getMinutes();

// Seconds (0–59)
d.getSeconds();

// Milliseconds (0–999)
d.getMilliseconds();

// Timestamp (ms since Jan 1, 1970 UTC)
d.getTime();

// Timezone offset (in minutes)
d.getTimezoneOffset(); // e.g., -330 for IST


// ♦️🎯 UTC Versions:

d.getUTCFullYear();
d.getUTCMonth();
d.getUTCDate();
d.getUTCDay();
d.getUTCHours();
d.getUTCMinutes();
d.getUTCSeconds();
d.getUTCMilliseconds();

// ♦️🎯 3. Set Methods

const d = new Date();

d.setFullYear(2026);
d.setMonth(5);           // June
d.setDate(15);           // 15th of the month
d.setHours(10);
d.setMinutes(45);
d.setSeconds(30);
d.setMilliseconds(500);

// Set using timestamp
d.setTime(Date.now());

// ♦️🎯 4. Conversion Methods

const d = new Date();

d.toString();           // "Tue Sep 02 2025 14:30:00 GMT+0530 (India Standard Time)"
d.toDateString();       // "Tue Sep 02 2025"
d.toTimeString();       // "14:30:00 GMT+0530 (India Standard Time)"
d.toUTCString();        // "Tue, 02 Sep 2025 09:00:00 GMT"
d.toISOString();        // "2025-09-02T09:00:00.000Z" (always UTC)
d.toJSON();             // same as toISOString()

d.toLocaleDateString(); // e.g., "9/2/2025"
d.toLocaleTimeString(); // e.g., "2:30:00 PM"
d.toLocaleString();     // e.g., "9/2/2025, 2:30:00 PM"


// 6. Date Arithmetic (Common Operations)

const d = new Date();

// Add days
d.setDate(d.getDate() + 7);

// Subtract days
d.setDate(d.getDate() - 7);

// Add months
d.setMonth(d.getMonth() + 1);

// Subtract years
d.setFullYear(d.getFullYear() - 1);

// Difference between two dates (in days)
const d1 = new Date('2025-09-02');
const d2 = new Date('2025-09-10');
const diffMs = d2 - d1;              // milliseconds
const diffDays = diffMs / (1000*60*60*24); // 8 days





