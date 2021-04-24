<?php
require_once __DIR__ . "/bootstrap.php";

$viewVars = [
    'name' => 'Eugene',
    'skills' => ['JavaScript', 'PHP', 'Ruby'],
];

echo $twig->render('layouts/app.twig.html', $viewVars);