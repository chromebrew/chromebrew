require 'buildsystems/autotools'

class Homebank < Autotools
  description 'HomeBank is a free software that will assist you to manage your personal accounting.'
  homepage 'https://www.gethomebank.org/en/index.php'
  version '5.10.4'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://www.gethomebank.org/public/sources/homebank-#{version}.tar.gz"
  source_sha256 'f8072131328e7c1d6ca336f809e265e483c6d6d21f3654bc520700d27deae2d8'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3269899dafc666d381c61b9b6bb4e489833d0e5305ff02ccfbf1f9a8ad0e464d',
     armv7l: '3269899dafc666d381c61b9b6bb4e489833d0e5305ff02ccfbf1f9a8ad0e464d',
     x86_64: '9316553027597265bcc6bf9d5d007b39365f8f907cdd6b26e5e2d42a0bf51f9b'
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
