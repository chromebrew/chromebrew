require 'buildsystems/autotools'

class Alsa_lib < Autotools
  description 'The Advanced Linux Sound Architecture (ALSA) provides audio and MIDI functionality to the Linux operating system.'
  homepage 'https://www.alsa-project.org/main/index.php/Main_Page'
  version "1.2.16.1-#{CREW_PY_VER}"
  license 'LGPL-2.1'
  compatibility 'all'
  source_url "https://github.com/alsa-project/alsa-lib/archive/v#{version.split('-').first}.tar.gz"
  source_sha256 '8df8253c6349cf309903c1dd7752efe783c1f456913c9d722bdb5731271c0988'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e6d206423b2a49aec0e1dd95649501525a3b9b87281545bf857e0b78108aba81',
     armv7l: 'e6d206423b2a49aec0e1dd95649501525a3b9b87281545bf857e0b78108aba81',
       i686: '92f49e4d30282226f8c239e86b864fb92197858272a3292b15a64b0457a0a6b8',
     x86_64: '3997923a0d3682872b3b59ae66b003fb9f433f3310681015dada38135379cc39'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'python3' => :logical

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
