require 'package'

class C2x < Package
  description 'C2X-CMD is a generic freeware converter for converting CSV files to XML files.'
  homepage 'http://www.jens-goedeke.eu/tools/csv2xml/'
  version '1.8.0'
  license 'freeware'
  compatibility 'x86_64'
  source_url 'http://www.goedeke.net/c2x-cmd/c2x-cmd-linux-amd64.tar.gz'
  source_sha256 'f09655c732ae694f22791be89d836ddde05d3690ec44a6f096aa6bf870b2924b'

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'openjdk21' # R

  no_compile_needed

  def self.build
    downloader 'http://www.goedeke.net/c2x-cmd/c2x-wizard.tar.gz',
               'fec56819942443ada715ee3483cb705bedea783158522213411b5fb8b6143f62'
    system 'tar xvf c2x-wizard.tar.gz'
    FileUtils.rm %w[c2x-wizard.tar.gz c2x-wizard.sh]
    system './get_manuals.sh'
    c2x = <<~EOF
      #!/bin/bash
      java -jar #{CREW_PREFIX}/share/c2x/c2x-wizard.jar
    EOF
    File.write('c2x-wizard.sh', c2x)
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/c2x"
    FileUtils.install 'c2x-wizard.sh', "#{CREW_DEST_PREFIX}/bin/c2x-wizard", mode: 0o755
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/c2x"
    FileUtils.ln_s "#{CREW_PREFIX}/share/c2x/csv2xml", "#{CREW_DEST_PREFIX}/bin/csv2xml"
    FileUtils.ln_s "#{CREW_PREFIX}/share/c2x/c2x-cmd", "#{CREW_DEST_PREFIX}/bin/c2x-cmd"
  end

  def self.postinstall
    puts "\nType 'c2x-cmd -?' to get started.\n".lightblue
    puts "Type 'c2x-wizard' to start the wizard.\n".lightblue
    puts 'To view the manuals, execute the following:'.lightblue
    puts 'crew install zathura'.lightblue
    puts "zathura #{CREW_PREFIX}/share/c2x/c2x-cmd-manual.pdf".lightblue
    puts "zathura #{CREW_PREFIX}/share/c2x/c2x-wizard-manual.pdf\n".lightblue
  end
end
