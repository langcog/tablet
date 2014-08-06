<?php
	$result_string = $_POST['postresult_string'];
	file_put_contents('tabletstudyresults.csv', $result_string, FILE_APPEND);
?>