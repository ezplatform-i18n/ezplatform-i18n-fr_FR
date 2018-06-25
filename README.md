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

## Copyright & License
Copyright (c) eZ Systems AS. For copyright and license details see provided LICENSE file.

[dflydev]: https://github.com/dflydev/git-subsplit
[crowdin-ezplatform]: https://crowdin.com/project/ezplatform
[ezplatform-i18n-org]: https://github.com/ezplatform-i18n
[in-context]: https://crowdin.com/page/in-context-localization
