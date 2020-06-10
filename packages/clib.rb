require 'package'

class Clib < Package
  description 'C package manager-ish'
  homepage 'https://github.com/clibs/clib'
  version '1.8.1'
  compatibility 'all'
  source_url 'https://github.com/clibs/clib/archive/1.8.1.tar.gz'
  source_sha256 'f5718e316771571971cb4e5a0142f91b47c6bfe32997fd869fc5a90ec091a066'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/clib-1.8.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/clib-1.8.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/clib-1.8.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/clib-1.8.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '2e9535f72f2b36bef76aa7cbd17b4264652d94f9c46408c81a6d1400df379851',
     armv7l: '2e9535f72f2b36bef76aa7cbd17b4264652d94f9c46408c81a6d1400df379851',
       i686: '5923d5873728497d41d187697bc6ad1daeef621a6c1deecae728083a65ac2388',
     x86_64: '06c1bac595387b7eeb3e2fddd64c94d3ef6394492e4315f4604e4c4f719efeb9',
  })

  depends_on 'curl'

  def self.build
    system "sed -i 's,PREFIX ?= /usr/local,PREFIX ?= #{CREW_DEST_PREFIX},' Makefile"
    system 'make'
  end

  def self.install
    system 'make install'
    system "ln -s #{CREW_PREFIX}/bin/clib #{CREW_DEST_PREFIX}/bin/cpm"
  end
end
