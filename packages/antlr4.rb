require 'package'

class Antlr4 < Package
  description 'ANTLR (ANother Tool for Language Recognition) is a powerful parser generator for reading, processing, executing, or translating structured text or binary files.'
  homepage 'https://www.antlr.org/'
  version '4.7.1-1'
  license 'BSD'
  compatibility 'all'
  source_url 'https://raw.githubusercontent.com/antlr/antlr4/4.7.1/README.md'
  source_sha256 '70a58ea4c4f5ed23306313782bc13f36c3529d9a990e95ab273d5deed9286d4f'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'jdk8'

  def self.install
    system 'curl -#LO https://www.antlr.org/download/antlr-4.7.1-complete.jar'
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('antlr-4.7.1-complete.jar') ) == 'f41dce7441d523baf9769cb7756a00f27a4b67e55aacab44525541f62d7f6688'
    system "install -Dm644 antlr-4.7.1-complete.jar #{CREW_DEST_LIB_PREFIX}/antlr-4.7.1-complete.jar"

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
    @env = <<~EOF
      # ANTLR (ANother Tool for Language Recognition) configuration
      CLASSPATH=\".:#{CREW_LIB_PREFIX}/antlr-4.7.1-complete.jar:$CLASSPATH\"
      alias antlr4=\"java -jar #{CREW_LIB_PREFIX}/antlr-4.7.1-complete.jar\"
      alias grun=\"java org.antlr.v4.gui.TestRig\"
    EOF
    IO.write("#{CREW_DEST_PREFIX}/etc/env.d/antlr4", @env)
  end
end
