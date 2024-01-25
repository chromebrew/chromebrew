# Adapted from Arch Linux libwpd PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/libwpd/trunk/PKGBUILD

require 'package'

class Libwpd < Package
  description 'Library for importing WordPerfect tm documents'
  homepage 'https://libwpd.sourceforge.net/'
  version '0.10.3'
  license 'LGPL'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/sourceforge/libwpd/libwpd-0.10.3.tar.xz'
  source_sha256 '2465b0b662fdc5d4e3bebcdc9a79027713fb629ca2bff04a3c9251fdec42dd09'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7a4d5834941571f13ad15e7564b2ec780514f086e96620924516cde800fe422c',
     armv7l: '7a4d5834941571f13ad15e7564b2ec780514f086e96620924516cde800fe422c',
       i686: '1d0aacfcb3db543c644fef06b3d04c4431686826b1578f619c0f1d4059a7c7a1',
     x86_64: '94f5db8b8e15651c00a01020db0412d6a837c203952f083dbb21ce4138cb698a'
  })

  depends_on 'libgsf' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'librevenge' # R
  depends_on 'zlibpkg' # R

  def self.patch
    downloader 'https://raw.githubusercontent.com/archlinux/svntogit-packages/packages/libwpd/trunk/libwpd-gcc11.patch',
               '7612c36e5e16df2b786fc4c905f096a6e7d600aade292e91950607bfbfba6c32'
    system 'patch -Np1 -i libwpd-gcc11.patch'
  end

  def self.build
    system "./configure #{CREW_OPTIONS} --disable-static"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
