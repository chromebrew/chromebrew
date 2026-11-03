require 'buildsystems/autotools'

class Apr_util < Autotools
  description 'APR-util provides a number of helpful abstractions on top of APR.'
  homepage 'https://apache.org/dist/apr'
  version '1.6.6'
  license 'Apache-2.0'
  compatibility 'all'
  source_url "https://dlcdn.apache.org/apr/apr-util-#{version}.tar.bz2"
  source_sha256 'aa77dd25f036731b7246abbfbebe6cc813b42799b62c874bc82bd4e1f90f2918'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'adb9b1172f2348bf0546a244d89f41daae8a2c72dec70a977661d280ed1cb0c1',
     armv7l: 'adb9b1172f2348bf0546a244d89f41daae8a2c72dec70a977661d280ed1cb0c1',
       i686: '0e836eeb9c014da127af272c008fefc60d0596a0a78a37b2649b6e28ce01d1b5',
     x86_64: 'cbe0adb0417f66590625bbc7b590331d3ab328a40aef9770b9a113089eaa3e0b'
  })

  depends_on 'apr' => :library
  depends_on 'expat' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libtool' => :library
  depends_on 'libxcrypt' => :library
  depends_on 'sqlite' => :library
  depends_on 'unixodbc' => :library
  depends_on 'util_linux' => :library

  autotools_configure_options "--with-apr=#{CREW_PREFIX}"

  def self.prebuild
    ConvenienceFunctions.libtoolize('libuuid', 'util_linux')
  end
end
