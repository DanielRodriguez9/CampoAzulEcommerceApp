<?php

include '../connection.php';

// Verificamos que los datos sean enviados a través de POST

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $userName = $_POST['user_name'] ?? '';
    $userEmail = $_POST['user_email'] ?? '';
    $userPassword = $_POST['user_password'] ?? '';

    // Validamos que los campos no estén vacíos
    if (!empty($userName) && !empty($userEmail) && !empty($userPassword)) {
        // Usar password_hash en lugar de md5
        $hashedPassword = password_hash($userPassword, PASSWORD_BCRYPT);  // ESTO ES PARA ENCRIPTAR LA CONTRASEÑA Y ESTE SEGURA

        // Usar consultas preparadas para evitar inyecciones SQL
        $sqlQuery = $connectNow->prepare("INSERT INTO users_tabla (user_name, user_email, user_password) VALUES (?, ?, ?)");
        $sqlQuery->bind_param("sss", $userName, $userEmail, $hashedPassword);

        // Ejecutamos la consulta y verificamos el resultado
        if ($sqlQuery->execute()) {
            echo json_encode(array("success" => true));
        } else {
            echo json_encode(array("success" => false, "error" => $sqlQuery->error));
        }

        // Cerramos la consulta
        $sqlQuery->close();
    } else {
        echo json_encode(array("success" => false, "error" => "Faltan campos obligatorios"));
    }
} else {
    echo json_encode(array("success" => false, "error" => "Método no permitido"));
}
?>


