require 'package'

class Bcif < Package
  description 'The BCIF compression algorithm is an open source method for lossless image compression.'
  homepage 'http://www.researchandtechnology.net/bcif/index.php'
  version '1.0-beta'
  source_url 'http://www.researchandtechnology.net/bcif/downloads/bcif_sources_1_0_beta.zip'
  source_sha1 '330c81ce5e7c471a629d59e22dae0c59a536b1c4'

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
