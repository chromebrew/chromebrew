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
     aarch64: 'e7140bfffd7af0f75c3d95bf40626f2f83a855b7cdbe3d9e019424a6d356f293',
      armv7l: 'e7140bfffd7af0f75c3d95bf40626f2f83a855b7cdbe3d9e019424a6d356f293',
        i686: 'a818331f5f3f431fbdcfadf9418ad4e99cdf3bfa2271a1d921c4e30ad5dc0e63',
      x86_64: '712f217975226bbb33e2ddb16d049f389618bf48bea5410aeb389043c1ab06a3',
  })

  depends_on 'libcap' => ':build'
  depends_on 'libseccomp' => ':build'

  def self.build
    #system "sed -E 's|(  paths =) \[\]|\1 [#{CREW_LIB_PREFIX}]|g' -i lddtree.py"
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
