<?php
/**
 * @copyright Copyright (C) eZ Systems AS. All rights reserved.
 * @license For full copyright and license information view LICENSE file distributed with this source code.
 */

// analyzes changes from l10n_master against the current branch
// and outputs commands to checkout & commit each language separately

try {
    $translations = getLanguagesData();
} catch (Exception $e) {
    echo "An error occurred: " . $e->getMessage() . "\n";
    exit(1);
}

foreach (explode(PHP_EOL, `git diff ..l10n_master --name-only`) as $file)
{
    if (!preg_match('|translations/([a-z]{2,3}_[a-z]{2,3})/.*\.xlf|i', $file, $m)) {
        continue;
    }

    $directory = $m[1];

    if (!isset($translations[$directory])) {
        continue;
    }

    $translations[$directory]['files'][] = $file;
}

foreach ($translations as $directory => $data) {
    if (!isset($data['files'])) {
        printf(
            "No changes to %s (%d%% translated, %d%% approved)\n",
            $data['name'],
            $data['status']['translated_progress'],
            $data['status']['approved_progress']
        );
        continue;
    }

    printf(
        "git checkout l10n_master translations/%s/\n",
        $directory
    );
    printf(
        "git commit -m \"%s translation (%d%% translated, %d%% approved)\"\n",
        $data['name'],
        $data['status']['translated_progress'],
        $data['status']['approved_progress']
    );
}


function getLanguagesData()
{
    $languagesMap= [
        'de' => 'de_DE',
        'el' => 'el_GR',
        'es-ES' => 'es_ES',
        'fi' => 'fi_FI',
        'fr' => 'fr_FR',
        'hi' => 'hi_IN',
        'hu' => 'hu_HU',
        'ja' => 'ja_JP',
        'nb' => 'nb_NO',
        'pl' => 'pl_PL',
        'pt-PT' => 'pt_PT',
        'ru' => 'ru_RU',
    ];

    if (!$crowdinApiKey = getenv('CROWDIN_API_KEY')) {
        throw new InvalidArgumentException("Environment variable CROWDIN_API_KEY must be set for the ezplatform project");
    }

    $statuses = json_decode(
        file_get_contents(
            "https://api.crowdin.com/api/project/ezplatform/status?key=$crowdinApiKey&json"
        )
    );
    if ($statuses instanceof stdClass) {
        throw new Exception("Unexpected response from crowdin API");
    }

    $languagesData = [];

    foreach ($statuses as $status) {
        if (!isset($languagesMap[$status->code])) {
            throw new Exception("No mapping found for language code $status->code\n");
        }

        $directory = $languagesMap[$status->code];

        $languagesData[$directory] = [
            'name' => $status->name,
            'status' => (array)$status,
        ];
    }

    return $languagesData;
}
