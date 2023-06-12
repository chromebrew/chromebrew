require 'package'

class Libmpc < Package
  description 'Musepack is an audio compression format with a strong emphasis on high quality.'
  homepage 'https://www.musepack.net/'
  version 'r495'
  compatibility 'all'
  license 'BSD and LGPL-2+'
  source_url 'https://salsa.debian.org/multimedia-team/libmpc.git'
  git_hashtag "debian/2%0.1_#{version}-2"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libmpc/r495_armv7l/libmpc-r495-chromeos-armv7l.tpxz',
      armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libmpc/r495_armv7l/libmpc-r495-chromeos-armv7l.tpxz',
        i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libmpc/r495_i686/libmpc-r495-chromeos-i686.tpxz',
      x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libmpc/r495_x86_64/libmpc-r495-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '2aff1d1f93af9d47cebdf0e36a2172487301cb70b0be2aab5217d5e739306fdc',
      armv7l: '2aff1d1f93af9d47cebdf0e36a2172487301cb70b0be2aab5217d5e739306fdc',
        i686: '8133a1aae30798c0654e8f864a2ebbdf11f014f309257a031ee0eccb25c904bc',
      x86_64: '6bcfe955860efa5da35ee05346e092978b3b15144d2b8169f89fbe7f9df4c11a'
  })

  depends_on 'libcue'

  def self.patch
    system "for i in debian/patches/*.patch ; do patch -Np1 -i \${i}; done"
  end

  def self.build
    system 'autoreconf -fiv'
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
