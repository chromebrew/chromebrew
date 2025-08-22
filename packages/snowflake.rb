require 'package'

class Snowflake < Package
  description 'Snowflake (aka Muon) is a graphical SSH client.'
  homepage 'https://github.com/subhra74/snowflake'
  version '1.0.4'
  license 'GPL-3'
  compatibility 'x86_64'
  source_url "https://github.com/subhra74/snowflake/releases/download/v#{version}/snowflake.jar"
  source_sha256 'cc1768e5ce7038d26a893e00066e4d8bed2f42c1ba75b960b324471c5eab74c1'

  depends_on 'openjdk21'
  depends_on 'sommelier'

  no_compile_needed

  def self.build
    File.write 'snowflake.sh', <<~EOF
      #!/bin/bash
      cd #{CREW_PREFIX}/share/snowflake
      java -jar snowflake.jar "$@"
    EOF
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/snowflake"
    FileUtils.mv 'snowflake.jar', "#{CREW_DEST_PREFIX}/share/snowflake"
    FileUtils.install 'snowflake.sh', "#{CREW_DEST_PREFIX}/bin/snowflake", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'snowflake' to get started.\n"
  end

  def self.postremove
    puts 'WARNING: This will remove all saved ssh sessions!'.orange
    Package.agree_to_remove("#{HOME}/snowflake-ssh")
  end
end
