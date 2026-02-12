require 'buildsystems/autotools'

class Alsa_lib < Autotools
  description 'The Advanced Linux Sound Architecture (ALSA) provides audio and MIDI functionality to the Linux operating system.'
  homepage 'https://www.alsa-project.org/main/index.php/Main_Page'
  version "1.2.15.3-#{CREW_PY_VER}"
  license 'LGPL-2.1'
  compatibility 'all'
  source_url "https://github.com/alsa-project/alsa-lib/archive/v#{version.split('-').first}.tar.gz"
  source_sha256 '7a3bee640f1c29fdfa3d1f922185929b546f012c27a73bbb6b424d12488c3c8e'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7aa6f2ff6da65eba5bc580da449538807ca09118dfb41315549e7f116945e755',
     armv7l: '7aa6f2ff6da65eba5bc580da449538807ca09118dfb41315549e7f116945e755',
       i686: '9fd0d3e1fff2ea531ed7265280beafc06b7388f64f7f6c191b091c09bf2f5487',
     x86_64: '1c76976bf5cfd82a11bb33a9c396573e3d441b4fce564cdcd6759988259de1c0'
  })

  depends_on 'glibc' # R
  depends_on 'python3' # L

  def self.patch
    patches = [
      # https://github.com/alsa-project/alsa-lib/issues/485
      ['https://github.com/sysfce2/alsa-lib/commit/a068cf08ad67447893b707cddfce31c9cafee643.patch',
       'a68bee2ca19cdce724dbbe3540b3f76d991ecf80f70d0e1d895c68856739e247']
    ]
    ConvenienceFunctions.patch(patches)
  end

  autotools_configure_options <<~OPT
    --without-debug \
    --disable-maintainer-mode \
    --with-pythonlibs=-lpython#{CREW_PY_VER.delete_prefix('py')} \
    --with-pythonincludes=-I#{CREW_PREFIX}/include/python#{CREW_PY_VER.delete_prefix('py')}
  OPT
end
