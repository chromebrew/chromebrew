require 'buildsystems/autotools'

class Alsa_lib < Autotools
  description 'The Advanced Linux Sound Architecture (ALSA) provides audio and MIDI functionality to the Linux operating system.'
  homepage 'https://www.alsa-project.org/main/index.php/Main_Page'
  version "1.2.14-#{CREW_PY_VER}"
  license 'LGPL-2.1'
  compatibility 'all'
  source_url "https://github.com/alsa-project/alsa-lib/archive/v#{version.split('-').first}.tar.gz"
  source_sha256 'a7bc6c09f0e5a622ebc8afb63a194aa1396145b5c6433d3445363201d96c23c4'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '570ee5e7d7164a3e6c67f0cc28a72c5052e0520ca1489af80bf5d1afa1272cf2',
     armv7l: '570ee5e7d7164a3e6c67f0cc28a72c5052e0520ca1489af80bf5d1afa1272cf2',
       i686: '53f68bdfb4df092d98b184335e0fba990c768268ae9789e0f12cc621721bf622',
     x86_64: '7d9cf5e9b5a2cb154f58ec95febfcc7dcb9e83c27fa4818c939507135ea5f08c'
  })

  depends_on 'glibc' # R
  depends_on 'python3' # L

  autotools_configure_options <<~OPT
    --without-debug \
    --disable-maintainer-mode \
    --with-pythonlibs=-lpython#{CREW_PY_VER.delete_prefix('py')} \
    --with-pythonincludes=-I#{CREW_PREFIX}/include/python#{CREW_PY_VER.delete_prefix('py')}
  OPT
end
