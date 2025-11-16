require 'buildsystems/autotools'

class Gpgme < Autotools
  description 'GnuPG Made Easy (GPGME) is a library designed to make access to GnuPG easier for applications.'
  homepage 'https://www.gnupg.org/related_software/gpgme/index.html'
  version '2.0.1'
  license 'GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url "https://www.gnupg.org/ftp/gcrypt/gpgme/gpgme-#{version}.tar.bz2"
  source_sha256 '821ab0695c842eab51752a81980c92b0410c7eadd04103f791d5d2a526784966'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0b5f52f208f9796617389bfc2d1aaa78f19ebba26ba5d6f458a57dc78ee3e338',
     armv7l: '0b5f52f208f9796617389bfc2d1aaa78f19ebba26ba5d6f458a57dc78ee3e338',
       i686: '5d59d63943df6e0beec7ea5402cb17fdc4544c6838b97d1b89a5248816f9bb28',
     x86_64: '4504ee8bf42fcf86d9fe5a06679f9f6b221b40a69bf537d710a09ca002cef7e9'
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
