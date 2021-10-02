require 'package'

class Libedit < Package
  description 'This is an autotool and libtoolized port of the NetBSD Editline library (libedit).'
  homepage 'http://thrysoee.dk/editline/'
  version '20210522-3.1'
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://thrysoee.dk/editline/libedit-20210522-3.1.tar.gz'
  source_sha256 '0220bc2047e927c0c1984ef5f7b4eb2a9469a5b7bf12ba573ca3b23ca02bbb6f'

  binary_url ({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libedit/20210522-3.1_armv7l/libedit-20210522-3.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libedit/20210522-3.1_armv7l/libedit-20210522-3.1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libedit/20210522-3.1_i686/libedit-20210522-3.1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libedit/20210522-3.1_x86_64/libedit-20210522-3.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '21b75fb838a66f7459299bfe2e19905ad51473592d8a3a270b1cec5c7611fa60',
     armv7l: '21b75fb838a66f7459299bfe2e19905ad51473592d8a3a270b1cec5c7611fa60',
       i686: '2d42b3a52e8db660b5959f164a436595feada9559cd0635e11ccda26d51ab9e2',
     x86_64: '5ab911b8abe6d07c2a6c88e5305597001d8de5bd61c799d318db4147a7e52cfa',
  })

  def self.build
    system "env CFLAGS='-pipe -flto=auto' CXXFLAGS='-pipe -flto=auto \"-I#{CREW_PREFIX}/include/ncurses\"' LDFLAGS='-flto=auto' \
      ./configure \
      #{CREW_OPTIONS} \
      CPPFLAGS=\"-I#{CREW_PREFIX}/include/ncursesw\""
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    # Remove conflict with readline
    FileUtils.rm_f "#{CREW_DEST_MAN_PREFIX}/man3/history.3"
  end
end
