# 🔴 Stockity.com Security Vulnerabilities - Private Disclosure

## 📋 Overview
This repository contains proof-of-concept demonstrations for critical security vulnerabilities discovered on stockity.com.

## 🔥 Vulnerability Summary

| Severity | Category | Location |
|----------|----------|----------|
| **CRITICAL** | Git Repository Exposure | `01-git-exposure/` |
| **CRITICAL** | Environment File Exposure | `02-env-files/` |
| **CRITICAL** | Database Backups | `03-backup-files/` |
| **HIGH** | Admin Panel Exposure | `04-admin-panels/` |
| **CRITICAL** | Authentication Tokens | `05-authentication-tokens/` |
| **MEDIUM** | Source Map Exposure | `06-source-maps/` |
| **MEDIUM** | Directory Listings | `07-directory-listing/` |
| **MEDIUM** | Server Info Disclosure | `08-server-info/` |
| **MEDIUM** | Subdomain Enumeration | `09-subdomain-enum/` |
| **MEDIUM** | Fuzzing Results | `10-wildcard-fuzzing/` |

## 📁 Repository Structure
stockity-security-poc/
├── 01-git-exposure/ # Git repository access proofs
├── 02-env-files/ # Environment file exposures
├── 03-backup-files/ # Database backup proofs
├── 04-admin-panels/ # Admin panel access
├── 05-authentication-tokens/ # Extracted JWT/OAuth tokens
├── 06-source-maps/ # Source code reconstruction
├── 07-directory-listing/ # Directory enumeration
├── 08-server-info/ # Server information disclosure
├── 09-subdomain-enum/ # Subdomain findings
├── 10-wildcard-fuzzing/ # Complete fuzzing results
├── documentation/ # Summary reports
└── scripts/ # Verification scripts

text

## 🔐 Access
This repository is **PRIVATE** and shared only with Stockity security team.

## 📞 Contact

**Security Researcher**: waikarswapnil11  
**Repository**: https://github.com/waikarswapnil11-commits/stockity-security-poc

---

## 📝 How to Use This Repository

1. **Verify the findings** by running:
   ```bash
   ./scripts/verify-poc.sh
Review each vulnerability category in the numbered directories

Check the documentation folder for summary reports and disclosure letters

⚠️ Important Notes
This repository contains proof-of-concept code only

All sensitive data has been redacted or use placeholder values

Do not share this repository publicly

For authorized security researchers and Stockity team only

This repository is part of a responsible disclosure process. Please acknowledge receipt within 48 hours.
