require 'package'

class Python < Package
  version '3.3.2'
  binary_url ({
    i686: 'https://dl.dropboxusercontent.com/s/mxgfmq992hhiawk/python-3.3.2-chromeos-i686.tar.gz?token_hash=AAFA2YzFp293uyV3zYfP70iwCk8oH9HCLKMTrK0dtMU8GQ&dl=1'
  })
  binary_sha1 ({
    i686: 'a985a4bba243b4fa701db302dc2fa554aef76f1c'
  })
end
