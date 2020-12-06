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
    # Install pip for python2 first using last supported systemtools version (<=v45) for python27.
    system "curl -Lf https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
    python2 ./get-pip.py setuptools==44.1.1 --root=#{CREW_DEST_DIR} --prefix=#{CREW_PREFIX} "
    # Now let python3 pip install and overwrite pip, leaving pip2 for python27
    system "python3 setup.py install --root #{CREW_DEST_DIR} --prefix #{CREW_PREFIX}"
  end
end
