require 'package'

class Pdftk < Package
  description 'PDFtk is a simple tool for doing everyday things with PDF documents.'
  homepage 'https://www.pdflabs.com/tools/pdftk-the-pdf-toolkit/'
  version '3.2.2'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://gitlab.com/pdftk-java/pdftk/-/archive/v3.2.2/pdftk-v3.2.2.tar.bz2'
  source_sha256 'b315f1267947af337c0d1e8253fba26108eed6392b43633fe967093f42ad45eb'

  binary_url ({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pdftk/3.2.2_armv7l/pdftk-3.2.2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pdftk/3.2.2_armv7l/pdftk-3.2.2-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pdftk/3.2.2_i686/pdftk-3.2.2-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pdftk/3.2.2_x86_64/pdftk-3.2.2-chromeos-x86_64.tpxz',
  })
  binary_sha256 ({
    aarch64: '543fa66938dc6604d579a7570fe89bf043c471b5976d217031b19244f522d432',
     armv7l: '543fa66938dc6604d579a7570fe89bf043c471b5976d217031b19244f522d432',
       i686: '1611c0ecc0566e7e29fecb1ce1128153d2716698fae67f2107cffaea7350953c',
     x86_64: '7efc1211d25ae0fa57342bc8f22298480c3366285e4673e2c2552a9491300bba',
  })

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
