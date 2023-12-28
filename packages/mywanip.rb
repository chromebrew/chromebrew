require 'package'

class Mywanip < Package
  description 'Script to grab your WAN IP address using various means.'
  homepage 'https://gist.github.com/DennisLfromGA/ab40940d37be84ae3a88'
  version 'ab4094'
  license 'all-rights-reserved'
  compatibility 'all'
  source_url 'https://gist.github.com/DennisLfromGA/ab40940d37be84ae3a88/archive/b583835e8b2cb7edefc7ccbb911cb8eaf172d341.zip'
  source_sha256 '789d22cfa60a40cf60d59e561500cd27e39ac03ecff2e948111a2a07f830fd67'

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'mywanip', "#{CREW_DEST_PREFIX}/bin", mode: 0o755
  end
end
