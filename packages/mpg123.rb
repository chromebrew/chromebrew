require 'buildsystems/autotools'

class Mpg123 < Autotools
  description 'Fast console MPEG Audio Player and decoder library.'
  homepage 'http://www.mpg123.org/'
  version '1.33.7'
  license 'GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url "https://sourceforge.net/projects/mpg123/files/mpg123/#{version}/mpg123-#{version}.tar.bz2"
  source_sha256 '31d0e35a4ca567ec9b5ebda6c3062bb4435d6d3eacd6ef0d95cadd7854dc03ee'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'db46b303478cbfc711a77d3b718319d2f2a3b2a982a4fd23a1cdc65ff402d360',
     armv7l: 'db46b303478cbfc711a77d3b718319d2f2a3b2a982a4fd23a1cdc65ff402d360',
       i686: 'd363c55aa38632d0e236f19fd1ebff67e4d8e631b92242ea521d4ad345f01b16',
     x86_64: 'd685185ce71f7386bb2c3cb8716a46f7f9f0ce948f0ead614eab64055b740177'
  })

  depends_on 'alsa_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  autotools_configure_options "--with-audio=alsa #{'--with-cpu=i386' if ARCH.eql?('i686')}"
end
