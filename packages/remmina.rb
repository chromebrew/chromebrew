require 'package'

class Remmina < Package
  description 'The GTK Remmina Remote Desktop Client'
  homepage 'https://remmina.org/'
  version '1.4.27'
  license 'GPL-2+-with-openssl-exception'
  compatibility 'x86_64 armv7l aarch64'
  source_url "https://gitlab.com/Remmina/Remmina/-/archive/v#{version}/Remmina-v#{version}.tar.bz2"
  source_sha256 '6e93f18a4930ca194d3651a7a0cedf1cf92e761884952d5651fc1e985daa9c5a'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/remmina/1.4.27_armv7l/remmina-1.4.27-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/remmina/1.4.27_armv7l/remmina-1.4.27-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/remmina/1.4.27_x86_64/remmina-1.4.27-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '8604a9830b7dca6eb39e4dbe456c80a95f6be267afb649960591b13afccc367d',
     armv7l: '8604a9830b7dca6eb39e4dbe456c80a95f6be267afb649960591b13afccc367d',
     x86_64: 'ef7a269e329ef4793cb61e2e7e0fc3e7453ba7d3dcddd353398611965a2c9597'
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
