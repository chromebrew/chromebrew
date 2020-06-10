require 'package'

class S3cmd < Package
  description 'Command line tool for managing Amazon S3 and CloudFront services'
  homepage 'http://s3tools.org/s3cmd'
  version '2.0.1'
  compatibility 'all'
  source_url 'https://github.com/s3tools/s3cmd/releases/download/v2.0.1/s3cmd-2.0.1.tar.gz'
  source_sha256 'caf09f1473301c442fba6431c983c361c9af8bde503dac0953f0d2f8f2c53c8f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/s3cmd-2.0.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/s3cmd-2.0.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/s3cmd-2.0.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/s3cmd-2.0.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'beb0aa2dd915c1d7b1830d107d5875893f3d69194401f868dffd9ebbe9ad0bd2',
     armv7l: 'beb0aa2dd915c1d7b1830d107d5875893f3d69194401f868dffd9ebbe9ad0bd2',
       i686: '272f221a44e9e4f7cecc165f2d7ddb896d53c56d8c0ad75450261a93ef8bfb3f',
     x86_64: '78677e4289aa1723623276fd4df256f059f812f788688680a494ae9835afd262',
  })

  depends_on 'python27' unless File.exists? "#{CREW_PREFIX}/bin/python"

  def self.install
    system "python setup.py install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR}"
    system "pip install python-dateutil --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR}"
  end
end
