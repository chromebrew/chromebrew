require 'package'

class Psutil < Package
  description 'psutil (process and system utilities) is a cross-platform library for retrieving information on running processes and system utilization in Python.'
  homepage 'https://github.com/giampaolo/psutil'
  version '5.8.0'
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/giampaolo/psutil/archive/refs/tags/release-5.8.0.tar.gz'
  source_sha256 'c015248da36109ffaa15f46fce8c0003f678cfaa408090f466c80318885e7abf'

  def self.install
    system "pip install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR} -I psutil==#{version} --no-warn-script-location"
  end
end
