<?php
/**
 * @copyright Copyright (C) eZ Systems AS. All rights reserved.
 * @license For full copyright and license information view LICENSE file distributed with this source code.
 */

// lists the files from the current branch that only change the timestamp
foreach (explode(PHP_EOL, `git diff master.. --stat --stat-width=100`) as $line)
{
    if (preg_match('/\s+([^\|]+)\s+\|\s+2\s/', $line, $m)) {
        echo "$m[1]\n";
    }
}
