require 'package'

class Antlr4 < Package
  description 'ANTLR (ANother Tool for Language Recognition) is a powerful parser generator for reading, processing, executing, or translating structured text or binary files.'
  homepage 'https://www.antlr.org/'
  version '4.7.1-1'
  license 'BSD'
  compatibility 'all'
  source_url 'https://raw.githubusercontent.com/antlr/antlr4/4.7.1/README.md'
  source_sha256 '70a58ea4c4f5ed23306313782bc13f36c3529d9a990e95ab273d5deed9286d4f'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/antlr4-4.7.1-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/antlr4-4.7.1-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/antlr4-4.7.1-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/antlr4-4.7.1-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '13ba681685e80cfc70ca3346d42038c7798eb71a867ebbeaefbe92aa4bcd63ac',
     armv7l: '13ba681685e80cfc70ca3346d42038c7798eb71a867ebbeaefbe92aa4bcd63ac',
       i686: '621f4cc8a6c8cf696c01c3694d1507cd51a313ee9dde90646b60de1152b143cc',
     x86_64: 'dd474ad8ab5eb164714dfa647a6e6faba701228f2bc8d89d6af77437d5829d2b'
  })

  depends_on 'jdk8'

  def self.install
    system 'curl -#LO https://www.antlr.org/download/antlr-4.7.1-complete.jar'
    unless Digest::SHA256.hexdigest(File.read('antlr-4.7.1-complete.jar')) == 'f41dce7441d523baf9769cb7756a00f27a4b67e55aacab44525541f62d7f6688'
      abort 'Checksum mismatch. :/ Try again.'.lightred
    end
    system "install -Dm644 antlr-4.7.1-complete.jar #{CREW_DEST_LIB_PREFIX}/antlr-4.7.1-complete.jar"

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
    @antlrenv = <<~ANTLR_EOF
      # ANTLR (ANother Tool for Language Recognition) configuration
      export CLASSPATH=\".:#{CREW_LIB_PREFIX}/antlr-4.7.1-complete.jar:\$CLASSPATH\"
      alias antlr4=\"java -jar #{CREW_LIB_PREFIX}/antlr-4.7.1-complete.jar\"
      alias grun=\"java org.antlr.v4.gui.TestRig\"
    ANTLR_EOF
    IO.write("#{CREW_DEST_PREFIX}/etc/env.d/antlr4", @antlrenv)
  end
end
