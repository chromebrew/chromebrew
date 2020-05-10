require 'package'

class Regex_opt < Package
  description 'Perl-compatible regular expression optimizer'
  homepage 'https://bisqwit.iki.fi/source/regexopt.html'
  version '1.2.4'
  compatibility 'all'
  source_url 'https://bisqwit.iki.fi/src/arch/regex-opt-1.2.4.tar.gz'
  source_sha256 '128c8ba9570b1fd8a6a660233de2f5a4022740bc5ee300300709c3894413883f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/regex_opt-1.2.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/regex_opt-1.2.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/regex_opt-1.2.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/regex_opt-1.2.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '6a204f3e5a2dba59affe403934fd0118f7a03fba1c9567d98688cf5723a0b3dd',
     armv7l: '6a204f3e5a2dba59affe403934fd0118f7a03fba1c9567d98688cf5723a0b3dd',
       i686: '367a7f0d1863da8b01cfc0fc5885c5603da46dabaf913b82a77082b02bcedd68',
     x86_64: 'a49aaa0db5429edeb512833c3c73e96646903e8c5b2aaa0a15ef262ed62e3095',
  })

  def self.build
    system "sed -i 's,PREFIX=/usr/local,PREFIX=#{CREW_PREFIX},' Makefile"
    system "make"
  end

  def self.install
    system "install -Dm755 regex-opt #{CREW_DEST_PREFIX}/bin/regex-opt"
  end
end
