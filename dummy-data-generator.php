#!/usr/bin/env php
<?php
/**
 * Generates dummy data as a usb-wde1 would generate
 */
$arChannels = array(0, 1, 2, 3, 4, 7);

$data = array(
    'channel'   => 1,
    'state'     => 1,
    'timestamp' => ''
);
foreach (array('t', 'h') as $type) {
    for ($n = 0; $n < 8; $n++) {
        $data[$type . $n] = '';
    }
}
$data = array_merge(
    $data,
    array(
        'tc' => '',
        'fc' => '',
        'wg' => '',
        'ns' => '',
        'rain' => '',
        'checksum' => 0
    )
);

$n = 0;
while (true) {
    foreach ($arChannels as $nChanNum) {
        $data['t' . $nChanNum] = str_replace('.', ',', rand(160, 260) / 10);
        $data['h' . $nChanNum] = rand(30, 80);
    }
    echo '$' . implode(';', $data) . "\r\n";
    sleep(1);
}

?>