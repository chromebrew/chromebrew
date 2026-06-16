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
    aarch64: 'b9b6f1f3a768f82583c17850bc85268b98915f0f48e4a7b93caaa05d590a6d93',
     armv7l: 'b9b6f1f3a768f82583c17850bc85268b98915f0f48e4a7b93caaa05d590a6d93',
       i686: '3eefe87db859eb1ce1af226f0515ba452712d5a6711621c9a60ba0868a786106',
     x86_64: '9fedb50d0c9cd71681a8d46100047de35199b725b5c1394dec3e225b004bfd0e'
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
