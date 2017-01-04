require 'package'

class Git < Package
  version '1.8.4'
  binary_url ({
    armv7l: 'https://dl.dropboxusercontent.com/s/lnz5hmjv48d14f2/git-1.8.4-chromeos-armv7l.tar.xz',
    i686: 'https://dl.dropboxusercontent.com/s/g3binxopw5nfky1/git-1.8.4-chromeos-i686.tar.gz?token_hash=AAEWnMNBfozSIzLD1unbYGJzT4FGkEfJmLFQ-3uzydfT_A&dl=1',
    x86_64: 'https://dl.dropboxusercontent.com/s/i7vs9wfk94tsrzt/git-1.8.4-chromeos-x86_64.tar.gz?token_hash=AAHyvjayN7THoxlryZaxQ2Ejm9xyD6bZCqXZM81hYRC8iQ&dl=1'
  })
  binary_sha1 ({
    armv7l: '084a3b9bb90c572e7c5b12aae485715f145053e5',
    i686: '8c1bf4bcffb0e9c17bf20dd05981e86ea34d5d65',
    x86_64: '067cb6c36616ac30999ab97e85f3dc0e9d1d57f4'
  })

  depends_on 'zlibpkg'
  depends_on 'libssh2'
  depends_on 'perl'
  depends_on 'curl'
  depends_on 'expat'
  depends_on 'gettext'
  depends_on 'python'
end
