require './lib/package'

class Make < Package
  version '3.82'
  binary_url ({
    i686: "https://dl.dropboxusercontent.com/s/f6pg4bkg6m3vn7q/make-3.82-chromeos-i686.tar.gz?token_hash=AAHP__I3leN8BCLdP0pLbkNopoFGGhDuKX0sN-I6Zx4JYg&dl=1"
  })
  binary_sha1 ({
    i686: "86321098f3f31daa49abb1bb38045dffb1f168b4"
  })
end
