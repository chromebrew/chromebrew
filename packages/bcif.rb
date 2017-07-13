require 'package'

class Bcif < Package
  description 'The BCIF compression algorithm is an open source method for lossless image compression.'
  homepage 'http://www.researchandtechnology.net/bcif/index.php'
  version '1.0-beta'
  source_url 'http://www.researchandtechnology.net/bcif/downloads/bcif_sources_1_0_beta.zip'
  source_sha256 'fe1dde329fa60160d9ac8a0b9e4b9360a9377bc26177eab1a31e07479839d812'

  depends_on 'unzip'

  def self.build
    FileUtils.cd('Cpp') do
      system "bash make.sh"
    end
  end

  def self.install
    FileUtils.cd('Cpp') do
      system "mkdir -p #{CREW_DEST_DIR}/usr/local/bin"
      system "cp bcif #{CREW_DEST_DIR}/usr/local/bin"
    end
  end
end
