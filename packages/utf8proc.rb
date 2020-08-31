require 'package'

class Utf8proc < Package
  description 'a clean C library for processing UTF-8 Unicode data: normalization, case-folding, graphemes, and more'
  homepage 'https://julialang.org/utf8proc/'
  version '2.5.0'
  compatibility 'all'
  source_url 'https://github.com/JuliaStrings/utf8proc/archive/v2.5.0.tar.gz'
  source_sha256 'd4e8dfc898cfd062493cb7f42d95d70ccdd3a4cd4d90bec0c71b47cca688f1be'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/utf8proc-2.5.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/utf8proc-2.5.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/utf8proc-2.5.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/utf8proc-2.5.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '9ebbd94d6221173beb34f0c80f62d38d557d87ceceac29d9ee7cfd96f6ccbfb2',
     armv7l: '9ebbd94d6221173beb34f0c80f62d38d557d87ceceac29d9ee7cfd96f6ccbfb2',
       i686: '5a8ba1b61b76ce238665c679c00ea25d35815e0bc66cdce0d506227314d90cb9',
     x86_64: '93e528e8c0e6dbce7a76f0120ceca9de33ad168718893a3a1e16d28514617813',
  })

  def self.build
    system 'make'
  end

  def self.install
    system 'make', "PREFIX=#{CREW_PREFIX}", "LIBDIR=#{CREW_LIB_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", 'install'
    case ARCH
    when 'x86_64'
      Dir.chdir "#{CREW_DEST_PREFIX}" do
        FileUtils.mv 'lib/', 'lib64/'
      end
    end
  end
end
