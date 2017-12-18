# How-to publish translations

Translations happen on [ezsystems/ezplatform-i18n](https://github.com/ezsystems/ezplatform-i18n). Changes made on crowdin will be committed to the `l10n_master` branch.

## Merging contributions from crowdin

From the updated master branch, run `php bin/ezsystems/ezplatform-i18n` (requires the crowdin API key, available to managers from the [settings / API](https://crowdin.com/project/ezplatform/settings#api) page. The script will output git commands that add and commit changes to each language, with a progress percentage in the message:

```
php bin/split_language_commits.php                     
No changes to Croatian (0% translated, 0% approved)
No changes to English, United States (96% translated, 12% approved)
No changes to Finnish (4% translated, 0% approved)
git checkout l10n_master translations/fr_FR/
git commit -m "French translation (99% translated, 94% approved)"
git checkout l10n_master translations/de_DE/
git commit -m "German translation (93% translated, 0% approved)"
git checkout l10n_master translations/el_GR/
git commit -m "Greek translation (22% translated, 0% approved)"
No changes to Hindi (16% translated, 0% approved)
No changes to Hungarian (99% translated, 99% approved)
No changes to Italian (83% translated, 2% approved)
git checkout l10n_master translations/ja_JP/
git commit -m "Japanese translation (24% translated, 0% approved)"
No changes to Norwegian Bokmal (99% translated, 0% approved)
No changes to Polish (100% translated, 100% approved)
No changes to Portuguese (96% translated, 96% approved)
No changes to Russian (0% translated, 0% approved)
No changes to Spanish (35% translated, 0% approved)
```

Run the commands. Do a new tag if necessary, and push the changes.

## Publishing changes to the languages repositories

Follow the instructions for git subsplit in the README.md file.