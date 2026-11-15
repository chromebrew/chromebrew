require 'buildsystems/autotools'

class Log4cplus < Autotools
  description 'log4cplus is a simple to use C++ logging API providing thread-safe, flexible, and arbitrarily granular control over log management and configuration.'
  homepage 'https://sourceforge.net/projects/log4cplus/'
  version '2.2.0.1'
  license 'Apache-2.0 or BSD-2'
  compatibility 'all'
  source_url "https://downloads.sourceforge.net/project/log4cplus/log4cplus-stable/#{version.sub(/\.\d+$/, '')}/log4cplus-#{version}.tar.xz"
  source_sha256 '6fc6b1b392921b048dcb0a71b5a1b46e9956bff710d288bdc9c4fc689f1a5f0b'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4d7ad5f16637166f828190777815963baf5a7ecde44d7e03f806e7009b76dde8',
     armv7l: '4d7ad5f16637166f828190777815963baf5a7ecde44d7e03f806e7009b76dde8',
       i686: '340773779f885e3c5b7318d17e619c469bb63f5ffd7f5e8abf7e040630c3819f',
     x86_64: '7e034b01ab838630ba7945845da4b2b1453cefe9b9bf1c94223e5b0b5ffa4c7a'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  autotools_configure_options '--disable-year2038' unless ARCH.eql?('x86_64')
end
