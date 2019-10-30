require 'package'

class Pandoc < Package
  description 'Universal markup converter'
  homepage 'https://github.com/jgm/pandoc/'
  version '2.7.3'
  
  source_url 'https://github.com/jgm/pandoc/releases/download/2.7.3/pandoc-2.7.3-linux.tar.gz'
  source_sha256 'eb775fd42ec50329004d00f0c9b13076e707cdd44745517c8ce2581fb8abdb75'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}"
    system "cp -r bin/ #{CREW_DEST_PREFIX}"
    system "cp -r share/ #{CREW_DEST_PREFIX}"
  end
end
