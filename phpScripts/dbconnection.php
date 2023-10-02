// <?php
//
// define("DB_HOST", "localhost");
// define("DB_NAME", "GTLM");
// define("DB_USER", "dbadmin");
// define("DB_PASS", "");
//
// $conn = @mysqli_connect(DB_HOST, DB_USER, DB_PASS, DB_NAME);
// if (!$conn) {
//     // Something went wrong...
//     echo "Error: Unable to connect to database.<br>";
//     echo "Debugging errno: " . mysqli_connect_errno() . "<br>";
//     echo "Debugging error: " . mysqli_connect_error() . "<br>";
//     exit;
// }

// ============================
<?php
define("DB_HOST", "localhost");
define("DB_USER", "dbadmin"); // Your MySQL username
define("DB_PASS", ""); // Your MySQL password

$conn = @mysqli_connect(DB_HOST, DB_USER, DB_PASS);

if (!$conn) {
    // Something went wrong with the initial connection...
    echo "Error: Unable to connect to MySQL server.<br>";
    echo "Debugging errno: " . mysqli_connect_errno() . "<br>";
    echo "Debugging error: " . mysqli_connect_error() . "<br>";
    exit;
}

// Check if the database exists, and if not, create it
$db_name = "GTLM"; // Your database name

if (!mysqli_select_db($conn, $db_name)) {
    // The database doesn't exist, so create it
    $create_db_query = "CREATE DATABASE $db_name";

    if (mysqli_query($conn, $create_db_query)) {
        echo "Database created successfully.<br>";
    } else {
        echo "Error creating database: " . mysqli_error($conn) . "<br>";
        exit;
    }

    // After creating the database, select it
    mysqli_select_db($conn, $db_name);
}
