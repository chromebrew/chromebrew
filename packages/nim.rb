require 'package'

class Nim < Package
  description 'Nim is a statically typed compiled systems programming language.'
  homepage 'https://nim-lang.org/'
  version '1.0.4'
  source_url 'https://nim-lang.org/download/nim-1.0.4.tar.xz'
  source_sha256 '89841545a14475911bb84616bcd5a1b93a3268e1a6a0089f54642e405eeaaee0'

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
  end
end
