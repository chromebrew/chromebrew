require 'buildsystems/autotools'

class Alsa_lib < Autotools
  description 'The Advanced Linux Sound Architecture (ALSA) provides audio and MIDI functionality to the Linux operating system.'
  homepage 'https://www.alsa-project.org/main/index.php/Main_Page'
  @_ver = '1.2.11'
  version "#{@_ver}-py3.12"
  license 'LGPL-2.1'
  compatibility 'all'
  source_url "https://github.com/alsa-project/alsa-lib/archive/v#{@_ver}.tar.gz"
  source_sha256 '12216f0730d6dde3ded6a2a5388bc0009ad07f5c65972bd89aac9a76f8f085a4'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'dd76e895e0314728a1600cac5e47ed5a0c15092d5927e5d6e2e280a3a6a56a42',
     armv7l: 'dd76e895e0314728a1600cac5e47ed5a0c15092d5927e5d6e2e280a3a6a56a42',
       i686: 'afa0c01b6cb3f50b2d8db1e08797ff8866ed1421f2e093195acacd65edbcae69',
     x86_64: '171d4c8ee0f259871010214b1b2bb0043fe393ca8579e53f46e94cbeb2383b29'
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
