#!/usr/bin/env sh
# This script should be used to synchronize ezplatform-i18n repository
# Translations must be up-to-date in all packages
echo 'Translation synchronization';

echo '# Clean corresponding ezplatform-i18n folder';
rm -rf ./vendor/ezsystems/ezplatform-i18n/ezplatform-admin-ui/*.xlf
rm -rf ./vendor/ezsystems/ezplatform-i18n/ezpublish-kernel/*.xlf
rm -rf ./vendor/ezsystems/ezplatform-i18n/repository-forms/*.xlf

echo '# Mirror the translation files';
cp ./vendor/ezsystems/ezplatform-admin-ui/src/bundle/Resources/translations/*.xliff ./vendor/ezsystems/ezplatform-i18n/ezplatform-admin-ui
cp ./vendor/ezsystems/ezpublish-kernel/eZ/Bundle/EzPublishCoreBundle/Resources/translations/*.xlf ./vendor/ezsystems/ezplatform-i18n/ezpublish-kernel
cp ./vendor/ezsystems/repository-forms/bundle/Resources/translations/*.xlf ./vendor/ezsystems/ezplatform-i18n/repository-forms

echo '# Fixing .xlf extensions'
rename -s '.xliff' '.xlf' vendor/ezsystems/ezplatform-i18n/ezplatform-admin-ui/*

if [ -d "./vendor/ezsystems/date-based-publisher" ]; then
  echo "Sync ezsystems/date-based-publisher"
  rm ./vendor/ezsystems/ezplatform-i18n/date-based-publisher/*.xlf
  cp ./vendor/ezsystems/date-based-publisher/bundle/Resources/translations/*.xlf ./vendor/ezsystems/ezplatform-i18n/date-based-publisher
fi

if [ -d "./vendor/ezsystems/flex-workflow" ]; then
  echo "Sync ezsystems/flex-workflow"
  rm ./vendor/ezsystems/ezplatform-i18n/flex-workflow/*.xlf
  cp ./vendor/ezsystems/flex-workflow/bundle/Resources/translations/*.xlf ./vendor/ezsystems/ezplatform-i18n/flex-workflow
fi

if [ -d "./vendor/ezsystems/ezplatform-page-builder" ]; then
  rm ./vendor/ezsystems/ezplatform-i18n/ezplatform-page-builder/*.xlf
  cp ./vendor/ezsystems/ezplatform-page-builder/src/bundle/Resources/translations/*.xlf ./vendor/ezsystems/ezplatform-i18n/ezplatform-page-builder
fi

if [ -d "./vendor/ezsystems/ezplatform-page-fieldtype" ]; then
  rm ./vendor/ezsystems/ezplatform-i18n/ezplatform-page-fieldtype/*.xlf
  cp ./vendor/ezsystems/ezplatform-page-fieldtype/src/bundle/Resources/translations/*.xlf ./vendor/ezsystems/ezplatform-i18n/ezplatform-page-fieltype
fi

echo '# Strip english locale suffix from filename';
rename 's/\.en\./\./g' ./vendor/ezsystems/ezplatform-i18n/*/*

echo 'Translation synchronization done !';
