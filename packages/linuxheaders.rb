require 'package'

class Linuxheaders < Package
  version '3.4.0'
  binary_url ({
    i686: "https://dl.dropboxusercontent.com/s/mdzdoyq7dtnz682/linux-headers-3.4.0-chromeos-i686.tar.gz?token_hash=AAE4yw5oH_SfZ3lAx02mFP603rnjmoB9Gp4vqTY14NsA-A&dl=1"
  })
  binary_sha1 ({
    i686: "31c933f3a4e82fd9310b0f5b32d79c9a51514fee"
  })
end
