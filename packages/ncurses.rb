require 'package'

class Ncurses < Package
  description 'The ncurses (new curses) library is a free software emulation of curses in System V Release 4.0 (SVr4), and more.'
  homepage 'https://www.gnu.org/software/ncurses/'
  version '6.0-2'
  source_url 'ftp://ftp.gnu.org/pub/gnu/ncurses/ncurses-6.0.tar.gz'
  source_sha256 'f551c24b30ce8bfb6e96d9f59b42fbea30fa3a6123384172f9e7284bcf647260'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/ncurses-6.0-2-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/ncurses-6.0-2-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/ncurses-6.0-2-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/ncurses-6.0-2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '3951a422aff0fb0358c5190674bff39f30dd36b0b0df6f3c8a2717141be1447d',
     armv7l: '3951a422aff0fb0358c5190674bff39f30dd36b0b0df6f3c8a2717141be1447d',
       i686: '57851803decba529076a1a1b9b719dc15ac60c5f96709a2fb9eb769a56f4e81b',
     x86_64: '761f5a0bac8df8af682ca0df82b42afc3d5a7217a1b359e4b7ba51c7851857e4',
  })

  depends_on 'diffutils' => :build
  depends_on 'ncursesw'

  def self.build
    system './configure',
           '--prefix=/usr/local',
           "--libdir=#{CREW_LIB_PREFIX}",
           '--without-normal',
           '--with-shared',
           '--with-cxx-shared',
           '--without-debug'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
