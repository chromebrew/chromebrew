require 'buildsystems/autotools'

class Libgcrypt < Autotools
  description 'Libgcrypt is a general purpose cryptographic library originally based on code from GnuPG.'
  homepage 'https://www.gnupg.org/related_software/libgcrypt/index.html'
  version '1.11.1'
  license 'LGPL-2.1 and MIT'
  compatibility 'all'
  source_url "https://www.gnupg.org/ftp/gcrypt/libgcrypt/libgcrypt-#{version}.tar.bz2"
  source_sha256 '24e91c9123a46c54e8371f3a3a2502f1198f2893fbfbf59af95bc1c21499b00e'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3084b4d1869a8ff6d5daa76dcf9451378795fdac5af9182bda7a0a7b9d4f079c',
     armv7l: '3084b4d1869a8ff6d5daa76dcf9451378795fdac5af9182bda7a0a7b9d4f079c',
       i686: '85c818af47cfe64df3acab5e5e1e54a5ad98ce3495e6cf3d703568222b0d196d',
     x86_64: 'cd0fb26e325aebc496d8b539f2f6b6744446b49caa1b34d9a1d5061b7dd502e9'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libgpg_error' # R

  autotools_configure_options '--enable-shared'

  def self.patch
    # Fix error: 'asm' operand has impossible constraints or there are not enough registers
    # See https://dev.gnupg.org/T7226.
    if %w[aarch64 armv7l].include?(ARCH)
      puts 'Downloading patch...'.yellow
      downloader 'https://files.gnupg.net/file/download/4axfkyiszlsm4qgf5lxy/PHID-FILE-k3tzb5qnxdtsfvvpd7q4/0001-mpi-ec-inline-reduce-register-pressure-on-32-bit-ARM.patch',
                 'de543d9d5bfcfb91090c0ebbe46b321344686130cbe5f214ca86c9f8c040d5fa'
      puts 'Applying patch...'.yellow
      system 'git apply 0001-mpi-ec-inline-reduce-register-pressure-on-32-bit-ARM.patch'
    end
  end

  run_tests
end
