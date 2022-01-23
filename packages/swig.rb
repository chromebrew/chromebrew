require 'package'

class Swig < Package
  description 'Simplified Wrapper and Interface Generator'
  homepage 'http://www.swig.org'
  version '4.0.2'
  license 'GPL-3, BSD and BSD-2'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/swig/swig/swig-4.0.2/swig-4.0.2.tar.gz'
  source_sha256 'd53be9730d8d58a16bf0cbd1f8ac0c0c3e1090573168bfa151b01eb47fa906fc'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/swig/4.0.2_armv7l/swig-4.0.2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/swig/4.0.2_armv7l/swig-4.0.2-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/swig/4.0.2_i686/swig-4.0.2-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/swig/4.0.2_x86_64/swig-4.0.2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '12f62e4758ab51ee5284a6124a633f416e16eeb35052ba7a34d208e6c75c37a0',
     armv7l: '12f62e4758ab51ee5284a6124a633f416e16eeb35052ba7a34d208e6c75c37a0',
       i686: '3a2745de14603c0c998e3c9219a6ac76e0129068d8a7dae6b53a17f644f8f4b4',
     x86_64: 'b2c9aff000d7e96df6c4a3ae98c0ca80ccdec8f03b2cec253f1991df189d47a8'
  })

  depends_on 'boost'
  depends_on 'pcre'
  depends_on 'zlibpkg'

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
