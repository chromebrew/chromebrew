require 'package'

class Pax_utils < Package
  description 'ELF utils that can check files for security relevant properties'
  homepage 'https://wiki.gentoo.org/wiki/Hardened/PaX_Utilities'
  version '1.2.5'
  compatibility 'all'
  source_url 'https://dev.gentoo.org/~slyfox/distfiles/pax-utils-1.2.5.tar.xz'
  source_sha256 '7ce7170ceed255bb47cac03b88bcbc636b0e412cac974e213e8017a1dae292ec'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/pax_utils-1.2.5-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/pax_utils-1.2.5-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/pax_utils-1.2.5-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/pax_utils-1.2.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: 'edc856ff6cc451358da1fb46a2a1023594f3d243cb1c30e5aa67c9ee9ed4dac6',
      armv7l: 'edc856ff6cc451358da1fb46a2a1023594f3d243cb1c30e5aa67c9ee9ed4dac6',
        i686: '9254843237e4bba47da7c4ec63ca7109e32ad7fee5822a1862fdddc789c280bb',
      x86_64: '836d8627d96ed61608cb7bee423db753fc00c67600c62386e1df98d4529c35c9',
  })

  depends_on 'pyelftools'
  depends_on 'libcap' => ':build'
  depends_on 'libseccomp' => ':build'

  def self.build
    system "sed -i 's|/usr/bin/env python|/usr/bin/env python3|g' lddtree.py"
    system "env CFLAGS='-pipe -flto=auto' CXXFLAGS='-pipe -flto=auto' LDFLAGS='-flto=auto' \
    ./configure \
    #{CREW_OPTIONS} \
    --with-caps \
    --with-seccomp \
    --with-python"
    system "make"
  end
  
  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
