<?php
/**
 * Light HTML5 Media Player class file
 *
 * @license    GPL 2 (http://www.gnu.org/licenses/gpl.html)
 * @author     Sébastien Lucas <sebastien@slucas.fr>
 */

define ("BASE_PATH", "c:/Partage/MusiqueTag/");

$path = $_POST ["path"];

$entries = array ();

if ($handle = opendir(BASE_PATH . $path)) {
    while (false !== ($entry = readdir($handle))) {
        if ($entry != "." && $entry != "..") {
            $entries [] = array ("path" => utf8_encode($entry), "isDir" => is_dir (BASE_PATH . $path . "/" . $entry));
        }
    }
    closedir($handle);
}

header ("Content-Type:application/json;charset=utf-8");

echo json_encode($entries);