<?php

$host = "sql10.freemysqlhosting.net";
$username = "sql10550742";
$password = "iAVbBk1fSD";
$dbname = "sql10550742";

if($_SERVER['REQUEST_METHOD'] == 'GET'){
    
    $connection_string = mysqli_connect($host, $username, $password, $dbname)
    or die 
    ("Problema ao conecter-se ao servidor.");

    $email_usuario = $_GET['email_usuario'];

    if (!$connection_string) {
        echo "Não foi possível conectar ao banco MySQL."; 
        echo '<br>';
        exit;
    } else {
        echo "Parabéns!! A conexão ao banco de dados ocorreu normalmente!";
        echo '<br>';

        $cmd = "select * from  tbl_usuario where email_usuario = '$email_usuario'";
        $result = mysqli_query($connection_string, $cmd); 
        $rows = mysqli_num_rows($result);
        echo $rows;

    }

    mysqli_close($connection_string);
}

?>