require 'package'

class Csvkit < Package
  description 'A suite of utilities for converting to and working with CSV, the king of tabular file formats.'
  homepage 'http://csvkit.rtfd.org/'
  version '1.0.2'
  source_url 'https://github.com/wireservice/csvkit/archive/1.0.2.tar.gz'
  source_sha256 '35c8c7c699573bec47cbd3576240cc9b444d35f309386f8030340bc50315cdec'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'python27'

  def self.install
    system "yes | pip install setuptools"
    system "pip install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR} -r requirements-py2.txt -r requirements-py3.txt csvkit"
    system "yes | pip uninstall setuptools"
  end
end
