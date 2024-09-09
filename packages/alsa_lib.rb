require 'buildsystems/autotools'

class Alsa_lib < Autotools
  description 'The Advanced Linux Sound Architecture (ALSA) provides audio and MIDI functionality to the Linux operating system.'
  homepage 'https://www.alsa-project.org/main/index.php/Main_Page'
  version '1.2.12-py3.12'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url "https://github.com/alsa-project/alsa-lib/archive/v#{version.split('-').first}.tar.gz"
  source_sha256 'f067dbba9376e5bbbb417b77751d2a9f2f277c54fb3a2b5c023cc2c7dfb4e3c1'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1409d8a119ee28fb2b9e6cd789ef86e17034a9331e0f0bde0db3a06af102d156',
     armv7l: '1409d8a119ee28fb2b9e6cd789ef86e17034a9331e0f0bde0db3a06af102d156',
       i686: '45fc80421c2e3220a540ff0b534578506e43f54e4ca8561b9ff93888f528d70c',
     x86_64: '241d2bee8a74d9446ed29765a00300e0b60d4b1b778ae28040902c24c50bdf3d'
  })

  depends_on 'glibc' # R
  depends_on 'python3' # L

  def self.build
    @py_ver = `python -c "import sys; version = '.'.join(map(str, sys.version_info[:2])) ; print(version)"`.chomp
    system 'autoreconf -fiv'
    system "mold -run ./configure #{CREW_CONFIGURE_OPTIONS} \
       --without-debug \
       --disable-maintainer-mode \
       --with-pythonlibs=-lpython#{@py_ver} \
       --with-pythonincludes=-I#{CREW_PREFIX}/include/python#{@py_ver}"
    system 'make'
  end
end
