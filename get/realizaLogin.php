<?php

$host = "sql10.freemysqlhosting.net";
$username = "sql10550742";
$password = "iAVbBk1fSD";
$dbname = "sql10550742";

if($_SERVER['REQUEST_METHOD'] == 'GET'){
    
    $connection_string = mysqli_connect($host, $username, $password, $dbname)
    or die 
    ("Problema ao conecter-se ao servidor.");

    $nm_usuario = $_GET['nm_usuario'];
    $email_usuario = $_GET['email_usuario'];
    $senha_usuario = $_GET['senha_usuario'];

    if (!$connection_string) {
        echo "Não foi possível conectar ao banco MySQL."; 
        exit;
    } else {
        $cmd = "Select * from tbl_Usuario 
        where email_usuario = '$email_usuario' and senha_usuario = '$senha_usuario'";

        $result = mysqli_query($connection_string, $cmd); 
        $busca_por_email_e_senha = mysqli_num_rows($result);

        $cmd = "Select * from tbl_Usuario 
        where nome_usuario = '$nm_usuario' and senha_usuario = '$senha_usuario'";

        $result = mysqli_query($connection_string, $cmd); 
        $busca_por_nome_usuario_e_senha = mysqli_num_rows($result);

        if($busca_por_email_e_senha != 0 || $busca_por_nome_usuario_e_senha != 0) 
            echo "True";
        else
            echo "False";
    }

    mysqli_close($connection_string);
}

?>