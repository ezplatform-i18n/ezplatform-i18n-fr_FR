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
        'git commit -m "%s translation: %d%% translated (%s), %d%% approved (%s)"',
        $data['name'],
        $data['status']['translated_progress'],
        $data['progress_delta']['translated_progress'],
        $data['status']['approved_progress'],
        $data['progress_delta']['approved_progress']
    );
}

echo implode("\n", $commands );
echo "\n\nRun command (y/n)? ";
$answer = fgetc(STDIN);
if ($answer == 'y') {
    foreach ($commands as $command) {
        echo "$command\n";
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
        'nl' => 'nl_NL',
        'he' => 'he',
        'zh-HK' => 'zh_HK',
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
        $log = [];
        if (!isset($languagesMap[$status->code])) {
            echo "Warning: no mapping found for language code $status->code\n";
            continue;
        }

        $directory = $languagesMap[$status->code];

        $delta = ['translated_progress' => '', 'approved_progress' => ''];

        $command = "git log --grep=\"^{$status->name} translation:\" --format=%s";
        exec($command, $log, $return);
        foreach ($log as $logLine) {
            if (strstr($logLine, "$status->name translation") === false) {
                continue;
            }

            if (preg_match("/([0-9]{1,3})% translated/", $logLine, $m)) {
                $delta['translated_progress'] = (int)$status->translated_progress - $m[1];
                if ($delta['translated_progress'] >= 0) {
                    $delta['translated_progress'] = '+' . $delta['translated_progress'];
                }
                if (preg_match("/([0-9]{1,3})% approved/", $logLine, $m)) {
                    $delta['approved_progress'] = (int)$status->approved_progress - $m[1];
                    if ($delta['approved_progress'] >= 0) {
                        $delta['approved_progress'] = '+' . $delta['approved_progress'];
                    }
                }
                break;
            }
        }

        $languagesData[$directory] = [
            'name' => $status->name,
            'status' => (array)$status,
            'progress_delta' => $delta,
        ];
    }

    return $languagesData;
}
