require 'package'

class Scrot < Package
  description 'scrot, an acronym for (SCReen shOT) is a simple, freely distributed and open source command-line screen capture utility'
  homepage 'https://github.com/resurrecting-open-source-projects/scrot'
  version '1.2'
  compatibility 'all'
  source_url 'https://github.com/resurrecting-open-source-projects/scrot/archive/1.2.tar.gz'
  source_sha256 'e9b41d4cb9b5ab3747d6718c4eb51d5aaf35b6cac23c9ff68af15fc1c9ce187c'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/scrot-1.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/scrot-1.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/scrot-1.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/scrot-1.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'bbb19fc3f64dd778da3a3a79658cb22da4d435ebd6319ba0d6dce5117d8790cc',
     armv7l: 'bbb19fc3f64dd778da3a3a79658cb22da4d435ebd6319ba0d6dce5117d8790cc',
       i686: '2b1720613f82c66ab60473bf454375c6b3a73019a5e7f10dd6af0327f51dd777',
     x86_64: 'a80847e67860885dadcb12c0dce773dee599293240a3365932268ac77d98e75b',
  })

  depends_on 'autoconf_archive' => :build
  depends_on 'giblib'
  depends_on 'libxcursor'
  depends_on 'libxfixes'

  def self.build
    system './autogen.sh'
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
