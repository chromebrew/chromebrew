require 'package'

class Git < Package
  version '1.8.4'
  binary_url ({
    i686: 'https://dl.dropboxusercontent.com/s/g3binxopw5nfky1/git-1.8.4-chromeos-i686.tar.gz?token_hash=AAEWnMNBfozSIzLD1unbYGJzT4FGkEfJmLFQ-3uzydfT_A&dl=1'
  })
  binary_sha1 ({
    i686: '8c1bf4bcffb0e9c17bf20dd05981e86ea34d5d65'
  })

  depends_on 'zlib'
  depends_on 'libssh2'
  depends_on 'perl'
  depends_on 'openssl'
  depends_on 'curl'
  depends_on 'expat'
  depends_on 'gettext'
  depends_on 'python'
end
