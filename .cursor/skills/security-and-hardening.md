---
name: security-and-hardening
description: Hardens JavaScript/web applications against vulnerabilities. Use when handling user input, authentication, data storage, or external integrations in a JS/web project.
---

# Security and Hardening

## Overview

Security-first development practices. Treat every external input as hostile, every secret as sacred, every authorization check as mandatory.

## The Three-Tier Boundary System

### Always Do
- Validate all external input
- Parameterize all database queries
- Encode output (prevent XSS)
- Use HTTPS
- Hash passwords with bcrypt/scrypt/argon2
- Set security headers
- Use httpOnly, secure, sameSite cookies
- Run npm audit

### Ask First
- Adding new auth flows
- Storing new PII categories
- Adding external integrations
- Changing CORS configuration

### Never Do
- Commit secrets to version control
- Log sensitive data
- Trust client-side validation as security boundary
- Disable security headers
- Use eval() or innerHTML with user data
- Store sessions in localStorage

## OWASP Top 10 Prevention

1. Injection — Parameterized queries
2. Broken Authentication — Password hashing, secure sessions
3. XSS — Framework auto-escaping, DOMPurify
4. Broken Access Control — Always check authorization
5. Security Misconfiguration — Helmet, CSP, CORS restrictions
6. Sensitive Data Exposure — Never return sensitive fields

## Input Validation, File Upload Safety, Rate Limiting, Secrets Management

## Triaging npm audit Results

Decision tree by severity: critical/high → fix immediately, moderate → fix next cycle, low → track.

## Common Rationalizations

| Rationalization | Reality |
|---|---|
| "This is an internal tool" | Internal tools get compromised. |
| "We'll add security later" | Retrofitting is 10x harder. |
| "The framework handles security" | Frameworks provide tools, not guarantees. |

## Verification

- [ ] npm audit shows no critical/high vulnerabilities
- [ ] No secrets in source code or git history
- [ ] All user input validated at boundaries
- [ ] Auth checked on every protected endpoint
- [ ] Security headers present
- [ ] Error responses don't expose internals
- [ ] Rate limiting active on auth endpoints
