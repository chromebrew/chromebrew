require 'package'

class Girara < Package
  description 'Girara is a library that implements a user interface that focuses on simplicity and minimalism'
  homepage 'https://pwmt.org/projects/girara/'
  version '0.3.4'
  compatibility 'all'
  source_url 'https://git.pwmt.org/pwmt/girara/-/archive/0.3.4/girara-0.3.4.tar.bz2'
  source_sha256 'e78257e4218a0f7f59cc1bea472c7c6794fa51cd9261d87affbe731c1e22c6a5'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/girara-0.3.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/girara-0.3.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/girara-0.3.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/girara-0.3.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '80227f425ebf691df7460693665197e0b1a2fdfbf147a2c94b49e2b446123cad',
     armv7l: '80227f425ebf691df7460693665197e0b1a2fdfbf147a2c94b49e2b446123cad',
       i686: '57c818963505dd97b50c3776f9b1a3e78ec9b6ef51b22940a5f477bfbcbb0542',
     x86_64: '3b3f8d2c75abbe4a2f00b42a94239a988b293857450ca63afa827d4fbd9c436f',
  })

  depends_on 'gtk3'
  depends_on 'glib'

  def self.build
    system "meson  --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} builddir"
    system "ninja -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end

end
