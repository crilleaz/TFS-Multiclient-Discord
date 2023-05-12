<?php
// Set up database connection
$db_host = "localhost";
$db_user = "";
$db_pass = "";
$db_name = "";
$conn = mysqli_connect($db_host, $db_user, $db_pass, $db_name);

// Set up Discord webhook URL
$webhook_url = "https://discord.com/api/webhooks/";

// Get current time and time 60 seconds ago
$current_time = date("Y-m-d H:i:s");
$old_time = date("Y-m-d H:i:s", strtotime("-60 seconds"));

// Fetch new messages from database
$query = "SELECT * FROM mc_check WHERE mc_time >= '$old_time' AND mc_time <= '$current_time'";
$result = mysqli_query($conn, $query);

// Create Discord message content
$content = "";
while ($row = mysqli_fetch_assoc($result)) {
  $content .= '[' . $row['mc_time'] . '] ' . $row['mc_message'] . "\n";
}

// Send message to Discord webhook if there are new messages
if (!empty($content)) {
  $data = array("content" => $content);
  $options = array(
    "http" => array(
      "header"  => "Content-type: application/json",
      "method"  => "POST",
      "content" => json_encode($data)
    )
  );
  $context  = stream_context_create($options);
  $result = file_get_contents($webhook_url, false, $context);
} else {
  echo "There are no new messages at the moment.";
}

// Close database connection
mysqli_close($conn);

?>
