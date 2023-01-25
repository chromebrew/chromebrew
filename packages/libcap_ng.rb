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
    aarch64: '340c58b5a3d0225fd783c27ef82544640add2dd0f268a58185fb76b938226a48',
     armv7l: '340c58b5a3d0225fd783c27ef82544640add2dd0f268a58185fb76b938226a48',
       i686: '9bc669a2810c2b52faacb62f090d0291393782dba241f0b05bf96cfacfd8acde',
     x86_64: '4b8cba2423a776d025e888dfd0e42ad9b9ce9402576271529fc89b5abb33a193'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :build

  def self.patch
    system "sed -i 's,/usr/bin,#{CREW_PREFIX}/bin,g' utils/captest.c"
  end

  def self.build
    system './autogen.sh'
    system 'filefix'
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
