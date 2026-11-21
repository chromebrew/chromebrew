require 'buildsystems/autotools'

class Libffcall < Autotools
  description 'GNU libffcall is a library which can be used to build foreign function call interfaces in embedded interpreters.'
  homepage 'https://www.gnu.org/software/libffcall/'
  version '2.6'
  license 'GPL-3+'
  compatibility 'all'
  source_url "https://ftp.gnu.org/gnu/libffcall/libffcall-#{version}.tar.gz"
  source_sha256 '7e3951d642a1884adaf7f15c60df1bf8fbde686daa9fa69df1a514471b8cff39'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '965a4937f3fd25809350d4403b21f255eec552644927da770e60fbe0bf62f220',
     armv7l: '965a4937f3fd25809350d4403b21f255eec552644927da770e60fbe0bf62f220',
       i686: '4fda7d35562cd7d18ae14dbb5e089c1b98d215551798572acea2255a53a6f2a3',
     x86_64: '47cc626e0b356fd819f3536e8a18592a8b9a7663b6cabe5215c8b52666bd5839'
  })

  depends_on 'glibc' # R

  autotools_make_j1

  autotools_configure_options '--with-pic \
                               --disable-static'
end
