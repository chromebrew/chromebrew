require 'package' 

class Json2xml < Package
  description 'json to xml converter'
  homepage 'https://github.com/vinitkumar/json2xml'
  version '2.1.0-1'
  compatibility 'all'
  source_url 'https://github.com/vinitkumar/json2xml/archive/v2.1.0.tar.gz'
  source_sha256 '61c7c848f7dc74d09ecc10badaa69902859483ea4e3b13148a83173af564aeea'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/json2xml-2.1.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/json2xml-2.1.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/json2xml-2.1.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/json2xml-2.1.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'a7456faac3802bfffa003a845d7f7f12869e02796542b97b0539940ca6222061',
     armv7l: 'a7456faac3802bfffa003a845d7f7f12869e02796542b97b0539940ca6222061',
       i686: 'ed8b21bbcc5b6bc8d92eb5e36ff827de365e21a70c30537cf955dfb096833f8b',
     x86_64: 'cea573afae8c6f6439610041160f11aef73988eac87708d875b5be0cbef77043',
  })

  depends_on 'libxslt'
  depends_on 'setuptools'

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
    system "CFLAGS=-I#{CREW_PREFIX}/include/libxml2 pip3 install . --root #{CREW_DEST_DIR} --prefix #{CREW_PREFIX}"
  end
end
