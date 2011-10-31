Zimmer             Temperatur   Luftfeuchte
-------------------------------------------
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


function plain_line($datum) {
    echo str_pad($datum['name'], 18, ' ');
    echo ' ' . str_pad($datum['temperature'] . '°C', 13, ' ');
    echo ' ' . $datum['humidity'] . '%';
    echo "\n";
}
?>
