require 'package'

class S3cmd < Package
  description 'Command line tool for managing Amazon S3 and CloudFront services'
  homepage 'http://s3tools.org/s3cmd'
  version '2.0.1'
  source_url 'https://github.com/s3tools/s3cmd/releases/download/v2.0.1/s3cmd-2.0.1.tar.gz'
  source_sha256 'caf09f1473301c442fba6431c983c361c9af8bde503dac0953f0d2f8f2c53c8f'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'python27' unless File.exists? "#{CREW_PREFIX}/bin/python"

  def self.install
    system "python setup.py install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR}"
    system "pip install python-dateutil --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR}"
  end
end
