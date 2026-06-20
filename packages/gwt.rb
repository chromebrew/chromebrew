require 'package'

class Gwt < Package
  description 'Google Web Toolkit'
  homepage 'https://www.gwtproject.org/'
  version '2.13.1'
  license 'Apache-2.0'
  compatibility 'all'
  source_url "https://github.com/gwtproject/gwt/releases/download/#{version}/gwt-#{version}.zip"
  source_sha256 '92610f2f9b929a8625b858fe394c15351357ba32733282e79e38168ecc0d131d'

  depends_on 'ant' => :logical
  depends_on 'unzip' => :build

  no_compile_needed

  def self.patch
    # Remove Windows commands.
    FileUtils.rm_f Dir['*.cmd']
    # Adjust HOMEDIR.
    system "sed -i '2d' i18nCreator"
    system "sed -i '2iHOMEDIR=#{CREW_PREFIX}/share/gwt' i18nCreator"
    system "sed -i '2d' webAppCreator"
    system "sed -i '2iHOMEDIR=#{CREW_PREFIX}/share/gwt' webAppCreator"
  end

  def self.build
    File.write 'i18nCreator.sh', <<~EOF
      #!/bin/bash
      cd #{CREW_PREFIX}/share/gwt
      ./i18nCreator "$@"
    EOF
    File.write 'webAppCreator.sh', <<~EOF
      #!/bin/bash
      cd #{CREW_PREFIX}/share/gwt
      ./webAppCreator "$@"
    EOF
  end

  def self.install
    FileUtils.install 'i18nCreator.sh', "#{CREW_DEST_PREFIX}/bin/i18nCreator", mode: 0o755
    FileUtils.install 'webAppCreator.sh', "#{CREW_DEST_PREFIX}/bin/webAppCreator", mode: 0o755
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/gwt"
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/gwt"
  end

  def self.postremove
    config_dir = "#{CREW_PREFIX}/share/gwt"
    if Dir.exist?(config_dir)
      puts "WARNING: This will remove all interfaces in #{config_dir}!".orange
      Package.agree_to_remove(config_dir)
    end
  end
end
