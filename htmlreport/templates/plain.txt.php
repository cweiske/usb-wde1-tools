<?php echo pack("CCC", 0xef, 0xbb, 0xbf); ?>
Zimmer           Temperatur Luftfeuchte
---------------------------------------
<?php
plain_line($data[3]);
echo "\n";
plain_line($data[1]);
plain_line($data[5]);
plain_line($data[2]);
echo "\n";
plain_line($data[6]);
plain_line($data[0]);
plain_line($data[4]);
echo "\n";
echo date('c') . "\n";


function plain_line($datum) {
    echo str_pad($datum['name'], 18, ' ');
    echo ' ' . str_pad($datum['temperature'] . '°C', 9, ' ', STR_PAD_LEFT);
    echo ' ' . str_pad($datum['humidity'] . '%', 11, ' ', STR_PAD_LEFT);
    echo "\n";
}
?>
