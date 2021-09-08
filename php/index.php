<?php

require "Parsedown.php";

$Parsedown = new Parsedown();

$readmd = file_get_contents("README.md");

$readmd = str_replace("xml/","",$readmd);

echo $Parsedown->text($readmd);