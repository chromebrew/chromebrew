require 'buildsystems/autotools'

class Gpgme < Autotools
  description 'GnuPG Made Easy (GPGME) is a library designed to make access to GnuPG easier for applications.'
  homepage 'https://www.gnupg.org/related_software/gpgme/index.html'
  version '1.24.2'
  license 'GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url "https://www.gnupg.org/ftp/gcrypt/gpgme/gpgme-#{version}.tar.bz2"
  source_sha256 '61e3a6ad89323fecfaff176bc1728fb8c3312f2faa83424d9d5077ba20f5f7da'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '011f15008e005330988dcff0d3c7dacb7417aaee8a51b3ee9567ad72b37ad3a6',
     armv7l: '011f15008e005330988dcff0d3c7dacb7417aaee8a51b3ee9567ad72b37ad3a6',
       i686: '08335b59c6d63d2da675544b71332255861d7053b0567649d6872b374ef56d7f',
     x86_64: '38de5c2986e5288ac1e3a2002b455b3301f10bac1bb891c195aac2b53977eb81'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'gnupg' # L
  depends_on 'libassuan' # R
  depends_on 'libgpg_error' # R

  def self.patch
    Dir.chdir('src') do
      File.write 'gettid_wrapper', <<~GETTID_WRAPPER_EOF
        #if __GLIBC_PREREQ(2,30)
        #define _GNU_SOURCE
        #include <unistd.h>

        #else

        #include <unistd.h>
        #include <sys/syscall.h>

        pid_t
        gettid(void)
        {

            return syscall(SYS_gettid);
        }
        #endif
      GETTID_WRAPPER_EOF
      system "sed -i '/# include <unistd.h>/d' debug.c"
      system "sed -i '/#ifdef HAVE_UNISTD_H/r gettid_wrapper' debug.c"
    end
  end
end
