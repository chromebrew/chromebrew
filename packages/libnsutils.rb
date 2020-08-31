require 'package'

class Libnsutils < Package
  description 'CSS parser and selection engine, written in C'
  homepage 'https://www.netsurf-browser.org'
  version '0.1.0'
  compatibility 'all'
  source_url 'https://download.netsurf-browser.org/libs/releases/libnsutils-0.1.0-src.tar.gz'
  source_sha256 '790c6516344abe82f6289d656392e9ccebe475b20cc7e1e2d843011385f7aef0'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libnsutils-0.1.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libnsutils-0.1.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libnsutils-0.1.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libnsutils-0.1.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'ef293ef4867289c24fee1e31a382d6d0091f5a69e3a1f7c02c1d3dba8cf09d5c',
     armv7l: 'ef293ef4867289c24fee1e31a382d6d0091f5a69e3a1f7c02c1d3dba8cf09d5c',
       i686: 'f02f7469190685bb06d1c0aed2378195363183db3a62cd6c3cb37d7f032364d6',
     x86_64: '503ce72a465a355da07ebdd96d6e3b6116d80e79e1cb4bd9fc9c0c928951c124',
  })

  def self.build
    system "make PREFIX=#{CREW_PREFIX} COMPONENT_TYPE=lib-shared"
  end

  def self.install
    system "make install PREFIX=#{CREW_PREFIX} COMPONENT_TYPE=lib-shared DESTDIR=#{CREW_DEST_DIR}"
    case ARCH
    when 'x86_64'
      Dir.chdir CREW_DEST_PREFIX do
        FileUtils.mv 'lib/', 'lib64/'
      end
    end
  end
end
