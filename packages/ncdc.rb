require 'buildsystems/autotools'

class Ncdc < Autotools
  description 'Ncdc is a modern and lightweight direct connect client with a friendly ncurses interface.'
  homepage 'https://dev.yorhel.nl/ncdc'
  version '1.25'
  license 'MIT'
  compatibility 'all'
  source_url "https://dev.yorhel.nl/download/ncdc-#{version}.tar.gz"
  source_sha256 'b9be58e7dbe677f2ac1c472f6e76fad618a65e2f8bf1c7b9d3d97bc169feb740'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '99096c1af84e886ea58f55f68132a375016825d87b8b483e533a53f1b197e14f',
     armv7l: '99096c1af84e886ea58f55f68132a375016825d87b8b483e533a53f1b197e14f',
       i686: '76f487fe4a0130551563328e9ea0886309bbaab13b5666b7bec6c6963ea3e28a',
     x86_64: '59c4c5834ed95e77cc1b4a1ca7dcb1ec89472df025e3584fcf5e3696f450137c'
  })

  depends_on 'bzip2' => :executable
  depends_on 'geoip' => :executable
  depends_on 'glib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'gnutls' => :executable
  depends_on 'libmaxminddb' => :executable
  depends_on 'ncurses' => :executable
  depends_on 'sqlite' => :executable
  depends_on 'zlib' => :executable

  autotools_pre_configure_options "CPPFLAGS='-I#{CREW_PREFIX}/include/ncursesw'"
  autotools_configure_options '--with-geoip'
end
