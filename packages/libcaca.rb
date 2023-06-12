require 'package'

class Libcaca < Package
  description 'libcaca is a graphics library that outputs text instead of pixels, so that it can work on older video cards or text terminals.'
  homepage 'https://github.com/cacalabs/libcaca'
  @_ver = '0.99.beta20-f42aa68'
  version "#{@_ver}-py3.11"
  license 'GPL-2, ISC, LGPL-2.1 and WTFPL'
  compatibility 'all'
  source_url 'https://github.com/cacalabs/libcaca/archive/f42aa68fc798db63b7b2a789ae8cf5b90b57b752.zip'
  source_sha256 'a0d0afd5cc9733510f20dab2fcd59256c960b091307e37c921f158629204bfe0'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcaca/0.99.beta20-f42aa68-py3.11_armv7l/libcaca-0.99.beta20-f42aa68-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcaca/0.99.beta20-f42aa68-py3.11_armv7l/libcaca-0.99.beta20-f42aa68-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcaca/0.99.beta20-f42aa68-py3.11_i686/libcaca-0.99.beta20-f42aa68-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcaca/0.99.beta20-f42aa68-py3.11_x86_64/libcaca-0.99.beta20-f42aa68-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '211c2ec4d981c1e47d1015a0821624c123bda2eda9aa716aa69abd338b33d550',
     armv7l: '211c2ec4d981c1e47d1015a0821624c123bda2eda9aa716aa69abd338b33d550',
       i686: '1142dec256a94e8d41f4429944ce3179e77c24465a4d40a5034944ddd1082d11',
     x86_64: '04d88b05f4316101aff2d5f7d6e98b0a61ad28566a69b87962fda91528dd3c84'
  })

  depends_on 'freeglut' # R
  depends_on 'freetype' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'imlib2'
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
  depends_on 'zlibpkg' # R

  def self.patch
    downloader 'https://patch-diff.githubusercontent.com/raw/cacalabs/libcaca/pull/66.patch',
               'd8a8f7347c5cb7b1f63ef4ef112d7fecd9d39d1703f27fccfab10709fc284d51'
    system 'patch -Np1 -i 66.patch'
    downloader 'https://patch-diff.githubusercontent.com/raw/cacalabs/libcaca/pull/70.patch',
               '173778700c92338a7b6d9f139053574359dd28829c8cdf8418df81632e002b6a'
    system 'patch -Np1 -i 70.patch'
  end

  def self.build
    system '[ -x configure ] || ./bootstrap'
    system "./configure \
      #{CREW_OPTIONS} \
      --enable-gl \
      --enable-ncurses \
      --enable-network \
      --enable-slang \
      --enable-x11"

    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
