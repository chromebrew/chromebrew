require 'package'

class Autoconf < Package
  description 'Autoconf is an extensible package of M4 macros that produce shell scripts to automatically configure software source code packages.'
  homepage 'http://www.gnu.org/software/autoconf/'
  version '2.71'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/autoconf/autoconf-2.71.tar.xz'
  source_sha256 'f14c83cfebcc9427f2c3cea7258bd90df972d92eb26752da4ddad81c87a0faa4'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/autoconf/2.71_armv7l/autoconf-2.71-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/autoconf/2.71_armv7l/autoconf-2.71-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/autoconf/2.71_i686/autoconf-2.71-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/autoconf/2.71_x86_64/autoconf-2.71-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'cf2d3888909044d6dd3109b83d856a7face1d6bded14af644dd09985b5c92272',
     armv7l: 'cf2d3888909044d6dd3109b83d856a7face1d6bded14af644dd09985b5c92272',
       i686: '281f27740a18dcf251a36ee1b3067624b98da669e62d4cbd41e6631acba4805a',
     x86_64: 'bd98d4a7920f4c4e02587d56a11b893436c81d0ce10e6b136532376bf78c8d2d'
  })

  depends_on 'perl'
  depends_on 'm4'

  def self.build
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
