require 'buildsystems/qmake'

class Clipgrab < Qmake
  description 'A friendly downloader for YouTube and other sites'
  homepage 'https://clipgrab.org/'
  version '3.9.14'
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://download.clipgrab.org/clipgrab-#{version}.tar.gz"
  source_sha256 'd3e53731f9edaca05c5c860e15680ed2432dc5ad6c9a822acba5bc851f1ec836'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '64b96d664ac336d929e2850fe9c8b6226f5365051ba035657f86f69edcf005c9',
     armv7l: '64b96d664ac336d929e2850fe9c8b6226f5365051ba035657f86f69edcf005c9',
     x86_64: '48ecc6b00ac8784316d46da0d72b3efceba3bff1f83a88f03c6f593ff18b38e4'
  })

  depends_on 'qt5_base' => :executable
  depends_on 'qt5_declarative' => :executable
  depends_on 'qt5_location' => :executable
  depends_on 'qt5_webchannel' => :executable
  depends_on 'qt5_webengine' => :executable

  def self.install
    FileUtils.install 'clipgrab', "#{CREW_DEST_PREFIX}/bin/clipgrab", mode: 0o755
  end

  qmake_project 'clipgrab.pro'
end
