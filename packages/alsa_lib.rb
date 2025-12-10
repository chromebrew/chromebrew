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
    aarch64: 'b3e2a619fdb59d8169d6c8546aa4529651a104a5920737a1ee160a6c48266227',
     armv7l: 'b3e2a619fdb59d8169d6c8546aa4529651a104a5920737a1ee160a6c48266227',
       i686: 'f5ac953795b69abcb5689601915b34c4cb8ce0f934dd82e119508bd1c2c52142',
     x86_64: '71bd6a1598b0815172a33202a5e19bed6e598c7c9ffff412583c3732715be5db'
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
