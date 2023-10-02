<?php
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Retrieve data sent from the client
    $requestData = json_decode(file_get_contents("php://input"), true);

    // Validate and sanitize user input (you should perform more thorough validation)
    $employeeID = filter_var($requestData['employeeID'], FILTER_SANITIZE_STRING);
    $username = filter_var($requestData['username'], FILTER_SANITIZE_STRING);
    $role = filter_var($requestData['role'], FILTER_SANITIZE_STRING);
    console.log("hello")

    // Insert the user data into the database (you should use prepared statements to prevent SQL injection)
    $conn = new mysqli(DB_HOST, DB_USER, DB_PASS, DB_NAME);
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }

    $sql = "INSERT INTO users (employeeID, username, role) VALUES ('$employeeID', '$username', '$role')";
    if ($conn->query($sql) === TRUE) {
        $response = [
            'success' => true,
            'user' => $requestData
        ];
    } else {
        $response = [
            'success' => false,
            'message' => 'Error: ' . $conn->error
        ];
    }

    $conn->close();

    // Send the response back to the client
    header('Content-Type: application/json');
    echo json_encode($response);
} else {
    // Handle other HTTP methods if necessary
    http_response_code(405); // Method Not Allowed
    echo json_encode(['message' => 'Method not allowed']);
}
?>
