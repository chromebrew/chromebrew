require 'package'

class Libedit < Package
  description 'An autotooled and libtoolized port of the NetBSD Editline library (libedit).'
  homepage 'https://thrysoee.dk/editline/'
  version '20251016-3.1'
  compatibility 'all'
  license 'BSD-2'
  source_url "https://thrysoee.dk/editline/libedit-#{version}.tar.gz"
  source_sha256 '21362b00653bbfc1c71f71a7578da66b5b5203559d43134d2dd7719e313ce041'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '77153714440405f628f595eee6768dbd48a15c48724d87e73329110763334f8c',
     armv7l: '77153714440405f628f595eee6768dbd48a15c48724d87e73329110763334f8c',
       i686: '5c11ea524b881e6f90f62fcfa354716acd13ab5b5d94f3a71071568be46442f5',
     x86_64: '46ff742ce0cc8cea1ddc4c0c2c3a4db5ffb4d81d30d728b5c9162f51ecfc76be'
  })

  depends_on 'glibc' # R
  depends_on 'ncurses' # R

  def self.build
    system "./configure #{CREW_CONFIGURE_OPTIONS} \
            CPPFLAGS=\"-I#{CREW_PREFIX}/include/ncursesw\""
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    # Remove conflict with readline
    FileUtils.rm_f "#{CREW_DEST_MAN_PREFIX}/man3/history.3"
  end

  def self.check
    system 'make', 'check'
  end
end
