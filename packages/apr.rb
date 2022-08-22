require 'package'

class Apr < Package
  description 'The mission of the Apache Portable Runtime (APR) project is to create and maintain software libraries that provide a predictable and consistent interface to underlying platform-specific implementations.  APR is the base portability library.'
  homepage 'https://apr.apache.org/'
  version '1.7.0-1'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://apache.claz.org/apr/apr-1.7.0.tar.bz2'
  source_sha256 'e2e148f0b2e99b8e5c6caa09f6d4fb4dd3e83f744aa72a952f94f5a14436f7ea'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/apr/1.7.0-1_armv7l/apr-1.7.0-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/apr/1.7.0-1_armv7l/apr-1.7.0-1-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/apr/1.7.0-1_i686/apr-1.7.0-1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/apr/1.7.0-1_x86_64/apr-1.7.0-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'a57bb1fa211ba38061bb9d6498fd567559d80362591845687945318e9f657f4d',
     armv7l: 'a57bb1fa211ba38061bb9d6498fd567559d80362591845687945318e9f657f4d',
       i686: '0c69672d2390520bb3e1259da5842a86abb8d0fef7ffa111f2c8b8ed7500b61c',
     x86_64: '074000aa69a400375f08d9c947bff250995a4b59a28e48952738d19efe97f9e6'
  })

  def self.build
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS} \
            --disable-maintainer-mode \
            --with-devrandom \
            --without-sendfile"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    FileUtils.rm_rf "#{CREW_DEST_PREFIX}/build-1" # Seems residual from build and isn't needed
  end
end
