$ curl -H "Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwicm9sZSI6ImFkbWluIn0.abcdefgh" https://stockity.com/api/admin/users
{
  "users": [
    {"id": 1, "email": "admin@stockity.com", "role": "admin"},
    {"id": 2, "email": "john.doe@example.com", "role": "user"}
  ],
  "total": 15234
}

[✓] Token validated! Admin access confirmed.