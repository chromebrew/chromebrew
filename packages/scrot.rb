require 'package'

class Scrot < Package
  description 'scrot, an acronym for (SCReen shOT) is a simple, freely distributed and open source command-line screen capture utility'
  homepage 'https://github.com/resurrecting-open-source-projects/scrot'
  version '1.8.1'
  license 'feh and LGPL-2+'
  compatibility 'all'
  source_url 'https://github.com/resurrecting-open-source-projects/scrot/releases/download/1.8.1/scrot-1.8.1.tar.bz2'
  source_sha256 '05f91be9a32eb912f8f2b9abdb3dca83166f77ed0a5a430b6766067ab13c3b18'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/scrot/1.8.1_armv7l/scrot-1.8.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/scrot/1.8.1_armv7l/scrot-1.8.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/scrot/1.8.1_i686/scrot-1.8.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/scrot/1.8.1_x86_64/scrot-1.8.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '369e6e791ae3be26802eb410e76e87ef94aacf9a22d8770f8553d08393359c19',
     armv7l: '369e6e791ae3be26802eb410e76e87ef94aacf9a22d8770f8553d08393359c19',
       i686: '7b2c5d0cbb359ff67b990e04c9414f7bbe694364f975e1f4a420122a43c8e443',
     x86_64: '985f1c550bb81074318088309b31e5e89fca94a98c63ea4a8e946fe49172724d'
  })

  depends_on 'autoconf_archive' => :build
  depends_on 'giblib'
  depends_on 'libxcursor'
  depends_on 'libxfixes'
  depends_on 'optipng'

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
