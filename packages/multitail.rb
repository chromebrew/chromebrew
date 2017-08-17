require 'package'

class Multitail < Package
  description 'MultiTail allows you to monitor logfiles and command output in multiple windows in a terminal, colorize, filter and merge.'
  homepage 'https://www.vanheusden.com/multitail/'
  version '6.4.2'
  source_url 'https://www.vanheusden.com/multitail/multitail-6.4.2.tgz'
  source_sha256 'af1d5458a78ad3b747c5eeb135b19bdca281ce414cefdc6ea0cff6d913caa1fd'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/multitail-6.4.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/multitail-6.4.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/multitail-6.4.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/multitail-6.4.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '190f218c2ddd9ddf687e68012103dc41a2591e8ad5684cc6704ade8d5c9e4d17',
     armv7l: '190f218c2ddd9ddf687e68012103dc41a2591e8ad5684cc6704ade8d5c9e4d17',
       i686: '0a9cf6346932b62c1e9053a917b8ac799f202f255eeda444178d5c60c2e4fcff',
     x86_64: '52a90a8a16d8b471aa369a62191e766082e70a88eed84e1eb1afbf267a351d0d',
  })

  depends_on 'ncursesw'

  def self.build
    system 'make'
  end

  def self.install
    system "make", "PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
