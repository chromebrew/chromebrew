require 'buildsystems/autotools'

class Alsa_lib < Autotools
  description 'The Advanced Linux Sound Architecture (ALSA) provides audio and MIDI functionality to the Linux operating system.'
  homepage 'https://www.alsa-project.org/main/index.php/Main_Page'
  version "1.2.15.1-#{CREW_PY_VER}"
  license 'LGPL-2.1'
  compatibility 'all'
  source_url "https://github.com/alsa-project/alsa-lib/archive/v#{version.split('-').first}.tar.gz"
  source_sha256 '28a2364aa9d7e32b5236112afc7b1dcac1e20ffa67b23a259f9252ebfda11b7b'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0e4a962c02724f98071c1acaad5240c1a64ac03d9cb92e9619873097dbcf694a',
     armv7l: '0e4a962c02724f98071c1acaad5240c1a64ac03d9cb92e9619873097dbcf694a',
       i686: 'ad372498fe8e2d961a0e0f8ddc236ccef90dec760c8bb51da441bd3ee9bc8a95',
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
