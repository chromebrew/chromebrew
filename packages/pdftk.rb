require 'package'

class Pdftk < Package
  description 'PDFtk is a simple tool for doing everyday things with PDF documents.'
  homepage 'https://www.pdflabs.com/tools/pdftk-the-pdf-toolkit/'
  version '3.2.2'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://gitlab.com/pdftk-java/pdftk/-/archive/v3.2.2/pdftk-v3.2.2.tar.bz2'
  source_sha256 'b315f1267947af337c0d1e8253fba26108eed6392b43633fe967093f42ad45eb'

  depends_on 'jdk8'
  depends_on 'gradle' => :build

  def self.build
    @pdftk = <<~EOF
      #!/bin/bash
      cd #{CREW_PREFIX}/share/pdftk
      java -jar pdftk-all.jar "$@"
    EOF
    File.write('pdftk.sh', @pdftk)
    system "JAVA_HOME=#{CREW_PREFIX} gradle shadowJar"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/pdftk"
    FileUtils.mv 'build/libs/pdftk-all.jar', "#{CREW_DEST_PREFIX}/share/pdftk"
    FileUtils.install 'pdftk.sh', "#{CREW_DEST_PREFIX}/bin/pdftk", mode: 0o755
  end

  def self.postinstall
    puts "\nType 'pdftk' to get started.\n".lightblue
  end
end
