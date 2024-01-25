require 'package'

class Gwt < Package
  description 'Google Web Toolkit'
  homepage 'http://www.gwtproject.org/'
  version '2.8.2'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://storage.googleapis.com/gwt-releases/gwt-2.8.2.zip'
  source_sha256 '970701dacc55170088f5eb327137cb4a7581ebb4734188dfcc2fad9941745d1b'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: 'abb5a99c68ece5bac1c17b336fc6178ddee1b870a4e3491af31c1695a9b9d70d',
     armv7l: 'abb5a99c68ece5bac1c17b336fc6178ddee1b870a4e3491af31c1695a9b9d70d',
       i686: '533e96845f196c95510cec486bf4cd4f173a88b298a104eb6f8f9713a24f665b',
     x86_64: 'ec69121900cf3370ad358465158e76967e5998a006604e522b102836c754f92b'
  })

  depends_on 'ant'
  depends_on 'unzip' => :build

  def self.install
    system 'rm -f *.cmd'
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    system "mkdir -p #{CREW_DEST_PREFIX}/share/gwt"
    system "cp -r . #{CREW_DEST_PREFIX}/share/gwt"
    Dir.chdir "#{CREW_DEST_PREFIX}/bin" do
      File.write 'i18nCreator', <<~EOF, perm: 0o755
        #!/bin/bash
        cd #{CREW_PREFIX}/share/gwt
        ./i18nCreator "$@"
      EOF

      File.write 'webAppCreator', <<~EOF, perm: 0o755
        #!/bin/bash
        cd #{CREW_PREFIX}/share/gwt
        ./webAppCreator "$@"
      EOF
    end
  end

  def self.postinstall
    puts
    puts 'To uninstall completely including projects, execute the following:'.lightblue
    puts 'crew remove gwt'.lightblue
    puts "rm -rf #{CREW_PREFIX}/share/gwt".lightblue
    puts
  end
end
