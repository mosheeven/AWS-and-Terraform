#!/bin/bash
IP=$(curl http://169.254.169.254/latest/meta-data/public-ipv4)

cat << EOT
<!DOCTYPE html>
<html>
<head>
<title>Test</title>
<meta http-equiv="refresh" content="10" />
</head>
<body>
<h1>The public IP of the machine:</h1>
<h2>${IP}</h2>
</body>
</html>
</body>
</html>
EOT