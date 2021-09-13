<?php

require "Parsedown.php";

$Parsedown = new Parsedown();

$readmd = file_get_contents("README.md");

echo $Parsedown->text($readmd);