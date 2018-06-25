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

exec('git diff ..l10n_master --name-only 2>&1', $diff, $return);
if ($return !== 0) {
    echo "An error occured when running git diff against l10n_master:\n\n";
    echo implode("\n", $diff);
    exit(1);

}

foreach ($diff as $file)
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

$commands = [];
foreach ($translations as $directory => $data) {
    $commands[] = sprintf("# %s", $data['name']);

    if (!isset($data['files'])) {
        $commands[] = sprintf(
            '# No changes (%d%% translated, %d%% approved)',
            $data['status']['translated_progress'],
            $data['status']['approved_progress']
        );
        continue;
    }

    $commands[] = sprintf(
        'git checkout l10n_master translations/%s/',
        $directory
    );
    $commands[] = sprintf(
        'git commit -m "%s translation: %d%% translated (+%d), %d%% approved (+%d)"',
        $data['name'],
        $data['status']['translated_progress'],
        $data['status']['approved_progress'],
        $data['previous']['translated_progress'],
        $data['previous']['approved_progress']
    );
}

echo implode("\n", $commands );
echo "\n\nRun command (y/n)? ";
$answer = fgetc(STDIN);
if ($answer == 'y') {
    foreach ($commands as $command) {
        echo $command;
        system($command);
    }
}

echo "\n\n";

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
        'en-US' => 'en_US',
        'it' => 'it_IT',
        'hr' => 'hr_HR',
        'nl' => 'nl',
        'he' => 'he'
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

        $previousStatus = ['translated_progress' => 0, 'approved_progress' => 0];
        exec("git log --format=%s translations/$directory", $log);
        foreach ($log as $logLine) {
            if (preg_match("/([0-9]{1,3})% translated/", $logLine, $m)) {
                $previousStatus['translated_progress'] = $m[1];
                if (preg_match("/([0-9]{1,3})% approved/", $logLine, $m)) {
                    $previousStatus['approved_progress'] = $m[1];
                }
                break;
            }
        }

        $languagesData[$directory] = [
            'name' => $status->name,
            'status' => (array)$status,
            'previous' => $previousStatus,
        ];
    }

    return $languagesData;
}
