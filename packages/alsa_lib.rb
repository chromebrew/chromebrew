require 'package'

class Alsa_lib < Package
  description 'The Advanced Linux Sound Architecture (ALSA) provides audio and MIDI functionality to the Linux operating system.'
  homepage 'https://www.alsa-project.org/main/index.php/Main_Page'
  version '1.2.9'
  license 'LGPL-2.1'
  compatibility 'x86_64 aarch64 armv7l'
  source_url "https://github.com/alsa-project/alsa-lib/archive/v#{version}.tar.gz"
  source_sha256 '95bbac3c04e7a722439e0c282232881e8657562ae55a90b85e58a8f5aa140ac0'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/alsa_lib/1.2.9_armv7l/alsa_lib-1.2.9-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/alsa_lib/1.2.9_armv7l/alsa_lib-1.2.9-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/alsa_lib/1.2.9_x86_64/alsa_lib-1.2.9-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'f872050fc0f77633fe2d6860328ec13e7bc43a3c3e4de41bf8daefa68fe6f91e',
     armv7l: 'f872050fc0f77633fe2d6860328ec13e7bc43a3c3e4de41bf8daefa68fe6f91e',
     x86_64: '58437d5b0c77fb495e4f354c7b19c73dd98b8aff781cb7ea83e4339b36ba2b88'
  })

  depends_on 'python3' # L
  depends_on 'glibc' # R

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

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
