# eZ Platform i18n

[![Crowdin](https://d322cqt584bo4o.cloudfront.net/ezplatform/localized.svg)](https://crowdin.com/project/ezplatform)

## Introduction

This is a meta repository that centralizes eZ Platform translations to ease synchronization with Crowdin.

**Important** : This repository is not supposed to be used on a production project, each translation will be 
splitted in a dedicated package.

## Crowdin

If you want to help us on translating eZ Platform feel free to contribute on [eZ Platform project on Crowdin][crowdin-ezplatform].

### In context translation

You can enable [Crowdin in context translation][in-context] by setting a specific cookie on a eZ Platform application.

One way to do this is to open the development console (right click, inspect) and run these lines:

**Enable :**

    document.cookie='ez_in_context_translation=1;path=/;'; location.reload();
    
**Disable :** 

    document.cookie='ez_in_context_translation=;expires=Mon, 05 Jul 2000 00:00:00 GMT;path=/;'; location.reload();

## Repository split

Each locale will be stored in its own repository in [ezplatform-i18n organisation][ezplatform-i18n-org].

This synchronisation is done using [dflydev/git-subsplit][dflydev] tool.

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
    " --heads=master

## Copyright & License
Copyright (c) eZ Systems AS. For copyright and license details see provided LICENSE file.

[dflydev]: https://github.com/dflydev/git-subsplit
[crowdin-ezplatform]: https://crowdin.com/project/ezplatform
[ezplatform-i18n-org]: https://github.com/ezplatform-i18n
[in-context]: https://crowdin.com/page/in-context-localization
