require 'package'

class Py3_psutil < Package
  description 'psutil (process and system utilities) is a cross-platform library for retrieving information on running processes and system utilization in Python.'
  homepage 'https://github.com/giampaolo/psutil'
  version '5.8.0-1'
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/giampaolo/psutil/archive/release-5.8.0.tar.gz'
  source_sha256 'c015248da36109ffaa15f46fce8c0003f678cfaa408090f466c80318885e7abf'

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
