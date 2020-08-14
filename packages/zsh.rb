require 'package'

class Zsh < Package
  description 'Zsh is a shell designed for interactive use, although it is also a powerful scripting language.'
  homepage 'http://zsh.sourceforge.net/'
  version '5.8'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/zsh/zsh/5.8/zsh-5.8.tar.xz'
  source_sha256 'dcc4b54cc5565670a65581760261c163d720991f0d06486da61f8d839b52de27'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/zsh-5.8-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/zsh-5.8-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/zsh-5.8-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/zsh-5.8-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '8f06f08ffefdbe17a1026eab0140c74a103c3dc4b710fad9f9a158a215ba3376',
     armv7l: '8f06f08ffefdbe17a1026eab0140c74a103c3dc4b710fad9f9a158a215ba3376',
       i686: '7a1748369c926f9296b3cd9f2bfd4866c6ccdacd179882adce875f3b8ac54709',
     x86_64: '1d2aca16006b4e79c2c5d438eee0503f21933c61c7c1daeccd4995750b171ab4',
  })

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
