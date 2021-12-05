require 'package'

class C_ares < Package
  description 'c-ares is a C library for asynchronous DNS requests (including name resolves).'
  homepage 'https://c-ares.haxx.se/'
  version '1.18.1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/c-ares/c-ares.git'
  git_hashtag "cares-#{version.gsub('.', '_')}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/c_ares/1.18.1_armv7l/c_ares-1.18.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/c_ares/1.18.1_armv7l/c_ares-1.18.1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/c_ares/1.18.1_i686/c_ares-1.18.1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/c_ares/1.18.1_x86_64/c_ares-1.18.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '54077bfe2f8fbf4ea028c4b3917d39f3bc65397fd0b59d1ace6af28c15765102',
     armv7l: '54077bfe2f8fbf4ea028c4b3917d39f3bc65397fd0b59d1ace6af28c15765102',
       i686: '1533c2e1dcd9d88ba63786743498450b7e9ff7e04598a4f62a2852f10f628a18',
     x86_64: 'f13b09f5627f12c3333268391cf9b7f2648429ebbbd196c9bf707b5ba7a8cc08'
  })

  def self.build
    system 'autoreconf -fiv'
    system 'filefix'
    system "./configure #{CREW_OPTIONS} #{CREW_ENV_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
