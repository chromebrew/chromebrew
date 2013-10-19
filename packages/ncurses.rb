require 'package'

class Ncurses < Package
  version '5.9-chromeos1'
  binary_url ({
    i686: 'https://dl.dropboxusercontent.com/s/aule5impm7ek644/ncurses-5.9-chromeos-i686.tar.gz?token_hash=AAH6Z34Dd17OeG_to_cD7z_1bc95AObrDrfU2mHGhZ-3bg&dl=1',
    x86_64: 'https://dl.dropboxusercontent.com/s/py8kz22dql0li8x/ncurses-5.9-chromeos1-chromeos-x86_64.tar.gz?token_hash=AAFMbTmK7iW16QidxzsQ7Y2CI96B33MpF9-9GBpqbOH4uw&dl=1'
  })
  binary_sha1 ({
    i686: 'a46463be1b8f7cd3af8309e49fd6bc60cf0e5341',
    x86_64: '691c4819c98a26da69136da04b57bed38aad775f'
  })
end
