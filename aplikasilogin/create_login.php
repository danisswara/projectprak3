<?php
    include 'koneksi.php';

    $email = $_POST['email'];
    $email = $_POST['username'];
    $email = $_POST['password'];
    $email = $_POST['role'];


    if(!$email || !$username || !$password || !$role) {
    echo json_encode(array('message' => 'required field is empty'));

    } else {
    $query = mysqli_query($con, "INSERT INTO tb_log VALUES ('', '$email', '$username', md5'$password'), '$role' )");

        if ($query) {
        echo json_encode(array('message' => 'login data succesfull y added'));
        }else {
        echo json_encode(array('message' => 'login data failed to add'));
        }
    }
?>