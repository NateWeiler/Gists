<?php

/**
 * Light HTML5 Media Player class file
 *
 * @license    GPL 2 (http://www.gnu.org/licenses/gpl.html)
 * @author     Sébastien Lucas <sebastien@slucas.fr> heavily based on http://www.pixelstech.net/article/1357732373-Output-a-file-with-HTTP-range-header-in-PHP
 */

define ("BASE_PATH", "c:/Partage/MusiqueTag/");
$filename=rawurldecode($_GET['filename']);
$location=utf8_decode(BASE_PATH.$filename);

$extension = substr(strrchr($filename,'.'),1);
if ($extension == "mp3") {
  $mimeType = "audio/mpeg";
} else if ($extension == "ogg") {
  $mimeType = "audio/ogg";
}
if (!file_exists($location))
{
  header ("HTTP/1.1 404 Not Found");
  return;
}

$size  = filesize($location);
$time  = date('r', filemtime($location));

$fm = @fopen($location, 'rb');
if (!$fm)
{
  header ("HTTP/1.1 505 Internal server error");
  return;
}

$begin  = 0;
$end  = $size - 1;

if (isset($_SERVER['HTTP_RANGE']))
{
  if (preg_match('/bytes=\h*(\d+)-(\d*)[\D.*]?/i', $_SERVER['HTTP_RANGE'], $matches))
  {
    $begin  = intval($matches[1]);
    if (!empty($matches[2]))
    {
      $end  = intval($matches[2]);
  }
}
}
if (isset($_SERVER['HTTP_RANGE']))
{
  header('HTTP/1.1 206 Partial Content');
}
else
{
  header('HTTP/1.1 200 OK');
}

header("Content-Type: $mimeType");
header('Cache-Control: public, must-revalidate, max-age=0');
header('Pragma: no-cache');
header('Accept-Ranges: bytes');
header('Content-Length:' . (($end - $begin) + 1));
if (isset($_SERVER['HTTP_RANGE']))
{

  header("Content-Range: bytes $begin-$end/$size");
}
header("Content-Disposition: inline; filename=$filename");
header("Content-Transfer-Encoding: binary");
header("Last-Modified: $time");

$cur  = $begin;
fseek($fm, $begin, 0);

while(!feof($fm) && $cur <= $end && (connection_status() == 0))
{
  print fread($fm, min(1024 * 16, ($end - $cur) + 1));
  $cur += 1024 * 16;
}
