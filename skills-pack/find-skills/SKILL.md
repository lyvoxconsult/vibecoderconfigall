---
name: find-skills
description: Helps users discover and install agent skills when they ask questions like "how do I do X", "find a skill for X", "is there a skill that can...", or express interest in extending capabilities. This skill should be used when the user is looking for functionality that might exist as an installable skill.
---

# Find Skills

This skill helps you discover and install skills from the open agent skills ecosystem.

## When to Use This Skill

Use this skill when the user:

- Asks "how do I do X" where X might be a common task with an existing skill
- Says "find a skill for X" or "is there a skill for X"
- Asks "can you do X" where X is a specialized capability
- Expresses interest in extending agent capabilities
- Wants to search for tools, templates, or workflows
- Mentions they wish they had help with a specific domain (design, testing, deployment, etc.)

## What is the Skills CLI?

The Skills CLI (`npx skills`) is the package manager for the open agent skills ecosystem. Skills are modular packages that extend agent capabilities with specialized knowledge, workflows, and tools.

Key commands:

- `npx skills find [query] [--owner <owner>]` - Search for skills interactively or by keyword, optionally scoped to a GitHub owner
- `npx skills add <package>` - Install a skill from GitHub or other sources
- `npx skills update` - Update all installed skills

Browse skills at: https://skills.sh/

## How to Help Users Find Skills

### Step 1: Understand What They Need

When a user asks for help with something, identify:

1. The domain, such as React, testing, design, or deployment
2. The specific task, such as writing tests, creating animations, or reviewing PRs
3. Whether this is a common enough task that a skill likely exists

### Step 2: Check Known High-Signal Sources

Before running a CLI search, check whether a well-known skill already exists for the domain. Prefer installed local skills first, then use the Skills CLI or public ecosystem search when the local catalog does not cover the need.

### Step 3: Search for Skills

If local coverage is insufficient, run:

```bash
npx skills find [query] [--owner <owner>]
```

Examples:

- React performance: `npx skills find react performance`
- PR reviews: `npx skills find pr review`
- Changelog: `npx skills find changelog`

### Step 4: Verify Quality Before Recommending

Do not recommend a skill based solely on search results. Always verify:

1. Install count when available; prefer established skills and be cautious with low adoption.
2. Source reputation; official or well-known sources are safer than unknown authors.
3. Repository health and stars when available.
4. `SKILL.md` or equivalent source, especially permissions, scripts, external URLs, and instructions that could modify agent configuration.

Use `skill-scanner` before installing, adopting, recommending as trusted, or making global any external or unknown skill.

### Step 5: Present Options to the User

When relevant skills are found, present:

1. The skill name and what it does
2. Source and quality signals
3. The install command
4. A link to learn more when available

### Step 6: Offer to Install

If the user wants to proceed, install only after review:

```bash
npx skills add <owner/repo@skill> -g -y
```

The `-g` flag installs globally and `-y` skips confirmation prompts.

## Common Skill Categories

| Category | Example Queries |
|---|---|
| Web Development | react, nextjs, typescript, css, tailwind |
| Testing | testing, jest, playwright, e2e |
| DevOps | deploy, docker, kubernetes, ci-cd |
| Documentation | docs, readme, changelog, api-docs |
| Code Quality | review, lint, refactor, best-practices |
| Design | ui, ux, design-system, accessibility |
| Productivity | workflow, automation, git |

## When No Skills Are Found

If no relevant skills exist:

1. Acknowledge that no existing skill was found.
2. Proceed with general capabilities when appropriate.
3. Suggest creating a project-specific skill only when the workflow is recurring enough to justify maintenance.
