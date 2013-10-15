require 'package'

class Ncurses < Package
  version '5.9'
  binary_url ({
    i686: 'https://dl.dropboxusercontent.com/s/aule5impm7ek644/ncurses-5.9-chromeos-i686.tar.gz?token_hash=AAH6Z34Dd17OeG_to_cD7z_1bc95AObrDrfU2mHGhZ-3bg&dl=1',
    x86_64: 'https://dl.dropboxusercontent.com/s/7rrssd43c36eee4/ncurses-5.9-chromeos-x86_64.tar.gz?token_hash=AAG-S3Uyp_JBz7nxT8Yll0t5tLrq6bEgqgjej4thyTuCPg&dl=1'
  })
  binary_sha1 ({
    i686: 'a46463be1b8f7cd3af8309e49fd6bc60cf0e5341',
    x86_64: '763f48c42ac9b447e93ccba3eba8beaad34999dc'
  })
end
