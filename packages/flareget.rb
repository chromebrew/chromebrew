require 'package'

class Flareget < Package
  description 'Full featured, multi-threaded download manager and accelerator'
  homepage 'https://flareget.com/'
  version '5.0.1'
  license 'Copyright (C) 2012-2014 FlareGet.com'
  compatibility 'x86_64'
  source_url 'https://dl.flareget.com/downloads/files/flareget/debs/amd64/flareget_5.0-1_amd64.deb'
  source_sha256 'b7793ce3a90faf29e6190440a5df75080877098c130b33331b7f096789354e06'

  depends_on 'qt5_base' # R

  no_compile_needed

  def self.install
    FileUtils.mkdir_p CREW_DEST_PREFIX
    FileUtils.mv 'etc', CREW_DEST_PREFIX
    FileUtils.mv Dir['usr/*'], CREW_DEST_PREFIX
  end
end
