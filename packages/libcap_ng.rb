require 'package'

class Libcap_ng < Package
  description 'The libcap-ng library is intended to make programming with posix capabilities much easier than the traditional libcap library.'
  homepage 'https://people.redhat.com/sgrubb/libcap-ng'
  version '0.8.2'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/stevegrubb/libcap-ng.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcap_ng/0.8.2_armv7l/libcap_ng-0.8.2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcap_ng/0.8.2_armv7l/libcap_ng-0.8.2-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcap_ng/0.8.2_i686/libcap_ng-0.8.2-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcap_ng/0.8.2_x86_64/libcap_ng-0.8.2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'e2c3b3d0e89bb490b92901d5a290b05a2467a0927cfbd60ef69e9b42816a8e91',
     armv7l: 'e2c3b3d0e89bb490b92901d5a290b05a2467a0927cfbd60ef69e9b42816a8e91',
       i686: 'c880cf4e563f949d8516242a63dd75a712c81387ffca8d69ef1f38160df0cd55',
     x86_64: 'ed2882b6cfa3146c27ddf479bfd3f1f97941012802936b9ed5b1d894ee8ff9f1'
  })

  depends_on 'python3'

  def self.build
    system './autogen.sh'
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.check
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
