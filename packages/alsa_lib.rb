require 'buildsystems/autotools'

class Alsa_lib < Autotools
  description 'The Advanced Linux Sound Architecture (ALSA) provides audio and MIDI functionality to the Linux operating system.'
  homepage 'https://www.alsa-project.org/main/index.php/Main_Page'
  version "1.2.15.2-#{CREW_PY_VER}"
  license 'LGPL-2.1'
  compatibility 'all'
  source_url "https://github.com/alsa-project/alsa-lib/archive/v#{version.split('-').first}.tar.gz"
  source_sha256 '3222aaf0e58ddf3cfcb1e7322e7adfdd60d9652aa41f1615459d39c7c8b48f95'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd130815f4e67d70b6ddc40fc8f305e0ae51fb92fe4d6724e0620827f52f6aa39',
     armv7l: 'd130815f4e67d70b6ddc40fc8f305e0ae51fb92fe4d6724e0620827f52f6aa39',
       i686: '23f14112cf5553589fd2fea792d394eb15de74e993e571e7bdc3b5259f22dea2',
     x86_64: 'b76637e76ee49a2efebd3efd1183e3513030b64a73fb42d0beeaf9cf13252cfe'
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
