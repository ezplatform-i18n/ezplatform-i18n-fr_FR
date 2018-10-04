# How-to publish translations

Translations happen on [ezsystems/ezplatform-i18n](https://github.com/ezsystems/ezplatform-i18n).
Changes made on crowdin are pushed to the `l10n_master` branch, and a pull-request is open.

**DO NOT MERGE THE PULL REQUEST**

## Merging contributions from crowdin

This procedure requires a **crowdin API key**. Those are available to
managers from the [settings / API][crowdin_api_settings] page.

The commands below must be executed from the `vendor/ezsystems/ezplatform-i18n` directory,
and it must be a git working copy. If it is not, run:
```
rm -rf vendor/ezsystems/ezplatform-i18n
composer update --prefer-source ezsystems/ezplatform-i18n
```

From the updated `master` branch, run `php bin/ezsystems/ezplatform-i18n/bin/split_language_commits`*[]:
The script will output git commands that add and commit changes to each language,
with a progress percentage in the message:

```
$ php bin/split_language_commits.php

# Croatian: no changes (0% translated, 0% approved)
# English, United States: no changes (96% translated, 12% approved)
# French (france): (99% translated, 94% approved)
git checkout l10n_master translations/fr_FR/
git commit -m "French translation (99% translated, 94% approved)"
# German: (93% translated, 0% approved)
git checkout l10n_master translations/de_DE/
git commit -m "German translation (93% translated, 0% approved)"
```

Run the commands. Do a new tag if necessary, and push the changes.

[crowdin_api_settings]: https://crowdin.com/project/ezplatform/settings#api

## Publishing changes to the languages repositories

Each locale will be stored in its own repository,
under the [ezplatform-i18n organisation][ezplatform-i18n-org].

Synchronization is done using [dflydev/git-subsplit][dflydev].

    git subsplit init https://github.com/ezsystems/ezplatform-i18n
    git subsplit update
    git subsplit publish "
        translations/ach_UG:git@github.com:ezplatform-i18n/ezplatform-i18n-ach_UG.git
        translations/de_DE:git@github.com:ezplatform-i18n/ezplatform-i18n-de_DE.git
        translations/es_ES:git@github.com:ezplatform-i18n/ezplatform-i18n-es_ES.git
        translations/el_GR:git@github.com:ezplatform-i18n/greek.git
        translations/fi_FI:git@github.com:ezplatform-i18n/ezplatform-i18n-fi_FI.git
        translations/fr_FR:git@github.com:ezplatform-i18n/ezplatform-i18n-fr_FR.git
        translations/hi_IN:git@github.com:ezplatform-i18n/ezplatform-i18n-hi_IN.git
        translations/hu_HU:git@github.com:ezplatform-i18n/ezplatform-i18n-hu_HU.git
        translations/ja_JP:git@github.com:ezplatform-i18n/ezplatform-i18n-ja_JP.git
        translations/nb_NO:git@github.com:ezplatform-i18n/ezplatform-i18n-nb_NO.git
        translations/no_NO:git@github.com:ezplatform-i18n/ezplatform-i18n-no_NO.git
        translations/pl_PL:git@github.com:ezplatform-i18n/ezplatform-i18n-pl_PL.git
        translations/pt_PT:git@github.com:ezplatform-i18n/ezplatform-i18n-pt_PT.git
        translations/ru_RU:git@github.com:ezplatform-i18n/ezplatform-i18n-ru_RU.git
        translations/it_IT:git@github.com:ezplatform-i18n/ezplatform-i18n-it_IT.git
        translations/en_US:git@github.com:ezplatform-i18n/ezplatform-i18n-en_US.git
        translations/nl:git@github.com:ezplatform-i18n/dutch.git
        translations/he:git@github.com:ezplatform-i18n/hebrew.git
        translations/zh_hk:git@github.com:ezplatform-i18n/chinese-hong-kong.git
    " --heads=master

`--heads=master` specifies which branches are split. Multiple branches can be provided: `--heads="master 1.0".
To split only some tags, use `--tags="tagName otherTagName". Branches can be omitted using `--no-heads`. 

