require 'package'

class Remmina < Package
  description 'The GTK Remmina Remote Desktop Client'
  homepage 'https://remmina.org/'
  version '1.4.25'
  license 'GPL-2+-with-openssl-exception'
  compatibility 'x86_64 aarch64 armv7l'
  source_url "https://gitlab.com/Remmina/Remmina/-/archive/v#{version}/Remmina-v#{version}.tar.bz2"
  source_sha256 'a730d5927232818d55c8e094dba69d504faacabab2288d0c5c0c30ee7e89be46'

  binary_url({
    aarch64: 'file:///usr/local/tmp/packages/remmina-1.4.25-chromeos-armv7l.tar.zst',
     armv7l: 'file:///usr/local/tmp/packages/remmina-1.4.25-chromeos-armv7l.tar.zst',
     x86_64: 'file:///usr/local/tmp/packages/remmina-1.4.25-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'c2a51556cb206a0a2d82daf8859b33e68c5141fa87b62ad3f700ec2a43cac6e3',
     armv7l: 'c2a51556cb206a0a2d82daf8859b33e68c5141fa87b62ad3f700ec2a43cac6e3',
     x86_64: '6b280475ba0d8778b5be2be2d697968ce893b12fbf78d448d7431770e8fb718c'
  })

  depends_on 'avahi'
  depends_on 'freerdp'
  depends_on 'hashpipe' => :build
  depends_on 'libappindicator_gtk3'
  depends_on 'libsecret'
  depends_on 'libsodium'
  depends_on 'libsoup'
  depends_on 'libvncserver'
  depends_on 'spice_gtk'
  depends_on 'vte'
  depends_on 'webkit2gtk_4'
  depends_on 'xdg_utils' => :build
  depends_on 'sommelier'

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "cmake \
        -G Ninja \
        #{CREW_CMAKE_OPTIONS.sub("C_FLAGS='",
                                 "C_FLAGS='-Wno-unused-function ")} \
        -DWITH_TELEPATHY=OFF \
        .."
    end
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
