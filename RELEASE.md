# Release Guide

This document describes how to release new versions of the gem.

## Version Bumping

Use the `bump-version` script to bump the version:

```bash
ruby script/bump-version [major|minor|patch]
```

The script auto-detects the bump type from commit messages:
- `feat!:` or `BREAKING` → major
- `feat:` → minor
- `fix:` → patch (default)

## Manual Release

1. Bump the version:
   ```bash
   ruby script/bump-version patch
   ```

2. Build the gem:
   ```bash
   gem build *.gemspec
   ```

3. Publish to RubyGems:
   ```bash
   gem push activeadmin_mitosis_editor-X.X.X.gem
   ```

4. Create a git tag:
   ```bash
   git tag vX.X.X
   git push origin main --tags
   ```

## GitHub Actions Release

The repository has an automated workflow that runs on push to `main`.

### Automatic (on push)

On every push to `main`, the workflow:
1. Detects version bump type from commits
2. Updates version in `lib/activeadmin_mitosis_editor/version.rb`
3. Updates CHANGELOG.md
4. Builds the gem
5. Publishes to RubyGems
6. Creates a git tag

### Manual (workflow dispatch)

You can manually trigger a release from the GitHub Actions UI:

1. Go to Actions → Release
2. Click "Run workflow"
3. Select version type: `patch`, `minor`, or `major`
4. Click "Run workflow"

## Requirements

- Ruby 3.3+
- RubyGems account with API key
- `RUBYGEMS_API_KEY` secret in GitHub repository settings

## CHANGELOG

The CHANGELOG.md follows [Keep a Changelog](https://keepachangelog.com/) format.

When bumping version, add entries under `## [Unreleased]` with appropriate change type:
- `### Added` - new features
- `### Changed` - changes to existing functionality
- `### Deprecated` - soon-to-be removed features
- `### Removed` - removed features
- `### Fixed` - bug fixes
- `### Security` - security fixes
