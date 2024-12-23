require 'package'

class Libsciter_gtk < Package
  description 'Sciter HTML/CSS/scripting engine GTK library'
  homepage 'https://github.com/c-smile/sciter-sdk'
  version 'f33df07'
  license 'Terra Informatica Software, Inc. © 2006-2018'
  compatibility 'x86_64 aarch64 armv7l'
  source_url({
    aarch64: 'https://github.com/c-smile/sciter-sdk/raw/f33df075d9eb2f8d252cb88f1b2c8096e56197ed/bin.lnx/arm32/libsciter-gtk.so',
     armv7l: 'https://github.com/c-smile/sciter-sdk/raw/f33df075d9eb2f8d252cb88f1b2c8096e56197ed/bin.lnx/arm32/libsciter-gtk.so',
     x86_64: 'https://github.com/c-smile/sciter-sdk/raw/f33df075d9eb2f8d252cb88f1b2c8096e56197ed/bin.lnx/x64/libsciter-gtk.so'
  })
  source_sha256({
    aarch64: 'e68092ef9182ab42c69f0954de5709ccc9266a2e73af47dc1eeab3a5114fe435',
     armv7l: 'e68092ef9182ab42c69f0954de5709ccc9266a2e73af47dc1eeab3a5114fe435',
     x86_64: 'a1682fbf55e004f1862d6ace31b5220121d20906bdbf308d0a9237b451e4db86'
  })

  no_compile_needed

  def self.install
    FileUtils.install 'libsciter-gtk.so', "#{CREW_DEST_LIB_PREFIX}/libsciter-gtk.so", mode: 0o644
  end
end
