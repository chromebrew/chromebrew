require 'package'

class Libssh2 < Package
  version '1.4.3'
  binary_url ({
    armv7l: 'https://dl.dropboxusercontent.com/s/fq23kj42gsifcvi/libssh2-1.4.3-chromeos-armv7l.tar.xz',
    i686: 'https://dl.dropboxusercontent.com/s/zjnild1c2i10h53/libssh2-1.4.3-chromeos-i686.tar.gz?token_hash=AAG_aZ7_dPKOiOMCMUiW2g3mLkz8UKHnGn5jLcDAGcNCIA&dl=1',
    x86_64: 'https://dl.dropboxusercontent.com/s/frzkbbnf35ie6ns/libssh2-1.4.3-chromeos-x86_64.tar.gz?token_hash=AAEk26mEOXT0MX05nM9gG6yNDPkL6KmLazRxKqQCR6qs8Q&dl=1'
  })
  binary_sha1 ({
    armv7l: '559f37b727f181ad0b623dba352a9efd0facf51a',
    i686: '21b4b1a9608b12c0b3d1e6f0b6615f4a4152acb3',
    x86_64: '903aae8255c47c6052003837be132ff39582422b'
  })
end
