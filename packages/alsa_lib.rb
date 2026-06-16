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
    aarch64: 'd3293ec3aa41d49cd5b57eed1787aac360580f23f67161c2206e82636e1c75dc',
     armv7l: 'd3293ec3aa41d49cd5b57eed1787aac360580f23f67161c2206e82636e1c75dc',
       i686: 'c9fb15bec32cfb7850d25148f575fc46324d7df161aa4d9da3c80fd4f61c1bdd',
     x86_64: 'e36a60d8b7ed216fc3fb5d023d7d857f8ca2b0f6bb3387e8c540c6e8f5bd9058'
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
