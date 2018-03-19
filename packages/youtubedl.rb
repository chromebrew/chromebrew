require 'package'

class Youtubedl < Package
  description 'Command-line program to download videos from YouTube.com and other video sites'
  homepage 'http://rg3.github.io/youtube-dl/'
  version '2018.03.20'
  source_url 'https://github.com/rg3/youtube-dl/releases/download/2018.03.20/youtube-dl-2018.03.20.tar.gz'
  source_sha256 'a977d04aa201ef35f8a6dc66b19204a9093b26c9d04d643089a1d467ba4e0682'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'python27'

  def self.install
    system "yes | pip install setuptools"
    system "pip install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR} -I youtube-dl==2018.03.20"
    system "yes | pip uninstall setuptools"
  end
end
