require 'buildsystems/autotools'

class Alsa_lib < Autotools
  description 'The Advanced Linux Sound Architecture (ALSA) provides audio and MIDI functionality to the Linux operating system.'
  homepage 'https://www.alsa-project.org/main/index.php/Main_Page'
  version "1.2.12-#{CREW_PY_VER}"
  license 'LGPL-2.1'
  compatibility 'all'
  source_url "https://github.com/alsa-project/alsa-lib/archive/v#{version.split('-').first}.tar.gz"
  source_sha256 'f067dbba9376e5bbbb417b77751d2a9f2f277c54fb3a2b5c023cc2c7dfb4e3c1'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '570ee5e7d7164a3e6c67f0cc28a72c5052e0520ca1489af80bf5d1afa1272cf2',
     armv7l: '570ee5e7d7164a3e6c67f0cc28a72c5052e0520ca1489af80bf5d1afa1272cf2',
       i686: '8b7e69705b7f7fa70c9e523b63cc65ad14dd9287c56574c61d0843ca65aeb990',
     x86_64: '7d9cf5e9b5a2cb154f58ec95febfcc7dcb9e83c27fa4818c939507135ea5f08c'
  })

  depends_on 'glibc' # R
  depends_on 'python3' # L

  def self.build
    @py_ver = `python -c "import sys; version = '.'.join(map(str, sys.version_info[:2])) ; print(version)"`.chomp
    system 'autoreconf -fiv'
    system "./configure #{CREW_CONFIGURE_OPTIONS} \
       --without-debug \
       --disable-maintainer-mode \
       --with-pythonlibs=-lpython#{@py_ver} \
       --with-pythonincludes=-I#{CREW_PREFIX}/include/python#{@py_ver}"
    system 'make'
  end
end
