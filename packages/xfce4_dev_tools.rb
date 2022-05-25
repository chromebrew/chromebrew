require 'package'

class Xfce4_dev_tools < Package
  description 'Xfce4 development tools'
  homepage 'https://xfce.org/'
  version '4.17.0'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://archive.xfce.org/src/xfce/xfce4-dev-tools/4.17/xfce4-dev-tools-4.17.0.tar.bz2'
  source_sha256 'd334c1f10e140e666b86c6c3bd8dcd62f1a877f537bcacc974478b6e92c493c7'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xfce4_dev_tools/4.17.0_armv7l/xfce4_dev_tools-4.17.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xfce4_dev_tools/4.17.0_armv7l/xfce4_dev_tools-4.17.0-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xfce4_dev_tools/4.17.0_i686/xfce4_dev_tools-4.17.0-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xfce4_dev_tools/4.17.0_x86_64/xfce4_dev_tools-4.17.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '1afbe430ed4e23d84b04573283a458ec64fe127989a9a9e1dd2cc3181e4cbbeb',
     armv7l: '1afbe430ed4e23d84b04573283a458ec64fe127989a9a9e1dd2cc3181e4cbbeb',
       i686: '8c3419c54ad2d8b0a205ffb7bba9cf0d5d5d6127153d38c9641ac458cf2f0698',
     x86_64: 'a4476a7992c67ed8402d6962f1484fa0741ed1283f02cab0ed1af701e265c68b'
  })

  depends_on 'gtk_doc'

  def self.patch
    system 'filefix'
  end

  def self.build
    system <<~BUILD
      [ -x autogen.sh ] && env NOCONFIGURE='1' ./autogen.sh
      env #{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS}
      make
    BUILD
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
