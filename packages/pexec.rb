require 'package'

class Pexec < Package
  description 'The main purpose of the program pexec is to execute the given command or shell script (e.g. parsed by /bin/sh) in parallel on the local host or on remote hosts, while some of the execution parameters, namely the redirected standard input, output or error and environmental variables can be varied.'
  homepage 'https://www.gnu.org/software/pexec/'
  version '1.0rc8-1'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/pexec/pexec-1.0rc8.tar.gz'
  source_sha256 'a968e4774eef80b8b1de3c10e6c0ad2ebeeb732b10e438596f110aa6aaf94a64'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/pexec-1.0rc8-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/pexec-1.0rc8-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/pexec-1.0rc8-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/pexec-1.0rc8-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c98687da9126fcdc2a4ff0f3712ab5bc78929122216cc050650ad48d01fb3899',
     armv7l: 'c98687da9126fcdc2a4ff0f3712ab5bc78929122216cc050650ad48d01fb3899',
       i686: '9910eb0b3b202b3b1a591aedfa6df770c2a50686c73f951f57862e7a8e0856fd',
     x86_64: '15696468ef1b797e0c77cd0a1ec91766d3890072739514772cdf355124f3a1d3',
  })

  depends_on 'groff'
  depends_on 'help2man'
  depends_on 'texinfo'

  def self.build
    system './configure'
    system "sed -i '18d' Makefile"
    system "sed -i '17iprefix = #{CREW_DEST_PREFIX}' Makefile"
    system 'make'
  end

  def self.install
    system 'make install'
  end
end
