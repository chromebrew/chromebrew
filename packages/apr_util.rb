require 'buildsystems/autotools'

class Apr_util < Autotools
  description 'APR-util provides a number of helpful abstractions on top of APR.'
  homepage 'https://apache.org/dist/apr'
  version '1.6.5'
  license 'Apache-2.0'
  compatibility 'all'
  source_url "https://dlcdn.apache.org/apr/apr-util-#{version}.tar.bz2"
  source_sha256 '96de1dd6f6a0476d2d2e7964926d8c1ddc3bb0e210e1b1812d3ba5a454a392e2'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2603f0186cc0310495f73a949c78812a2ebc0934b0fa40530c15cafa10949d8f',
     armv7l: '2603f0186cc0310495f73a949c78812a2ebc0934b0fa40530c15cafa10949d8f',
       i686: '40fbfd6d7e9a46f640e51a1970cf1877d9490c4e17d0477ae7d7740c648dbf4e',
     x86_64: 'ddf0c7fd9578d3db9fc645ef587c8d138ecc5afeed01b5335ddda89ed78e7078'
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
