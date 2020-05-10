require 'package'

class Screen < Package
  description 'Screen is a full-screen window manager that multiplexes a physical terminal between several processes, typically interactive shells.'
  homepage 'https://www.gnu.org/software/screen/'
  version '4.6.2'
  compatibility 'all'
  source_url 'https://ftp.gnu.org/gnu/screen/screen-4.6.2.tar.gz'
  source_sha256 '1b6922520e6a0ce5e28768d620b0f640a6631397f95ccb043b70b91bb503fa3a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/screen-4.6.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/screen-4.6.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/screen-4.6.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/screen-4.6.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f8d903c06175118730ea3d44ed59f6d6fbd94c7f5c6ed190e8e7ca42bb3cfc76',
     armv7l: 'f8d903c06175118730ea3d44ed59f6d6fbd94c7f5c6ed190e8e7ca42bb3cfc76',
       i686: '43e1b9056ee3d67b7b3f45ef52c381a62340bcaf97748a7ebc8b92adfed10026',
     x86_64: '27ec590cfff20b1429f86baca0d42a6e3819a4978d13155b5ec31db04a374b5b',
  })

  depends_on 'ncurses'

  def self.build
    system './configure',
      "--prefix=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
