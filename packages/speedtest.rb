require 'package'

class Speedtest < Package
  description 'Command line interface for testing internet bandwidth using speedtest.net'
  homepage 'https://github.com/sivel/speedtest-cli'
  version '2.0.0'
  source_url 'https://github.com/sivel/speedtest-cli/archive/v2.0.0.tar.gz'
  source_sha256 '732daf109a3399c794b293723199d740b0accddef86007a0f85f577bd4ba6c9a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/speedtest-2.0.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/speedtest-2.0.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/speedtest-2.0.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/speedtest-2.0.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b118784c7092e21bb390b888eefcbe8c840b22ae15ad21c9ec119cdea7736622',
     armv7l: 'b118784c7092e21bb390b888eefcbe8c840b22ae15ad21c9ec119cdea7736622',
       i686: '64844eae55e6eef628dbe794acb08d0cb681b6f239e959e913f42f56ae602a1b',
     x86_64: '2738ae52fdf124c760adaf486ff79ffac99cc6331ae4e9f1c37a7af5b12b3e46',
  })

  depends_on 'python3'

  def self.install
    system "yes | pip3 install setuptools"
    system "pip3 install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR} -I speedtest-cli==2.0.0"
    system "yes | pip3 uninstall setuptools"
  end
end
