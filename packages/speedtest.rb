require 'package'

class Speedtest < Package
  description 'Command line interface for testing internet bandwidth using speedtest.net'
  homepage 'https://github.com/sivel/speedtest-cli'
  version '2.0.0'
  source_url 'https://github.com/sivel/speedtest-cli/archive/v2.0.0.tar.gz'
  source_sha256 '732daf109a3399c794b293723199d740b0accddef86007a0f85f577bd4ba6c9a'

  depends_on 'python3'

  def self.install
    system "yes | pip install setuptools"
    system "pip install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR} -I speedtest-cli==2.0.0"
    system "yes | pip uninstall setuptools"
  end
end
