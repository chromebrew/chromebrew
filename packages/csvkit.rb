require 'package'

class Csvkit < Package
  description 'A suite of utilities for converting to and working with CSV, the king of tabular file formats.'
  homepage 'http://csvkit.rtfd.org/'
  version '1.0.3'
  source_url 'https://github.com/wireservice/csvkit/archive/1.0.3.tar.gz'
  source_sha256 '4ca64988a648c845ad2f02a19d5736c3a2650a44b1dd8952b97b528c7f3e2a97'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/csvkit-1.0.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/csvkit-1.0.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/csvkit-1.0.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/csvkit-1.0.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e3e61392820e84a80d27937030e7e9edc05a18e6e71811316ff1ac5c44c60efa',
     armv7l: 'e3e61392820e84a80d27937030e7e9edc05a18e6e71811316ff1ac5c44c60efa',
       i686: 'b6d7d691c2e3c26f596e640db541ac9b34d4a6530b88e0125e582037e958e91e',
     x86_64: '0f56661e9e4d3d9bc7c72b1bc12d8558f8ec622e9310f18a155ac7601e2ba9e0',
  })

  depends_on 'python27'

  def self.install
    system "yes | pip install setuptools"
    system "pip install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR} -r requirements-py2.txt -r requirements-py3.txt csvkit"
    system "yes | pip uninstall setuptools"
  end
end
