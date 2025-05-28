require 'buildsystems/autotools'
require 'convenience_functions'

class Libcaca < Autotools
  description 'libcaca is a graphics library that outputs text instead of pixels, so that it can work on older video cards or text terminals.'
  homepage 'https://github.com/cacalabs/libcaca'
  version "0.99.beta20-f42aa68-1-#{CREW_PY_VER}"
  license 'GPL-2, ISC, LGPL-2.1 and WTFPL'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/cacalabs/libcaca/archive/f42aa68fc798db63b7b2a789ae8cf5b90b57b752.zip'
  source_sha256 'a0d0afd5cc9733510f20dab2fcd59256c960b091307e37c921f158629204bfe0'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8b2eb8981ef4951c62fbfd6160903b6d6c639e2fa80f381679045830744992e9',
     armv7l: '8b2eb8981ef4951c62fbfd6160903b6d6c639e2fa80f381679045830744992e9',
     x86_64: 'cbda913f155d8c0efee4fed8e173100e604cc0fc0df00a5311cd730071386c5f'
  })

  depends_on 'freeglut' # R
  depends_on 'freetype' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'imlib2' # R
  depends_on 'libbsd' # R
  depends_on 'libglu' # R
  depends_on 'libglvnd' # R
  depends_on 'libmd' # R
  depends_on 'libx11' # R
  depends_on 'libxau' # R
  depends_on 'libxcb' # R
  depends_on 'libxdmcp' # R
  depends_on 'libxext' # R
  depends_on 'mesa' => :build
  depends_on 'ncurses' # R
  depends_on 'python3'
  depends_on 'ruby' # R
  depends_on 'slang' # R
  depends_on 'zlib' # R

  def self.patch
    downloader 'https://patch-diff.githubusercontent.com/raw/cacalabs/libcaca/pull/66.patch',
               'd8a8f7347c5cb7b1f63ef4ef112d7fecd9d39d1703f27fccfab10709fc284d51'
    system 'patch -Np1 -i 66.patch'
    downloader 'https://patch-diff.githubusercontent.com/raw/cacalabs/libcaca/pull/70.patch',
               '173778700c92338a7b6d9f139053574359dd28829c8cdf8418df81632e002b6a'
    system 'patch -Np1 -i 70.patch'
    downloader 'https://patch-diff.githubusercontent.com/raw/cacalabs/libcaca/pull/81.patch',
               '99917c0bc6b0405c8a8a8f4ce8e0df46182ff4db96d6ffb4edbb19ec2ed24b8d'
    system 'patch -Np1 -i 81.patch'
  end

  def self.prebuild
    ConvenienceFunctions.libtoolize('freetype')
  end

  autotools_configure_options '--disable-ruby \
      --enable-gl \
      --enable-ncurses \
      --enable-network \
      --enable-slang \
      --enable-x11'
end
