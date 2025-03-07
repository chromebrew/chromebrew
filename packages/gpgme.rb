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
    aarch64: 'dc4fbcc9f8abb29a5163877b5204a53e72b1a694297d2471c2919c4d9df76b4c',
     armv7l: 'dc4fbcc9f8abb29a5163877b5204a53e72b1a694297d2471c2919c4d9df76b4c',
       i686: '08335b59c6d63d2da675544b71332255861d7053b0567649d6872b374ef56d7f',
     x86_64: '625651f0ae53383ab88615aa49a954849953fbef58648673245ac83f585911c5'
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
