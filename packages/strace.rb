require 'package'

class Strace < Package
  description 'strace is a diagnostic, debugging and instructional userspace utility for Linux.'
  homepage 'https://strace.io/'
  version '5.16'
  license 'BSD'
  compatibility 'all'
  source_url 'https://strace.io/files/5.16/strace-5.16.tar.xz'
  source_sha256 'dc7db230ff3e57c249830ba94acab2b862da1fcaac55417e9b85041a833ca285'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/strace/5.16_armv7l/strace-5.16-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/strace/5.16_armv7l/strace-5.16-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/strace/5.16_i686/strace-5.16-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/strace/5.16_x86_64/strace-5.16-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '1dd689637846d2c9cdb322b89ae9f2ad8494cfb1ac9eea2d58c5c66a6b951288',
     armv7l: '1dd689637846d2c9cdb322b89ae9f2ad8494cfb1ac9eea2d58c5c66a6b951288',
       i686: '4725326b262e7700a07cae5a097d29fb2ac67d36a905b4c37d95c6c9c6f69704',
     x86_64: 'd1792aadec94cec75b2f8433aba3be6b2fbff41a28f5f5240a2e84d417df03c9'
  })

  depends_on 'elfutils' # Needed for stack trace support

  def self.build
    system "./configure \
      --with-libdw \
      --disable-mpers \
      #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
