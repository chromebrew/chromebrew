require 'package'

class Commacd < Package
  description 'A faster way to move around (Bash 3+)'
  homepage 'https://github.com/shyiko/commacd'
  version '0.4.0-1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/shyiko/commacd/archive/v0.4.0.tar.gz'
  source_sha256 'e2db36c6c8dcd4e65cd8d2d90101d5b7aee78872ae29d2d47ab7fc3b263897cd'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: 'e988a0bb11bc431c3c8ea8fb2e18707f7189e2c008c13289095fb53c0a381eef',
     armv7l: 'e988a0bb11bc431c3c8ea8fb2e18707f7189e2c008c13289095fb53c0a381eef',
       i686: 'a995f9dcdb8b5573150bb7c7fc6a7edf0c8dd3881f95f924fef658fa51494463',
     x86_64: '5925aa1a194921e7e3e081081bc61e2f195644fea888f11c00eb5f7c9ff13947'
  })

  def self.install
    system "install -Dm644 commacd.bash #{CREW_DEST_PREFIX}/share/commacd/commacd.bash"

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/bash.d/"
    @commacdenv = <<~COMMACDEOF
      # Commacd configuration
      source #{CREW_PREFIX}/share/commacd/commacd.bash
    COMMACDEOF
    File.write("#{CREW_DEST_PREFIX}/etc/bash.d/commacd", @commacdenv)
  end
end
