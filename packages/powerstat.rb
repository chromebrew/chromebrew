require 'package'

class Powerstat < Package
  description 'Powerstat measures the power consumption of a laptop using the ACPI battery information.'
  homepage 'https://kernel.ubuntu.com/~cking/powerstat/'
  version '0.02.24'
  compatibility 'all'
  source_url 'https://kernel.ubuntu.com/~cking/tarballs/powerstat/powerstat-0.02.24.tar.gz'
  source_sha256 '12781cb108be1fc3be5ec893e6d025bfb40ada060bdc5f7715b65397620f2c7b'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/powerstat-0.02.24-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/powerstat-0.02.24-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/powerstat-0.02.24-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/powerstat-0.02.24-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '76653569b562862ac42fd13a04a0f89b450da94450b6a25eccb7e1e399267dcb',
     armv7l: '76653569b562862ac42fd13a04a0f89b450da94450b6a25eccb7e1e399267dcb',
       i686: '69f76808c40ed957f30738fbb0e76d50a592ec610f8d58ca117e6daceee8e51f',
     x86_64: '1be1187a936d8e2c0bbe20ad45a350c8b63ce75ef77ee63fd7bbe0b33690c541',
  })

  def self.build
    system "sed -i 's,/usr,#{CREW_PREFIX},g' Makefile"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
