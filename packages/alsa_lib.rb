require 'buildsystems/autotools'

class Alsa_lib < Autotools
  description 'The Advanced Linux Sound Architecture (ALSA) provides audio and MIDI functionality to the Linux operating system.'
  homepage 'https://www.alsa-project.org/main/index.php/Main_Page'
  version "1.2.15-#{CREW_PY_VER}"
  license 'LGPL-2.1'
  compatibility 'all'
  source_url "https://github.com/alsa-project/alsa-lib/archive/v#{version.split('-').first}.tar.gz"
  source_sha256 '7226c4da8de1596ee7cd82480999c462c9b6fba98cb40332255049ed9bde9aee'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b3e2a619fdb59d8169d6c8546aa4529651a104a5920737a1ee160a6c48266227',
     armv7l: 'b3e2a619fdb59d8169d6c8546aa4529651a104a5920737a1ee160a6c48266227',
       i686: 'f5ac953795b69abcb5689601915b34c4cb8ce0f934dd82e119508bd1c2c52142',
     x86_64: '7cfe1b17fd3e3f52ecfab933b2846a670773e171880221d0d24584e4eeff17fd'
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
