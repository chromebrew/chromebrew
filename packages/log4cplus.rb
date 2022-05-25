require 'package'

class Log4cplus < Package
  description 'log4cplus is a simple to use C++ logging API providing thread-safe, flexible, and arbitrarily granular control over log management and configuration.'
  homepage 'https://sourceforge.net/projects/log4cplus/'
  version '2.0.5'
  license 'Apache-2.0 or BSD-2'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/log4cplus/log4cplus-stable/2.0.5/log4cplus-2.0.5.tar.xz'
  source_sha256 '6046f0867ce4734f298418c7b7db0d35c27403090bb751d98e6e76aa4935f1af'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/log4cplus/2.0.5_armv7l/log4cplus-2.0.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/log4cplus/2.0.5_armv7l/log4cplus-2.0.5-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/log4cplus/2.0.5_i686/log4cplus-2.0.5-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/log4cplus/2.0.5_x86_64/log4cplus-2.0.5-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '4bab42054f71f29b8c3f6711ed6ca465de3a4a82b796f598f1a39d3af5187dd6',
     armv7l: '4bab42054f71f29b8c3f6711ed6ca465de3a4a82b796f598f1a39d3af5187dd6',
       i686: 'b4ccfd3eb86de7a875e4168b39221c338321262054a16d01eda42a3dec5a484a',
     x86_64: '543f5fd76ecaeeb6dcad62035fd8bb32f3f95a2afef36bca971da22e208557d0'
  })

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
