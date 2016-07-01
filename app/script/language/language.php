<?php
$languages = explode(',', $_SERVER['HTTP_ACCEPT_LANGUAGE']);
$languages = array_reverse($languages);
 
$result = '';
 
foreach ($languages as $language) {
  if (preg_match('/^en/i', $language)) {
    $result = 'English';
    header("Location: /english");
  } elseif (preg_match('/^ja/i', $language)) {
    $result = 'Japanese';
    header("Location: /");
  } 
}
if ($result == '') {
  $result = 'Japanese';
  header("Location: /");
}