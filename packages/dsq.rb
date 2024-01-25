require 'package'

class Dsq < Package
  description 'Commandline tool for running SQL queries against JSON, CSV, Excel, Parquet, and more.'
  homepage 'https://github.com/multiprocessio/dsq'
  version '0.18.0'
  license 'Apache License, Version 2.0'
  compatibility 'x86_64'
  source_url 'https://github.com/multiprocessio/dsq/archive/0.18.0.tar.gz'
  source_sha256 'b61a811646cbd383e5f98bb8d2fc16c41bdb229575d90e84daa645512ef042bb'
  binary_compression 'tar.zst'

  binary_sha256({
    x86_64: '8278c63305a72ecf2c5eb1343f15ed4e515cd12e79023352fc2c57a88370f763'
  })

  depends_on 'go' => :build

  def self.install
    system 'go get github.com/multiprocessio/dsq'
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    system "go build -o #{CREW_DEST_PREFIX}/bin/dsq"
  end
end
