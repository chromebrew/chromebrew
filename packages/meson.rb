require 'package'

class Meson < Package
  description 'The Meson Build System'
  homepage 'http://mesonbuild.com/'
  version '0.44.0'
  source_url 'https://github.com/mesonbuild/meson/releases/download/0.44.0/meson-0.44.0.tar.gz'
  source_sha256 '50f9b12b77272ef6ab064d26b7e06667f07fa9f931e6a20942bba2216ba4281b'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/meson-0.44.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/meson-0.44.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/meson-0.44.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/meson-0.44.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c814597fe5e7484842fb29bab30950dae676de79abf13bb4f27a04b21050ed1c',
     armv7l: 'c814597fe5e7484842fb29bab30950dae676de79abf13bb4f27a04b21050ed1c',
       i686: 'e729cf5475fd0510ad3ad589d7d490e8223251f1c66bfaefa8f166388ae0747a',
     x86_64: 'caeec7cc54aaa53aaa54f861000856aad0f01da4cb92bde6c1ce20116167af8a',
  })
  
  depends_on 'ninja'

  def self.install
    system "pip3 install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR} meson"
  end
end
