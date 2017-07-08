require 'package'

class Pip < Package
  description 'The PyPA recommended tool for installing Python packages.'
  homepage 'https://pip.pypa.io/'
  version '9.0.1'
  source_url 'https://github.com/pypa/pip/archive/9.0.1.tar.gz'
  source_sha256 'd03fabbc4fbf2fbfc2f97307960aef2b3ca4c880ecda993dcc35957e33d7cd76'

  depends_on 'python' unless File.exists? '/usr/local/bin/python'

  def self.install
    system "wget https://bootstrap.pypa.io/get-pip.py"
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/bin"
    system "python get-pip.py -I -b #{CREW_DEST_DIR}/usr/local"
    system "cp /usr/local/bin/pip* #{CREW_DEST_DIR}/usr/local/bin"
  end
end
