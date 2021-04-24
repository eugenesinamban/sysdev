<?php
require_once __DIR__ . "/../vendor/autoload.php";

$loader = new \Twig\Loader\FilesystemLoader('/app/resources/views');
$twig = new \Twig\Environment($loader, [
    'debug' => true
]);