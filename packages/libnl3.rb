require 'package'

class Libnl3 < Package
  description 'libnl is a library for applications dealing with netlink sockets.'
  homepage 'http://www.infradead.org/~tgr/libnl/'
  version '3.7.0'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/thom311/libnl.git'
  git_hashtag "libnl#{version.gsub('.', '_')}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libnl3/3.7.0_armv7l/libnl3-3.7.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libnl3/3.7.0_armv7l/libnl3-3.7.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libnl3/3.7.0_i686/libnl3-3.7.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libnl3/3.7.0_x86_64/libnl3-3.7.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '6eb8a20bc0ff41d8a61116f92eb6426e6f085ce219b2af19ab99ac3d6a9d745e',
     armv7l: '6eb8a20bc0ff41d8a61116f92eb6426e6f085ce219b2af19ab99ac3d6a9d745e',
       i686: '123e2b875eb3a25373ba275c79fdfacf877fa0871a522e456715049c3c0f142d',
     x86_64: 'de4409d700e3335d43d63acb1d50ff29e0827a28766075704ba54170d7858967'
  })

  depends_on 'glibc' # R

  def self.build
    system 'autoupdate'
    system './autogen.sh'
    system "./configure #{CREW_OPTIONS} \
              --enable-cli \
              --enable-pthreads \
              --disable-debug"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
