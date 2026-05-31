require 'buildsystems/autotools'

class Gpgme < Autotools
  description 'GnuPG Made Easy (GPGME) is a library designed to make access to GnuPG easier for applications.'
  homepage 'https://www.gnupg.org/related_software/gpgme/index.html'
  version '2.1.0'
  license 'GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url "https://www.gnupg.org/ftp/gcrypt/gpgme/gpgme-#{version}.tar.bz2"
  source_sha256 '841c5ea53fc26259f4fbf0e8bde982dea1b8a1ca0cb77e681c82b050566bf92b'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '862bf548f985881713c690b46cca6178d0b4a10f94c863d0b738f344c6df53d3',
     armv7l: '862bf548f985881713c690b46cca6178d0b4a10f94c863d0b738f344c6df53d3',
       i686: '9e5ad96650d775cfd6d2d67b234119da60af76e93110e6370ad72cc38c417145',
     x86_64: 'ac257a9d9b0086fdbaa0bc50d21a83cae171983821c76d1e12ffd4090600e3d1'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gnupg' => :logical
  depends_on 'libassuan' => :library
  depends_on 'libgpg_error' => :library
end
