require 'package'

class Antlr4 < Package
  description 'ANTLR (ANother Tool for Language Recognition) is a powerful parser generator for reading, processing, executing, or translating structured text or binary files.'
  homepage 'https://www.antlr.org/'
  version '4.12.0'
  license 'BSD'
  compatibility 'all'
  source_url 'https://www.antlr.org/download/antlr-4.12.0-complete.jar'
  source_sha256 '88f18a2bfac0dde1009eda5c7dce358a52877faef7868f56223a5bcc15329e43'

  depends_on 'openjdk11'

  no_compile_needed

  def self.build
    @antlrenv = <<~ANTLR_EOF
      # ANTLR (ANother Tool for Language Recognition) configuration
      CLASSPATH=".:#{CREW_PREFIX}/share/antlr/antlr-#{version}-complete.jar:$CLASSPATH"
      alias antlr4="java -jar #{CREW_PREFIX}/share/antlr/antlr-#{version}-complete.jar"
      alias grun="java org.antlr.v4.gui.TestRig"
    ANTLR_EOF
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/antlr"
    File.write("#{CREW_DEST_PREFIX}/etc/env.d/10-antlr4", @antlrenv)
    FileUtils.install "antlr-#{version}-complete.jar", "#{CREW_DEST_PREFIX}/share/antlr", mode: 0o644
  end

  def self.postinstall
    puts "\nTo finish the installation, execute the following:".lightblue
    puts 'source ~/.bashrc'.lightblue
    puts "\nType 'antlr4' to get started.\n".lightblue
  end
end
