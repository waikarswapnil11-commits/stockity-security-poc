// config.php (exposed)
<?php
define('DB_HOST', 'localhost');
define('DB_USER', 'stockity_admin');
define('DB_PASS', 'St0ck!ty@2024#Secure');
define('DB_NAME', 'stockity_prod');

define('JWT_SECRET', '7x9kL2mN4pQ6rS8tU0vW2xY4zA6bC8dE0fG2hI4');
define('API_KEY', 'sk_live_51H4xXKxP9qR2vLm8NtJbVcXdZfGhJkL');

// Payment Gateway
define('STRIPE_SECRET', 'sk_live_51H4xXKxP9qR2vLm8NtJbVcXdZfGhJkL');
define('PAYPAL_MODE', 'live');
define('PAYPAL_CLIENT_ID', 'AXp7cQ9rT2vLm4nB6jK8xZ0cV2bN4mP6');
define('PAYPAL_SECRET', 'ENp8dR1sT3uV5wX7yZ9aC2eG4iK6mO8');

// Debug Mode (should be false in production)
define('DEBUG_MODE', true); // CRITICAL: Debug mode enabled!
define('DISPLAY_ERRORS', true);
?>