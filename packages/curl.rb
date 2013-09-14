require 'package'

class Curl < Package
  version '7.32.0'
  binary_url ({
    i686: 'https://dl.dropboxusercontent.com/s/vsk4jhryz4d042m/curl-7.32.0-chromeos-i686.tar?token_hash=AAG9UV1qCvX3AeGcNMLc-AQBCeQva0l5j_yzccolaQe0jA&dl=1'
  })
  binary_sha1 ({
    i686: '769d49e0f5ed952f7a5f464260d55d8e525bf6f6'
  })
end
