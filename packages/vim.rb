require 'package'

class Vim < Package
  version '7.3'
  binary_url ({
    i686: 'https://dl.dropboxusercontent.com/s/s6ya4cyeee7ywo9/vim-7.3-chromeos-i686.tar.gz?token_hash=AAEI_tXjoKfOGEWKN3fajxskcCxlOjxuANGIvu-nSABANQ&dl=1'
  })
  binary_sha1 ({
    i686: '5ff6cf19c34582027092d342fc835b0f32c63be0'
  })

  depends_on 'ncurses'
end
