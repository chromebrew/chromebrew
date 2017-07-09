require 'package'

class Pexec < Package
  description 'The main purpose of the program pexec is to execute the given command or shell script (e.g. parsed by /bin/sh) in parallel on the local host or on remote hosts, while some of the execution parameters, namely the redirected standard input, output or error and environmental variables can be varied.'
  homepage 'https://www.gnu.org/software/pexec/'
  version '1.0rc8'
  source_url 'https://ftp.gnu.org/gnu/pexec/pexec-1.0rc8.tar.gz'
  source_sha256 'a968e4774eef80b8b1de3c10e6c0ad2ebeeb732b10e438596f110aa6aaf94a64'

  binary_url ({
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/pexec-1.0rc8-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/pexec-1.0rc8-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
       i686: 'a42760aed2f785556aff25828bf9d084193507cb7e9fdb82682968e616d1b558',
     x86_64: '1b44e24f07e71491e7d304c96f81238ea087df5776fa241cce5b08dff395428c',
  })

  depends_on 'groff'
  depends_on 'help2man'

  def self.build
    system './configure'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
