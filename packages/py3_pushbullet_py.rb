require 'package'

class Py3_pushbullet_py < Package
  description 'Pushbullet.py is a simple python client for pushbullet.com'
  homepage 'https://github.com/rbrcsk/pushbullet.py/'
  version '0.12.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/rbrcsk/pushbullet.py/archive/0.12.0.tar.gz'
  source_sha256 'b6602359ecfdb041e7310f0bfc584127cea18131608d7c33a743042981680753'

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
