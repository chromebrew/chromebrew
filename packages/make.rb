require 'package'

class Make < Package
  version '3.82'
  binary_url ({
    i686: "https://dl.dropboxusercontent.com/s/f6pg4bkg6m3vn7q/make-3.82-chromeos-i686.tar.gz?token_hash=AAHP__I3leN8BCLdP0pLbkNopoFGGhDuKX0sN-I6Zx4JYg&dl=1"
    x86_64: "https://dl.dropboxusercontent.com/s/t818zxgixti6wvl/make-3.82-chromeos-x86_64.tar.gz?token_hash=AAGLBxpwv2mZj7dAgnzdmfFcO8G28wbCfb0lPM8_qwRtSA&dl=1"
  })
  binary_sha1 ({
    i686: "ccb01c7358e5abdf8b06305eb31b1969b8b174f7"
    x86_64: "2bab91837440d101eb55129f41a7837101249b46"
  })
end
