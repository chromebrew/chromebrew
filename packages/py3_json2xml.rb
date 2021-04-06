require 'package'

class Py3_json2xml < Package
  description 'json to xml converter'
  homepage 'https://github.com/vinitkumar/json2xml'
  version '2.1.0-1'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/vinitkumar/json2xml/archive/v2.1.0.tar.gz'
  source_sha256 '61c7c848f7dc74d09ecc10badaa69902859483ea4e3b13148a83173af564aeea'

  depends_on 'libxslt'
  depends_on 'py3_dicttoxml'
  depends_on 'py3_xmltodict'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "CFLAGS=-I#{CREW_PREFIX}/include/libxml2 python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

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
    system "CFLAGS=-I#{CREW_PREFIX}/include/libxml2 python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
