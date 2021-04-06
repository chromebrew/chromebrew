require 'package'

class Oci_cli < Package
  description 'oci-cli is the Command Line Interface for Oracle Cloud Infrastructure'
  homepage 'https://docs.cloud.oracle.com/Content/API/Concepts/cliconcepts.htm'
  version '2.22.1'
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'i686,x86_64'
  case ARCH
  when 'i686', 'x86_64'
    source_url 'https://github.com/oracle/oci-cli/archive/v2.22.1.tar.gz'
    source_sha256 '008b3e612d5bcfc11d27fb274a5efe289e8ce30d68b4a1ea6c7d73eb5782d370'

    depends_on 'py3_arrow'
    depends_on 'py3_click'
    depends_on 'py3_cffi'
    depends_on 'py3_configparser'
    depends_on 'py3_jmespath'
    depends_on 'py3_oci'
    depends_on 'py3_pyopenssl'
    depends_on 'py3_retrying'
    depends_on 'py3_terminaltables'
    depends_on 'py3_virtualenv'
    depends_on 'py3_pyyaml'
    depends_on 'py3_setuptools' => :build
  end

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
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
