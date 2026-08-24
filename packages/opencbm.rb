require 'buildsystems/autotools'

class Opencbm < Autotools
  description 'Support package for retro devices that communicate with the serial CBM bus protocol'
  homepage 'https://spiro.trikaliotis.net/opencbm'
  version '0.4.99.104'
  license 'BSD-3 Clause'
  compatibility 'all'
  source_url 'https://github.com/OpenCBM/OpenCBM.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7607c9634cc9b5d73df4d5511bf9840e93f80eae846ce9c26b68ddd35df4bfc2',
     armv7l: '7607c9634cc9b5d73df4d5511bf9840e93f80eae846ce9c26b68ddd35df4bfc2',
       i686: '159faf982b56fd073b7ba9af23f412b111f4b1f13d035c7ce4f8775fd5b89fd8',
     x86_64: '9922c1746447b8e7d19d872da359801542e8e257758ac7ffb1e2a5d00fd42629'
  })

  depends_on 'cc65' => :executable
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libusb' => :library
  depends_on 'ncurses' => :executable

  autotools_skip_configure
  autotools_make_options '-f LINUX/Makefile opencbm plugin-xu1541'

  def self.patch
    system "sed -i 's,usleep,sleep,g' opencbm/nibtools/include/LINUX/mnibarch.h"
    system "sed -i 's,<ncurses.h>,<#{CREW_PREFIX}/include/ncursesw/ncurses.h>,' opencbm/cbmlinetester/cbmlinetester.c"
    system "sed -i 's,\$(PREFIX)/lib,#{CREW_LIB_PREFIX},g' opencbm/LINUX/config.make"
  end

  def self.install
    system "PREFIX=#{CREW_PREFIX} DESTDIR=#{CREW_DEST_DIR} \
      make -f LINUX/Makefile install install-plugin-xu1541"
  end
end
