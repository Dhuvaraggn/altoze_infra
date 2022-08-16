<?php

//ContName:Port

$servername = "${url}";
//to get env values from docker file
$username = "${username}";
$password = "${password}";
$port = "3306";
$db = "altozedb";
echo "<h1>" . "Here is the list of Students with their id " . "</h1>";

try {
        $conn = new PDO("mysql:host=$servername;dbname=$db", $username, $password);
        $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        echo "Connected successfully";
      } catch(PDOException $e) {
        echo "Connection failed: " . $e->getMessage();
      }
$conn=new mysqli($servername,$username,$password,$db);
if($conn)
{
    echo ("Login  succesfully" . "<br><br><br>");
    
    $query="show tables from altozedb";
    $result=$conn->query($query);
    if($result->num_rows>0)
    {
            echo "<table><tr><th>Tables</th><</tr>";
            while($row=$result->fetch_assoc())
            {
                    echo "<tr><td>" . $row["Tables_in_altozedb"] . "</td></tr>" ;
            }
            echo "</table>";
    }
    else
    {
            echo "Table is empty";
    }
    $query="select name,age from altozedb.students";
    $result=$conn->query($query);
    if($result->num_rows>0)
{
        echo "<table><tr><th>ID</th><th>NAME</th></tr>";
        while($row=$result->fetch_assoc())
        {
                echo "<tr><td>" . $row["name"] . "</td><td>" . $row["age"] . "</td></tr>" ;
        }
        echo "</table>";
        echo ("connection sucessfull");
}

}
else
{
        echo "Table is empty";
}
?>
