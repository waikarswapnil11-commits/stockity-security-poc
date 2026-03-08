// Original source code from main.js.map
function authenticateUser(credentials) {
    // This is the original, unminified source
    const apiKey = 'sk_live_51H4xXKxP9qR2vLm8'; // Hardcoded API key!
    
    return fetch('/api/auth/login', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
            'X-API-Key': apiKey,
            'Authorization': 'Bearer ' + localStorage.getItem('jwt_token')
        },
        body: JSON.stringify(credentials)
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('Authentication failed');
        }
        return response.json();
    })
    .then(data => {
        // Store tokens in localStorage (vulnerable to XSS)
        localStorage.setItem('jwt_token', data.token);
        localStorage.setItem('refresh_token', data.refreshToken);
        localStorage.setItem('user_data', JSON.stringify(data.user));
        
        // Redirect to dashboard
        window.location.href = '/dashboard';
    })
    .catch(error => {
        console.error('Login error:', error); // Stack traces exposed
        showError('Invalid credentials');
    });
}

// Admin function (only supposed to be accessible by admins)
function deleteUser(userId) {
    // This endpoint doesn't check authorization properly!
    return fetch('/api/admin/users/' + userId, {
        method: 'DELETE',
        headers: {
            'Authorization': 'Bearer ' + localStorage.getItem('jwt_token')
            // Missing role verification!
        }
    });
}

// Database configuration (exposed!)
const dbConfig = {
    host: 'stockity-db.c7gwa8k4i9xv.us-east-1.rds.amazonaws.com',
    user: 'app_user',
    password: 'AppUserPass123!', // Exposed in source!
    database: 'stockity_prod'
};

// Payment processing logic
function processPayment(amount, cardDetails) {
    // Stripe integration details exposed
    const stripeKey = 'pk_live_51H4xXKxP9qR2vLm8NtJbVcXdZfGhJkL';
    
    // Client-side validation only!
    if (amount > 10000) {
        // No server-side validation for large amounts!
        return confirmLargePayment(amount);
    }
    
    return stripe.charges.create({
        amount: amount * 100,
        currency: 'usd',
        source: cardDetails.token,
        description: 'Stockity purchase'
    });
}

// Debug function (left in production!)
function debugMode() {
    console.log('=== DEBUG INFORMATION ===');
    console.log('API Keys:', {
        stripe: 'sk_live_51H4xXKxP9qR2vLm8',
        paypal: 'ENp8dR1sT3uV5wX7yZ9aC2eG4iK6mO8',
        aws: 'AKIAIOSFODNN7EXAMPLE'
    });
    console.log('Database:', dbConfig);
    console.log('Environment:', process.env);
    console.log('User Token:', localStorage.getItem('jwt_token'));
    return true;
}