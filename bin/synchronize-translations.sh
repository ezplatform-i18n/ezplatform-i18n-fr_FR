#!/usr/bin/env sh
# Synchronize translation sources from all packages to ezplatform-i18n
echo '# Translation synchronization';


echo '# Mirror the translation files';

echo "ezsystems/ezplatform-admin-ui"
rm -f ./vendor/ezsystems/ezplatform-i18n/ezplatform-admin-ui/*
cp ./vendor/ezsystems/ezplatform-admin-ui/src/bundle/Resources/translations/* ./vendor/ezsystems/ezplatform-i18n/ezplatform-admin-ui

echo "ezsystems/ezplatform-admin-ui-modules"
rm -f ./vendor/ezsystems/ezplatform-i18n/ezplatform-admin-ui-modules/*
cp ./vendor/ezsystems/ezplatform-admin-ui-modules/Resources/translations/* ./vendor/ezsystems/ezplatform-i18n/ezplatform-admin-ui-modules

echo "ezsystems/ezpublish-kernel"
rm -f ./vendor/ezsystems/ezplatform-i18n/ezpublish-kernel/*
cp ./vendor/ezsystems/ezpublish-kernel/eZ/Bundle/EzPublishCoreBundle/Resources/translations/* ./vendor/ezsystems/ezplatform-i18n/ezpublish-kernel

echo "ezsystems/repository-forms"
rm -f ./vendor/ezsystems/ezplatform-i18n/repository-forms/*
cp ./vendor/ezsystems/repository-forms/bundle/Resources/translations/* ./vendor/ezsystems/ezplatform-i18n/repository-forms

echo "ezsystems/ez-support-tools"
rm -f ./vendor/ezsystems/ezplatform-i18n/ez-support-tools/*
cp ./vendor/ezsystems/ez-support-tools/Resources/translations/* ./vendor/ezsystems/ezplatform-i18n/ez-support-tools

echo "ezsystems/ezplatform-user"
rm -f ./vendor/ezsystems/ezplatform-i18n/ezplatform-user/*
cp ./vendor/ezsystems/ezplatform-user/src/bundle/Resources/translations/* ./vendor/ezsystems/ezplatform-i18n/ezplatform-user

echo "ezsystems/ezplatform-matrix-fieldtype"
rm -f ./vendor/ezsystems/ezplatform-i18n/ezplatform-matrix-fieldtype/*
cp ./vendor/ezsystems/ezplatform-matrix-fieldtype/src/bundle/Resources/translations/* ./vendor/ezsystems/ezplatform-i18n/ezplatform-matrix-fieldtype

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

if [ -d "./vendor/ezsystems/ezplatform-form-builder" ]; then
  echo "ezsystems/ezplatform-form-builder"
  rm -f ./vendor/ezsystems/ezplatform-i18n/ezplatform-form-builder/*
  cp ./vendor/ezsystems/ezplatform-form-builder/src/bundle/Resources/translations/* ./vendor/ezsystems/ezplatform-i18n/ezplatform-form-builder
fi

if [ -d "./vendor/ezsystems/ezplatform-workflow" ]; then
  echo "ezsystems/ezplatform-workflow"
  rm -f ./vendor/ezsystems/ezplatform-i18n/ezplatform-workflow/*
  cp ./vendor/ezsystems/ezplatform-workflow/src/bundle/Resources/translations/* ./vendor/ezsystems/ezplatform-i18n/ezplatform-workflow
fi

if [ -d "./vendor/ezsystems/ezplatform-richtext" ]; then
  echo "ezsystems/ezplatform-richtext"
  rm -f ./vendor/ezsystems/ezplatform-i18n/ezplatform-richtext/*
  cp ./vendor/ezsystems/ezplatform-richtext/src/bundle/Resources/translations/* ./vendor/ezsystems/ezplatform-i18n/ezplatform-richtext
fi

echo '# Fixing .xlf extensions'
rename -s '.xliff' '.xlf' vendor/ezsystems/ezplatform-i18n/*/*

echo '# Strip english locale suffix from filename';
rename -s '.en' '' ./vendor/ezsystems/ezplatform-i18n/*/*

echo 'Translation synchronization done !';
