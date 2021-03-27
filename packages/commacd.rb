require 'package'

class Commacd < Package
  description 'A faster way to move around (Bash 3+)'
  homepage 'https://github.com/shyiko/commacd'
  version '0.4.0-1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/shyiko/commacd/archive/v0.4.0.tar.gz'
  source_sha256 'e2db36c6c8dcd4e65cd8d2d90101d5b7aee78872ae29d2d47ab7fc3b263897cd'

  def self.install
    system "install -Dm644 commacd.bash #{CREW_DEST_PREFIX}/share/commacd/commacd.bash"

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/bash.d/"
    @env = <<~EOF
      # Commacd configuration
      source #{CREW_PREFIX}/share/commacd/commacd.bash
    EOF
    IO.write("#{CREW_DEST_PREFIX}/etc/bash.d/commacd", @env)
  end
end
