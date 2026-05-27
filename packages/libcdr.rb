# Adapted from Arch Linux libcdr PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/libcdr/trunk/PKGBUILD

require 'buildsystems/autotools'

class Libcdr < Autotools
  description 'CorelDraw file format importer library for LibreOffice'
  homepage 'https://wiki.documentfoundation.org/DLP/Libraries/libcdr'
  version "0.1.9-#{CREW_ICU_VER}"
  license 'GPL2 LGPL2.1 MPL'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://dev-www.libreoffice.org/src/libcdr/libcdr-#{version.split('-')[0]}.tar.xz"
  source_sha256 'f7bb6abdd7f226820f288a93dd8d07759833c0250d9e202af90f9b312c4665a3'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7a620757a50e4b04c61770defbb111299e903767fc1a4fedb7657525bb9942f8',
     armv7l: '7a620757a50e4b04c61770defbb111299e903767fc1a4fedb7657525bb9942f8',
     x86_64: '02a0ac69218f22a9be1b80feeb9690acd5517475b8ba3da1b0db1feeb6384174'
  })

  depends_on 'boost' => :build
  depends_on 'cppunit' => :build
  depends_on 'doxygen' => :build
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'icu4c' => :library
  depends_on 'lcms' => :library
  depends_on 'librevenge' => :library
  depends_on 'libwpg' => :build
  depends_on 'zlib' => :library
end
