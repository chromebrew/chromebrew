require 'package'

class Setuptools < Package
  description 'Easily download, build, install, upgrade, and uninstall Python packages'
  homepage 'https://pypi.org/project/setuptools/'
  version '50.3.2'
  compatibility 'all'
  source_url 'https://github.com/pypa/setuptools/archive/v50.3.2.tar.gz'
  source_sha256 '7d97c001ce9193c6d947bc584b6a19f593e1d2dd4d6c443de3b1e545875bc132'


  depends_on 'python3'

  def self.build
    system 'python3 bootstrap.py'
  end

  def self.install
    system "python3 setup.py install --root #{CREW_DEST_DIR} --prefix #{CREW_PREFIX}"
  end
end
