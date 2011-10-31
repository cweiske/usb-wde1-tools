<?php
$cfgfile = __DIR__ . '/config.php';
if (!file_exists($cfgfile)) {
    echo "Copy config.php.dist to config.php and adjust it\n";
    exit(1);
}
require $cfgfile;

$data = array();
foreach ($names as $id => $name) {
    $data[$id]['name'] = $name;
    foreach (array('humidity', 'temperature') as $item) {
        $lu = rrd_lastupdate(
            str_replace(
                array('{item}', '{id}'),
                array($item, $id),
                $filetemplate
            )
        );
        if ($lu === false) {
            throw new Exception(rrd_error());
        }
                      
        $data[$id][$item] = reset($lu['data']);
    }
}

foreach (glob(__DIR__ . '/templates/*.php') as $tplfile) {
    $outfile = $outdir . basename($tplfile, '.php');
    ob_start();
    include $tplfile;
    $content = ob_get_contents();
    ob_end_clean();
    file_put_contents($outfile, $content);
}
?>