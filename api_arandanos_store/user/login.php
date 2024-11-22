<?php
include '../connection.php';

$userEmail = $_POST["user_email"];
$userPassword = $_POST["user_password"];

// Preparar la consulta para evitar inyección SQL
$sqlQuery = "SELECT * FROM users_tabla WHERE user_email = ?";
$stmt = mysqli_prepare($connectNow, $sqlQuery);

mysqli_stmt_bind_param($stmt, "s", $userEmail);
mysqli_stmt_execute($stmt);

$resultOfQuery = mysqli_stmt_get_result($stmt);

if ($resultOfQuery) {
    if (mysqli_num_rows($resultOfQuery) > 0) {
        $userRecord = mysqli_fetch_assoc($resultOfQuery);

        // Verificar la contraseña usando password_verify
        if (password_verify($userPassword, $userRecord['user_password'])) {
            // Limitar los datos que se devuelven en la respuesta
            $responseData = array(
                "user_id" => $userRecord['user_id'], 
                "user_email" => $userRecord['user_email'],
                "user_name" => $userRecord['user_name']
                // Agrega otros campos no sensibles según sea necesario
            );

            echo json_encode(array("success" => true, "userData" => $responseData));
        } else {
            echo json_encode(array("success" => false, "message" => "Credenciales incorrectas."));
        }
    } else {
        echo json_encode(array("success" => false, "message" => "No se encontró el usuario."));
    }
} else {
    echo json_encode(array("success" => false, "message" => "Error en la consulta SQL: " . mysqli_error($connectNow)));
}

mysqli_stmt_close($stmt);
mysqli_close($connectNow);
?>
