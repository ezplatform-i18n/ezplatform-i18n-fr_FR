#!/usr/bin/env sh
# Synchronize translation sources from all packages to ezplatform-i18n
echo '# Translation synchronization';


echo '# Mirror the translation files';

echo "ezsystems/ezplatform-admin-ui"
rm -f ./vendor/ezsystems/ezplatform-i18n/ezplatform-admin-ui/*
cp ./vendor/ezsystems/ezplatform-admin-ui/src/bundle/Resources/translations/* ./vendor/ezsystems/ezplatform-i18n/ezplatform-admin-ui

echo "ezsystems/ezpublish-kernel"
rm -f ./vendor/ezsystems/ezplatform-i18n/ezpublish-kernel/*
cp ./vendor/ezsystems/ezpublish-kernel/eZ/Bundle/EzPublishCoreBundle/Resources/translations/* ./vendor/ezsystems/ezplatform-i18n/ezpublish-kernel

echo "ezsystems/repository-forms"
rm -f ./vendor/ezsystems/ezplatform-i18n/repository-forms/*
cp ./vendor/ezsystems/repository-forms/bundle/Resources/translations/* ./vendor/ezsystems/ezplatform-i18n/repository-forms

if [ -d "./vendor/ezsystems/date-based-publisher" ]; then
  echo "ezsystems/date-based-publisher"
  rm -f ./vendor/ezsystems/ezplatform-i18n/date-based-publisher/*
  cp ./vendor/ezsystems/date-based-publisher/bundle/Resources/translations/* ./vendor/ezsystems/ezplatform-i18n/date-based-publisher
fi

if [ -d "./vendor/ezsystems/flex-workflow" ]; then
  echo "ezsystems/flex-workflow"
  rm -f ./vendor/ezsystems/ezplatform-i18n/flex-workflow/*
  cp ./vendor/ezsystems/flex-workflow/bundle/Resources/translations/* ./vendor/ezsystems/ezplatform-i18n/flex-workflow
fi

if [ -d "./vendor/ezsystems/ezplatform-page-builder" ]; then
  echo "ezsystems/ezplatform-page-builder"
  rm -f ./vendor/ezsystems/ezplatform-i18n/ezplatform-page-builder/*
  cp ./vendor/ezsystems/ezplatform-page-builder/src/bundle/Resources/translations/* ./vendor/ezsystems/ezplatform-i18n/ezplatform-page-builder
fi

if [ -d "./vendor/ezsystems/ezplatform-page-fieldtype" ]; then
  echo "ezsystems/ezplatform-page-fieldtype"
  rm -f ./vendor/ezsystems/ezplatform-i18n/ezplatform-page-fieldtype/*
  cp ./vendor/ezsystems/ezplatform-page-fieldtype/src/bundle/Resources/translations/* ./vendor/ezsystems/ezplatform-i18n/ezplatform-page-fieldtype
fi

echo '# Fixing .xlf extensions'
rename -s '.xliff' '.xlf' vendor/ezsystems/ezplatform-i18n/*/*

echo '# Strip english locale suffix from filename';
rename -s '.en' '' ./vendor/ezsystems/ezplatform-i18n/*/*

echo 'Translation synchronization done !';
