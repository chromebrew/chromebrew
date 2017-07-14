require 'package'

class Pexec < Package
  description 'The main purpose of the program pexec is to execute the given command or shell script (e.g. parsed by /bin/sh) in parallel on the local host or on remote hosts, while some of the execution parameters, namely the redirected standard input, output or error and environmental variables can be varied.'
  homepage 'https://www.gnu.org/software/pexec/'
  version '1.0rc8'
  source_url 'https://ftp.gnu.org/gnu/pexec/pexec-1.0rc8.tar.gz'
  source_sha256 'a968e4774eef80b8b1de3c10e6c0ad2ebeeb732b10e438596f110aa6aaf94a64'

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
