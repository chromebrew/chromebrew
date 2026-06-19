require 'buildsystems/autotools'

class Log4cplus < Autotools
  description 'log4cplus is a simple to use C++ logging API providing thread-safe, flexible, and arbitrarily granular control over log management and configuration.'
  homepage 'https://sourceforge.net/projects/log4cplus/'
  version '2.1.2'
  license 'Apache-2.0 or BSD-2'
  compatibility 'all'
  source_url "https://downloads.sourceforge.net/project/log4cplus/log4cplus-stable/#{version}/log4cplus-#{version}.tar.xz"
  source_sha256 'fbdabb4ef734fe1cc62169b23f0b480cc39127ac7b09b810a9c1229490d67e9e'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ab2406e8e579c35201e60ab7ac8b46eb7bb0612def03d8f4d6bf65213a77d5da',
     armv7l: 'ab2406e8e579c35201e60ab7ac8b46eb7bb0612def03d8f4d6bf65213a77d5da',
       i686: '4feed5b0f4c270770c9b7280da681a8acbaeb0e07e0b2f5f14500207611004df',
     x86_64: 'd0926fbe1829e193f7b0d79929037fcf6eda7f1edbb5a194e84895bbf6a99034'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  autotools_configure_options '--disable-year2038' unless ARCH.eql?('x86_64')
end
