# GitHub Issue Management

This directory contains templates and workflows for managing GitHub issues in this project.

## Issue Templates

### Bug Report Template
Located at `.github/ISSUE_TEMPLATE/bug_report.md`

Use this template for general bug reports. It includes:
- Bug description
- Steps to reproduce
- Expected vs actual behavior
- Environment details
- Technical context

### Page Refresh Bug Template
Located at `.github/ISSUE_TEMPLATE/page_refresh_bug.md`

This is a specific template for the page refresh issue that includes:
- Detailed investigation tasks
- Required information for debugging
- Potential root causes
- Acceptance criteria

## Workflows

### Issue Management Workflow
Located at `.github/workflows/issue-management.yml`

This workflow automatically:
- Detects high-priority bugs and notifies teams
- Identifies frontend/backend specific issues
- Helps with issue assignment

## How to Use

1. **Creating a Bug Report**:
   - Go to the Issues tab in your GitHub repository
   - Click "New Issue"
   - Choose the appropriate template (Bug Report or Page Refresh Bug)
   - Fill in the required information
   - Add appropriate labels

2. **For the Page Refresh Bug**:
   - Use the specific page refresh bug template
   - Fill in as much information as possible
   - Add the `high-priority` label
   - Assign to appropriate team members

## Labels

- `bug`: General bug issues
- `high-priority`: Critical issues that need immediate attention
- `frontend`: Issues related to frontend code
- `backend`: Issues related to backend/API code
- `ui/ux`: User interface and experience issues
- `api`: API-related issues

## Current Active Issues

- **Page Refresh Bug**: Users not seeing page refreshes (High Priority)
  - Status: Open
  - Needs investigation of frontend application
  - Requires coordination between frontend and backend teams