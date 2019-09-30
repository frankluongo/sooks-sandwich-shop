# This automatically reads the REDIS_URL from the environment
$redis ||= Redis.new
