require 'package'

class Upm < Package
  description 'Universal Password Manager (UPM) allows you to store usernames, passwords, URLs and generic notes in an encrypted database protected by one master password.'
  homepage 'http://upm.sourceforge.net/'
  version '1.15.1'
  license 'GPL-2'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://downloads.sourceforge.net/project/upm/upm-1.15.1/upm-1.15.1.tar.gz'
  source_sha256 'c8ade41ec0fe6f387f6e44b941ce5f17a3c2e2d096b4be766bed29ee606ac078'

  depends_on 'jdk8'
  depends_on 'sommelier'

  def self.build
    upm = <<~EOF
      #!/bin/bash
      cd #{CREW_PREFIX}/share/upm
      ./upm.sh "$@"
    EOF
    File.write('upm', upm)
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/upm"
    FileUtils.cp_r Dir['.'], "#{CREW_DEST_PREFIX}/share/upm"
    FileUtils.install 'upm', "#{CREW_DEST_PREFIX}/bin/upm", mode: 0o755
  end
end
