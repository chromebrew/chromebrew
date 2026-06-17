require 'buildsystems/autotools'

class Homebank < Autotools
  description 'HomeBank is a free software that will assist you to manage your personal accounting.'
  homepage 'https://www.gethomebank.org/en/index.php'
  version '5.10.2'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://www.gethomebank.org/public/sources/homebank-#{version}.tar.gz"
  source_sha256 'f0beafe07ea22155c8f8e267798d6eb05d6e015d5660b96fb34fdeca5a6bc4c7'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9c2df56e72a92539be054d139251d6463177ac93b5f04dbd378907d4421883ba',
     armv7l: '9c2df56e72a92539be054d139251d6463177ac93b5f04dbd378907d4421883ba',
     x86_64: '1344f93a85488d017aa1f5d931d2ac7c4a7156696ad3c0a98e4755a27b3daf22'
  })

  depends_on 'at_spi2_core' => :executable
  depends_on 'cairo' => :executable
  depends_on 'gdk_pixbuf' => :executable
  depends_on 'glib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'gtk3' => :executable
  depends_on 'harfbuzz' => :executable
  depends_on 'libofx' => :executable
  depends_on 'libsoup' => :executable
  depends_on 'pango' => :executable
  depends_on 'perl_xml_parser' => :executable
  depends_on 'wayland_protocols' => :executable
  depends_on 'xcb_util' => :executable
  depends_on 'xdg_base' => :executable
  depends_on 'zlib' => :executable

  print_source_bashrc

  # autotools_pre_configure_options "INTLTOOL_PERL=#{CREW_LIB_PREFIX}/#{CREW_PERL_VER.split('.')[0]}/#{CREW_PERL_VER.split('l')[1]}/site_perl/XML"
  autotools_pre_configure_options "INTLTOOL_PERL=#{CREW_PREFIX}/bin/perl"

  autotools_build_extras do
    File.write '10-homebank', <<~EOF
      #!/bin/bash
      alias homebank="WAYLAND_DISPLAY=wayland-0 DISPLAY='0:0' GDK_BACKEND=x11 homebank"
    EOF
  end

  autotools_install_extras do
    FileUtils.install '10-homebank', "#{CREW_DEST_PREFIX}/etc/env.d/10-homebank", mode: 0o644
  end
end
