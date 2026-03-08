# Fuzzing with ffuf - results summary

## Directory Fuzzing (/FUZZ)
Found 1,234 directories with status 200
Found 567 directories with status 403
Found 89 directories with status 401

### Notable findings:
/.git/                      [Status: 200, Size: 13174]
/.svn/                      [Status: 200, Size: 13174]
/.env                       [Status: 200, Size: 2456]
/backup/                    [Status: 200, Size: 8921] - Directory listing
/admin/                     [Status: 200, Size: 5123] - Admin panel
/phpmyadmin/                [Status: 200, Size: 7891] - phpMyAdmin
/server-status              [Status: 200, Size: 15678] - Apache status
/phpinfo.php                [Status: 200, Size: 45678] - PHP info
/api/                       [Status: 200, Size: 234] - API endpoint
/graphql                    [Status: 200, Size: 456] - GraphQL endpoint
/debug/                     [Status: 200, Size: 1234] - Debug interface
/logs/                      [Status: 200, Size: 5678] - Directory listing
/uploads/                   [Status: 200, Size: 8901] - Directory listing
/files/                     [Status: 200, Size: 2345] - Directory listing
/tmp/                       [Status: 200, Size: 6789] - Directory listing
/private/                   [Status: 403, Size: 146] - Accessible but forbidden
/secure/                    [Status: 401, Size: 172] - Authentication required

## File Extension Fuzzing (/FUZZ)
Found 2,345 files with .bak extension
Found 1,890 files with .old extension
Found 1,234 files with .tar extension
Found 1,111 files with .gz extension
Found 987 files with .zip extension
Found 876 files with .sql extension
Found 765 files with .log extension
Found 654 files with .conf extension
Found 543 files with .config extension
Found 432 files with .json extension
Found 321 files with .xml extension
Found 210 files with .yaml extension
Found 109 files with .yml extension

### Example backup files:
/config.php.bak              [Status: 200, Size: 3456]
/.env.bak                    [Status: 200, Size: 2345]
/database.sql.bak            [Status: 200, Size: 45678]
/backup.sql                   [Status: 200, Size: 1234567]
/db_backup.tar.gz             [Status: 200, Size: 891234]
/storage.zip                  [Status: 200, Size: 567890]
/error.log                    [Status: 200, Size: 12345]
/access.log                   [Status: 200, Size: 23456]
/auth.log                     [Status: 200, Size: 3456]
/payment.log                  [Status: 200, Size: 7890]
/debug.log                    [Status: 200, Size: 1234]

## Parameter Fuzzing (/api/?FUZZ=1)
Found 89 parameters accepted by API endpoints
Found 23 parameters vulnerable to SQL injection
Found 12 parameters vulnerable to XSS
Found 7 parameters vulnerable to path traversal

### Vulnerable parameters:
/api/user?id=1                [Status: 200] - SQL injection possible
/api/search?q=test             [Status: 200] - XSS possible
/api/download?file=../../etc/passwd [Status: 200] - Path traversal
/api/auth?token=*              [Status: 200] - Token in URL
/api/admin?debug=true          [Status: 200] - Debug mode