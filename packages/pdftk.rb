require 'package'

class Pdftk < Package
  description 'PDFtk is a simple tool for doing everyday things with PDF documents.'
  homepage 'https://www.pdflabs.com/tools/pdftk-the-pdf-toolkit/'
  version '3.3.3'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://gitlab.com/pdftk-java/pdftk/-/archive/v3.3.3/pdftk-v3.3.3.tar.bz2'
  source_sha256 'c144e0dd388db2f5e8e0b412c0d9be6c54e4db99a4575b6058a209f3603a333d'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '72389eb077f1c4a770a330869e28638694b518167c8f301e47cc0fd623912890',
     armv7l: '72389eb077f1c4a770a330869e28638694b518167c8f301e47cc0fd623912890',
       i686: '25ecb4269be3009714e39f8e6a6e2c92c1c75f92cb10988cc14f1f63d70fb2ff',
     x86_64: '925c1d1aec21ee2fe6cfd7da07d256842ad1fba1b542389676ac40356bb8139a'
  })

  depends_on 'openjdk8'
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
