require 'buildsystems/autotools'

class Xfce4_dev_tools < Autotools
  description 'Xfce4 development tools'
  homepage 'https://xfce.org/'
  version '4.20.0'
  license 'GPL-2+'
  compatibility 'all'
  source_url "https://archive.xfce.org/src/xfce/xfce4-dev-tools/#{version.sub(/\.\d+$/, '')}/xfce4-dev-tools-#{version}.tar.bz2"
  source_sha256 '1fba39a08a0ecc771eaa3a3b6e4272a4f0b9e7c67d0f66e780cd6090cd4466aa'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '029ae3ab3ceed5e6e65ef848b160a9f7e6d8a69d90a3b7793a8a9556aa5b1e9c',
     armv7l: '029ae3ab3ceed5e6e65ef848b160a9f7e6d8a69d90a3b7793a8a9556aa5b1e9c',
       i686: 'b8e56baea279d5b8d86705c7c241f5046bc1443a4a294717d232dcf32dc8b57a',
     x86_64: '045254614d75b773c2479d460961727efa4ce52216e426380182bfcfcc2c3f84'
  })

  depends_on 'glib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'gtk_doc' => :build
  depends_on 'libxslt' => :build
end
