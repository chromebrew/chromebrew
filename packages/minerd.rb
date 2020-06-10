require 'package'

class Minerd < Package
  description 'CPU miner for Litecoin and Bitcoin'
  homepage 'https://github.com/pooler/cpuminer'
  version '2.5.0'
  compatibility 'all'
  source_url 'https://github.com/pooler/cpuminer/releases/download/v2.5.0/pooler-cpuminer-2.5.0.tar.gz'
  source_sha256 'ea16761a952b8f0fbba22fd16d48bb5e20abc48a10af99a00c70c332b3cb54f5'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/minerd-2.5.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/minerd-2.5.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/minerd-2.5.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/minerd-2.5.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '37f961088b95729020863d96f4718eee45159fbbdc829e23e89f3f5c8c87dade',
     armv7l: '37f961088b95729020863d96f4718eee45159fbbdc829e23e89f3f5c8c87dade',
       i686: '668b081bac76e9e239b0df9b30d39b32d97e1cd7b0c18a9b118025e7c0dbdace',
     x86_64: 'a4101c3804f18fa55f93ea0516c5deca35093064f47146ef1f398b8b1e10f343',
  })

  depends_on 'curl'
  depends_on 'jansson'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "gzip -9 #{CREW_DEST_PREFIX}/share/man/man1/minerd.1"
  end
end
