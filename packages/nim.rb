require 'package'

class Nim < Package
  description 'Nim is a statically typed compiled systems programming language.'
  homepage 'https://nim-lang.org/'
  version '1.0.4'
  source_url 'https://nim-lang.org/download/nim-1.0.4.tar.xz'
  source_sha256 '89841545a14475911bb84616bcd5a1b93a3268e1a6a0089f54642e405eeaaee0'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/nim-1.0.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/nim-1.0.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/nim-1.0.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/nim-1.0.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '920e361cd01578ee262ad33aa0f3504d75f497faf076929a8086040e02d1d272',
     armv7l: '920e361cd01578ee262ad33aa0f3504d75f497faf076929a8086040e02d1d272',
       i686: '519c6781965966f6ed12c619c21893cf51ea34b99ef4f5c987887b3b68ae594a',
     x86_64: '9e9c318e33f264eee54e70d490048c84d3629fec6820d73f7b863713534cbd62',
  })

  depends_on 'pcre'

  def self.build
    if ARCH == 'aarch64'
      system 'sed -i "s,^ucpu=.*,ucpu=\"arm\"," build.sh'
    end
    system 'sh build.sh'
    system 'bin/nim c koch'
    system './koch tools'
  end

  def self.install
    system 'sed -i "s,/usr/local,' + CREW_DEST_PREFIX + ',g" install.sh'
    system "sh install.sh #{CREW_DEST_PREFIX}"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.ln_s "#{CREW_PREFIX}/nim/bin/nim", "#{CREW_DEST_PREFIX}/bin/nim"
  end
end
