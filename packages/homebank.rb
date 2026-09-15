require 'buildsystems/autotools'

class Homebank < Autotools
  description 'HomeBank is a free software that will assist you to manage your personal accounting.'
  homepage 'https://www.gethomebank.org/en/index.php'
  version '5.10.3'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://www.gethomebank.org/public/sources/homebank-#{version}.tar.gz"
  source_sha256 '574de504cceafdb6138ffa2e03be567ad66b8a2ceaef3434e07ca695e82dd9e3'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '639af946272fa5c0685d8bfe1b06de71936e92681038e1f4d16e69d3aa8f34ed',
     armv7l: '639af946272fa5c0685d8bfe1b06de71936e92681038e1f4d16e69d3aa8f34ed',
     x86_64: '37410a5caebda33613072c64d8bfef39f9551aaa05aa00c786b7fda3bbbb6a7f'
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
