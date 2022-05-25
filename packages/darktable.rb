require 'package'

class Darktable < Package
  description 'darktable is an open source photography workflow application and raw developer.'
  homepage 'https://www.darktable.org/'
  version '3.4.1.1'
  license 'GPL-3'
  compatibility 'x86_64'
  source_url 'https://github.com/darktable-org/darktable/releases/download/release-3.4.1/darktable-3.4.1.1.tar.xz'
  source_sha256 '00d57a6c3b86f4eb1791128b612e762f69df4be2c110965afac1fdcca5678143'
  binary_compression 'tar.xz'

  binary_url({
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/darktable/3.4.1.1_x86_64/darktable-3.4.1.1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    x86_64: '793e78e4d9859fdbc72e7490b8a5395409dd5d941dcbfafefdd0a5317cb4b832'
  })

  depends_on 'cairo'
  depends_on 'colord'
  depends_on 'curl'
  depends_on 'dbus_glib'
  depends_on 'fop'
  depends_on 'gexiv2'
  depends_on 'gphoto'
  depends_on 'graphicsmagick'
  depends_on 'gtk3'
  depends_on 'imagemagick7'
  depends_on 'lcms'
  depends_on 'libjpeg'
  depends_on 'libpng'
  depends_on 'librsvg'
  depends_on 'libsecret'
  depends_on 'libsoup'
  depends_on 'libtiff'
  depends_on 'lua'
  depends_on 'openexr'
  depends_on 'pugixml'
  depends_on 'sqlite'
  depends_on 'sommelier'

  def self.build
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system 'cmake',
             "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}",
             '-DCMAKE_BUILD_TYPE=Release',
             '..'
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'build' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end
end
