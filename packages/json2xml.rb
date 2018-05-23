require 'package' 

class Json2xml < Package
  description 'json to xml converter'
  homepage 'https://github.com/vinitkumar/json2xml'
  version '2.1.0'
  source_url 'https://github.com/vinitkumar/json2xml/archive/v2.1.0.tar.gz'
  source_sha256 '61c7c848f7dc74d09ecc10badaa69902859483ea4e3b13148a83173af564aeea'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'python3'

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    Dir.chdir "#{CREW_DEST_PREFIX}/bin" do
      system "echo '#!/bin/bash' > json2xml"
      system "echo 'if test $1; then' >> json2xml"
      system "echo '  python3 -m src.cli \"$@\"' >> json2xml"
      system "echo 'else' >> json2xml"
      system "echo '  echo \"Usage: json2xml [-h] [--url URL] [--file FILE] [--data DATA]\"' >> json2xml"
      system "echo '  echo \"See https://github.com/vinitkumar/json2xml.\"' >> json2xml"
      system "echo 'fi' >> json2xml"
      system "chmod +x json2xml"
    end
    system 'pip3 install setuptools'
    system "pip3 install . --root #{CREW_DEST_DIR} --prefix #{CREW_PREFIX}"
    system 'pip3 uninstall --yes setuptools'
  end
end
