require 'buildsystems/autotools'

class Codeblocks < Autotools
  description 'Code::Blocks is a free, open-source, cross-platform C, C++ and Fortran IDE'
  homepage 'https://www.codeblocks.org/'
  version '25.03'
  license 'LGPLv3'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://downloads.sourceforge.net/project/codeblocks/Sources/#{version}/codeblocks_#{version}.tar.xz"
  source_sha256 'b0f6aa5908d336d7f41f9576b2418ac7d27efbc59282aa8c9171d88cea74049e'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '57cfd1f7d62eb78512e3f1dd59a3dba498e3857ab7ecac79c0874677bea8ed91',
     armv7l: '57cfd1f7d62eb78512e3f1dd59a3dba498e3857ab7ecac79c0874677bea8ed91',
     x86_64: 'bbbc2c725d578938b33d721577e3766428baa9ce24e8b838d40a015f768851db'
  })

  depends_on 'at_spi2_core' # R
  depends_on 'boost' # R
  depends_on 'bzip2' # R
  depends_on 'cairo' # R
  depends_on 'fontconfig' # R
  depends_on 'freetype' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gtk3' # R
  depends_on 'harfbuzz' # R
  depends_on 'hunspell' # R
  depends_on 'libx11' # R
  depends_on 'pango' # R
  depends_on 'wxwidgets' # R
  depends_on 'zlib' # R

  configure_options '--with-contrib-plugins=all'

  run_tests

  def self.postinstall
    ExitMessage.add "\nType 'codeblocks' to get started.\n"
  end

  def self.postremove
    Package.agree_to_remove("#{CREW_PREFIX}/.config/codeblocks")
  end
end
