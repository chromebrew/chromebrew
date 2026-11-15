require 'package'

class Pandoc < Package
  description 'Universal markup converter'
  homepage 'https://github.com/jgm/pandoc/'
  version '3.14'
  license 'GPL-2+'
  compatibility 'x86_64'
  source_url "https://github.com/jgm/pandoc/releases/download/#{version}/pandoc-#{version}-linux-amd64.tar.gz"
  source_sha256 'c5f4720cdefb3f7bdc5d07202ef579feef0d1370773c873804dd8fdaa8c4f1b8'

  no_compile_needed

  def self.install
    FileUtils.mkdir_p CREW_DEST_PREFIX
    FileUtils.mv 'bin', CREW_DEST_PREFIX
    FileUtils.mv 'share', CREW_DEST_PREFIX
  end
end
