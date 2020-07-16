require 'package'

class Procps < Package
  description 'procps is a set of command line and full-screen utilities that provide information out of the pseudo-filesystem most commonly located at /proc.'
  homepage 'https://gitlab.com/procps-ng/procps'
  version '3.3.16'
  compatibility 'all'
  source_url 'https://gitlab.com/procps-ng/procps/-/archive/v3.3.16/procps-v3.3.16.tar.bz2'
  source_sha256 '720caf307ab5dfe6d1cf4fc3e6ce786d749c69baa088627dbe1b01828f2528b1'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/procps-3.3.16-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/procps-3.3.16-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/procps-3.3.16-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/procps-3.3.16-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c126d133d112220e9b055f58ac5f71970344df4e88d5475d5005252914fe3ae0',
     armv7l: 'c126d133d112220e9b055f58ac5f71970344df4e88d5475d5005252914fe3ae0',
       i686: '907304652a1d986d6864498115d980d4b9ed73939a9b8f2f8ae2772ad373ee90',
     x86_64: '4365db9d4e3397c9c1f48d6366c44a6351b19a9a1dafb142fb65e7d614b36a6e',
  })

  def self.build
    system './autogen.sh'
    system "CFLAGS='-I#{CREW_PREFIX}/include/ncursesw' ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
