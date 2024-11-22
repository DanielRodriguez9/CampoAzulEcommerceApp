<?php

include '../connection.php';

$userEmail = $_POST['user_email'];

// Corregir aquí: eliminar el símbolo extra de $
$sqlQuery = "SELECT * FROM users_tabla WHERE user_email = '$userEmail'";

$resultOfQuery = $connectNow->query($sqlQuery);

if ($resultOfQuery->num_rows > 0) {
    echo json_encode(array("emailFound" => true)); // 'emailFound' es el nombre de la clave
} else {
    echo json_encode(array("emailFound" => false));
}
