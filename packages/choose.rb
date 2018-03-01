require 'package'

class Choose < Package
  description 'make choices on the command line'
  homepage 'https://github.com/geier/choose'
  version '0.1.0'
  source_url 'https://github.com/geier/choose/archive/v0.1.0.tar.gz'
  source_sha256 'd09a679920480e66bff36c76dd4d33e8ad739a53eace505d01051c114a829633'

  depends_on 'python27' unless File.exists? "#{CREW_PREFIX}/bin/python"

  def self.install
    system "yes | pip install setuptools"
    system "pip install urwid --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR}"
    system "install -Dm755 choose #{CREW_DEST_PREFIX}/bin/choose"
    system "pip uninstall setuptools"
  end
end
