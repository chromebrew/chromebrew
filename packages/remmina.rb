require 'package'

class Remmina < Package
  description 'The GTK Remmina Remote Desktop Client'
  homepage 'https://remmina.org/'
  version '1.4.19'
  license 'GPL-2+-with-openssl-exception'
  compatibility 'x86_64 aarch64 armv7l'
  source_url "https://gitlab.com/Remmina/Remmina/-/archive/v#{version}/Remmina-v#{version}.tar.bz2"
  source_sha256 'a730d5927232818d55c8e094dba69d504faacabab2288d0c5c0c30ee7e89be46'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/remmina/1.4.19_armv7l/remmina-1.4.19-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/remmina/1.4.19_armv7l/remmina-1.4.19-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/remmina/1.4.19_x86_64/remmina-1.4.19-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'dab35fcbbc23c18cad70e6410f55add495cdae28056a5f32b135609918f4abf1',
     armv7l: 'dab35fcbbc23c18cad70e6410f55add495cdae28056a5f32b135609918f4abf1',
     x86_64: '5c0664d01de495b9e0a8c872d8f510c2523d19bcf9e4c7ae4f0c7c6ad4fcbb6d'
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

  def self.patch
    # https://gitlab.com/Remmina/Remmina/-/issues/2542
    system "curl -Ls https://gitlab.com/Remmina/Remmina/-/merge_requests/2290.patch | \
    hashpipe sha256 618b6f759a40293c71cb622bbd16ed673c0474e9238b339095a5957c929e26a9 | \
    patch -Np1 --binary"
  end

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
