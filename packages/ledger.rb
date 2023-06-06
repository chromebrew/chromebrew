require 'package'

class Ledger < Package
  description 'A double-entry accounting system with a command-line reporting interface'
  homepage 'https://www.ledger-cli.org/'
  version '3.3.0'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/ledger/ledger.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ledger/3.3.0_armv7l/ledger-3.3.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ledger/3.3.0_armv7l/ledger-3.3.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ledger/3.3.0_i686/ledger-3.3.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ledger/3.3.0_x86_64/ledger-3.3.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '67bd73dd59b25960bc1bf25259929e2bb9606b07a2547e79eca476cf2a03cfad',
     armv7l: '67bd73dd59b25960bc1bf25259929e2bb9606b07a2547e79eca476cf2a03cfad',
       i686: '480dec57ad7f8165c6295d8a72e5984858e83bd521862ae8e72fd7ca479ebc19',
     x86_64: 'bc7a46b64598dcafa85adafcb2377581aeb5f9c44a65f04ec6614aa0dd4f967e'
  })

  depends_on 'boost' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'gmp' # R
  depends_on 'libedit' # R
  depends_on 'mpfr' # R

  def self.build
    system "cmake -B builddir #{CREW_CMAKE_OPTIONS} \
            -G Ninja"
    system 'samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
