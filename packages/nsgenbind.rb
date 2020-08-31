require 'package'

class Nsgenbind < Package
  description 'Tool to generate javascript to dom bindings from w3c webid files'
  homepage 'https://www.netsurf-browser.org'
  version '0.8'
  compatibility 'all'
  source_url 'https://download.netsurf-browser.org/libs/releases/nsgenbind-0.8-src.tar.gz'
  source_sha256 '4d8d53ad000ada712772365e6a73eb8fc5ce97584af9c865ac5b26a2187f1cb3'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/nsgenbind-0.8-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/nsgenbind-0.8-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/nsgenbind-0.8-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/nsgenbind-0.8-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '51a88fadaf90448c2ecac5213230cc0b18909832635e80d3eeb7ed00b3126e66',
     armv7l: '51a88fadaf90448c2ecac5213230cc0b18909832635e80d3eeb7ed00b3126e66',
       i686: '75b76a23ed86c489ac54d4aee6ecfcbc88404fd229d0e60846a6c274256972d2',
     x86_64: '5f288d1f5ec7c781e2a7a326d9c618e6af60e6d5b643388f2349b30a641d951a',
  })

  depends_on 'netsurf_buildsystem' => :build

  def self.build
    system "make FLEX=flex BISON=bison PREFIX=#{CREW_PREFIX}"
  end

  def self.install
    system "make install PREFIX=#{CREW_PREFIX} DESTDIR=#{CREW_DEST_DIR}"
  end
end
