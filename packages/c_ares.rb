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
    aarch64: '05983b6d59990fed22205a11394c7674eb9f757c46490238919158a505498c22',
     armv7l: '05983b6d59990fed22205a11394c7674eb9f757c46490238919158a505498c22',
       i686: 'd482232284da08305ccd177c21a280851f95b61c3e8ce4d769b60c3d92d6c78c',
     x86_64: '6dbb3a2793c6253a67a946af561c1a5cf8cf19bbd271ff4254ddbca747acb267'
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
