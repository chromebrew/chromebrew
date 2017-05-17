require 'package'

class Python < Package
  version '3.3.2'
  binary_url ({
    armv7l: 'https://dl.dropboxusercontent.com/s/xsu18iggr51ewqh/python-3.3.2-chromeos-armv7l.tar.xz',
    i686: 'https://dl.dropboxusercontent.com/s/mxgfmq992hhiawk/python-3.3.2-chromeos-i686.tar.gz?token_hash=AAFA2YzFp293uyV3zYfP70iwCk8oH9HCLKMTrK0dtMU8GQ&dl=1',
    x86_64: 'https://dl.dropboxusercontent.com/s/r1zvmza51hrr87q/python-3.3.2-chromeos-x86_64.tar.gz?token_hash=AAHIdz6pWcOrfty7C8ACuRcLDq0d0ERYs0jCgOPLn5USUQ&dl=1'
  })
  binary_sha1 ({
    armv7l: 'b32ee2db9c14d7e2d1df6d43836312521a3ece91',
    i686: 'a985a4bba243b4fa701db302dc2fa554aef76f1c',
    x86_64: 'fbfe0946c2f9191bd6110705994d459e373a8b09'
  })
end
