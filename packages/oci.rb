require 'package'

class Oci < Package
  description 'Command Line Interface for Oracle Cloud Infrastructure'
  homepage 'https://github.com/oracle/oci-cli'
  version '2.4.23'
  compatibility 'i686,x86_64'
  case ARCH
  when 'i686', 'x86_64'
    source_url 'https://github.com/oracle/oci-cli/releases/download/v2.4.23/oci-cli-2.4.23.zip'
    source_sha256 '84e6b312497c891144a0c32068097226c396a5a2467ebef3d00f55eb91228863'
    depends_on 'virtualenv'
  end

  binary_url ({
      i686: 'https://dl.bintray.com/chromebrew/chromebrew/oci-2.4.23-chromeos-i686.tar.xz',
    x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/oci-2.4.23-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
      i686: '541ead165b4ff71b8bea745779f68057a6f79b67da838369a8d9a94ed22b66b6',
    x86_64: 'c99356e8373dde7f00b3a24351e0eacdaf2037b47d30f52fedfc7c2233a2300b',
  })

  def self.install
    system "pip3 install oci_cli-*-py2.py3-none-any.whl --root #{CREW_DEST_DIR} --prefix #{CREW_PREFIX}"
    system "pip3 install oci_cli --root #{CREW_DEST_DIR} --prefix #{CREW_PREFIX}"
  end

  def self.postinstall
    puts
    puts "To complete the installation, setup a virtualenvs directory:".lightblue
    puts
    puts "mkdir ~/virtualenvs".lightblue
    puts "virtualenv ~/virtualenvs/testenv".lightblue
    puts
    puts "Replace 'testenv' with the name of the environment you want to create.".lightblue
    puts
    puts "For more information, see https://docs.us-phoenix-1.oraclecloud.com/Content/API/SDKDocs/cliusing.htm.".lightblue
    puts
  end
end
