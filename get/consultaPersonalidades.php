<?php

header("Access-Control-Allow-Origin: *");

$host = "sql10.freemysqlhosting.net";
$username = "sql10580979";
$password = "nGL9h6etHc";
$dbname = "sql10580979";

if($_SERVER['REQUEST_METHOD'] == 'GET'){
    
    $connection_string = mysqli_connect($host, $username, $password, $dbname)
    or die 
    ("Problema ao conecter-se ao servidor.");

    $response = [];
    $dadosPersonalidades = [];

    if (!$connection_string) {
        $response = [
            'databaseConnection' => 'False',
        ];
        
        echo json_encode($response, JSON_PRETTY_PRINT);
    } else {
        $cmd = "Select * from vw_consultaPersonalidades";
        $result = mysqli_query($connection_string, $cmd); 
        $busca_por_personalidades = mysqli_num_rows($result);

        if($busca_por_personalidades != 0) {
            $stmt = $connection_string->prepare($cmd);
            $stmt->execute();
            $stmt->bind_result($cd_personalidade, $nm_personalidade, 
            $sigla_personalidade, $cd_categoria, $nm_categoria_personalidade);

            while($stmt->fetch())
            {
                $temp = [
                    'cd_personalidade' => $cd_personalidade,
                    'nm_personalidade' => $nm_personalidade,
                    'sigla_personalidade' => $sigla_personalidade,
                    'cd_categoria' => $cd_categoria,
                    'nm_categoria_personalidade' => $nm_categoria_personalidade,
                ];

                array_push($dadosPersonalidades, $temp);
            }
            
            $teste = '[';
            foreach ($dadosPersonalidades as $index=>$dadosPersonalidade) {
                $teste .= '{"cd_personalidade": "'. 
                $dadosPersonalidade['cd_personalidade'] . '", '.
                '"nm_personalidade": "'. 
                $dadosPersonalidade['nm_personalidade'] . '", '.
                '"sigla_personalidade": "'. 
                $dadosPersonalidade['sigla_personalidade'] . '", ' .
                '"cd_categoria": "'. 
                $dadosPersonalidade['cd_categoria'] . '", ' .
                '"nm_categoria_personalidade": "'. 
                $dadosPersonalidade['nm_categoria_personalidade'] . '"' ;
                if($index < (sizeof($dadosPersonalidades)-1))
                    $teste .= "},";
                else
                    $teste .= "}]";
            }

            echo $teste;
            
        } else {
            $response = [
                'response' => 'False',
            ];
            
            echo json_encode($response, JSON_PRETTY_PRINT);
        }
        
    }

    mysqli_close($connection_string);
}

?>