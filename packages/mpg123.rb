require 'buildsystems/autotools'

class Mpg123 < Autotools
  description 'Fast console MPEG Audio Player and decoder library.'
  homepage 'http://www.mpg123.org/'
  version '1.33.6'
  license 'GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url "https://sourceforge.net/projects/mpg123/files/mpg123/#{version}/mpg123-#{version}.tar.bz2"
  source_sha256 '929a7c18ba662b8927aed4de229ad9ae8ab2b4806dd0f30b90113eb1b4e2195a'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a553b6184906f57c17b0783c780882b643ddee8ccfffe9fe9788cd0d3592597c',
     armv7l: 'a553b6184906f57c17b0783c780882b643ddee8ccfffe9fe9788cd0d3592597c',
       i686: '471e4c0bec3bc22faeceab652ed794f50b3c33d303a44e503dd5bc285fd63c0a',
     x86_64: '84f446be131d1a27fd61429f435a11ba515a6ebcd8b0e5fca14025338dcd40aa'
  })

  depends_on 'alsa_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  autotools_configure_options "--with-audio=alsa #{'--with-cpu=i386' if ARCH.eql?('i686')}"
end
