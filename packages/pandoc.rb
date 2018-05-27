require 'package'

class Pandoc < Package
  description 'Universal markup converter'
  homepage 'https://github.com/jgm/pandoc/'
  version '2.2.1'
  
  source_url 'https://github.com/jgm/pandoc/releases/download/2.2.1/pandoc-2.2.1-linux.tar.gz'
  source_sha256 '3b1b573cdf957b4102c42ce6f5a641787267a55a5e88dcca942fd471c25793cb'

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}"
    system "cp -r bin/ #{CREW_DEST_PREFIX}"
    system "cp -r share/ #{CREW_DEST_PREFIX}"
  end
end
