require 'buildsystems/autotools'

class Alsa_lib < Autotools
  description 'The Advanced Linux Sound Architecture (ALSA) provides audio and MIDI functionality to the Linux operating system.'
  homepage 'https://www.alsa-project.org/main/index.php/Main_Page'
  @_ver = '1.2.10'
  version "#{@_ver}-py3.12"
  license 'LGPL-2.1'
  compatibility 'all'
  source_url "https://github.com/alsa-project/alsa-lib/archive/v#{@_ver}.tar.gz"
  source_sha256 'f55749847fd98274501f4691a2d847e89280c07d40a43cdac43d6443f69fc939'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/alsa_lib/1.2.10-py3.12_armv7l/alsa_lib-1.2.10-py3.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/alsa_lib/1.2.10-py3.12_armv7l/alsa_lib-1.2.10-py3.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/alsa_lib/1.2.10-py3.12_i686/alsa_lib-1.2.10-py3.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/alsa_lib/1.2.10-py3.12_x86_64/alsa_lib-1.2.10-py3.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'eb5d64babfaeb1ebb110207f85e01506e09313cdfce51ff1af7c2f85fa2da80f',
     armv7l: 'eb5d64babfaeb1ebb110207f85e01506e09313cdfce51ff1af7c2f85fa2da80f',
       i686: '9be05bc6dcc67cdb8d02ca168612f06baf429cd84e24533b99a9b0f9e0b9a907',
     x86_64: '6faec883fafbf426ef0570e976a24e4755878ce77c997f346283258130124982'
  })

  depends_on 'glibc' # R
  depends_on 'python3' # L

  def self.build
    @py_ver = `python -c "import sys; version = '.'.join(map(str, sys.version_info[:2])) ; print(version)"`.chomp
    system 'autoreconf -fiv'
    system "mold -run ./configure #{CREW_OPTIONS} \
       --without-debug \
       --disable-maintainer-mode \
       --with-pythonlibs=-lpython#{@py_ver} \
       --with-pythonincludes=-I#{CREW_PREFIX}/include/python#{@py_ver}"
    system 'make'
  end
end
