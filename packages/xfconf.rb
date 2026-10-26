require 'buildsystems/autotools'

class Xfconf < Autotools
  description 'Xfce hierarchical (tree-like) configuration system'
  homepage 'https://xfce.org/'
  version '4.20.0'
  license 'GPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://archive.xfce.org/src/xfce/xfconf/#{version.sub(/\.\d+$/, '')}/xfconf-#{version}.tar.bz2"
  source_sha256 '8bc43c60f1716b13cf35fc899e2a36ea9c6cdc3478a8f051220eef0f53567efd'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '57eb706adb57a4fb3860059b294b86c9f48779f0d7203dde8650e126de25ae8e',
     armv7l: '57eb706adb57a4fb3860059b294b86c9f48779f0d7203dde8650e126de25ae8e',
     x86_64: 'e8cb669059d2e45478a2d21f9ae1570800de8c09b3d2b4b19f72f83bc014be88'
  })

  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gobject_introspection' # For --enable-gsettings-backend
  depends_on 'libxfce4util' => :library
  depends_on 'vala' => :build

  autotools_skip_autoreconf
  autotools_configure_options '--enable-gsettings-backend'

  def self.prebuild
    ConvenienceFunctions.libtoolize('libglib-2.0', 'glib')
  end

  autotools_install_extras do
    FileUtils.rm_f "#{CREW_DEST_PREFIX}/lib/systemd/user/xfconfd.service"
  end
end
