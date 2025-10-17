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
    aarch64: 'df991d3222c3861376796273e2cac18c23a5b3f909b3fe13d13ae794776a4335',
     armv7l: 'df991d3222c3861376796273e2cac18c23a5b3f909b3fe13d13ae794776a4335',
       i686: '9b2f5431f8edbf727d9f413e46f07c15d4e5ff2c4e9c3006dad3ca42f12bba0e',
     x86_64: '5becd6c50a6a867a2e37cbdc601a0f02ccc57cc999efe445b84ad57514c030a2'
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
