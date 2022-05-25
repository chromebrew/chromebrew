require 'package'

class Xfconf < Package
  description 'Xfce hierarchical (tree-like) configuration system'
  homepage 'https://xfce.org/'
  version '4.14.3'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://archive.xfce.org/src/xfce/xfconf/4.14/xfconf-4.14.3.tar.bz2'
  source_sha256 '589052a0efc6151c5fb5f438da463502a4fd91848cae7b9376d417be4c5a0c02'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xfconf/4.14.3_armv7l/xfconf-4.14.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xfconf/4.14.3_armv7l/xfconf-4.14.3-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xfconf/4.14.3_i686/xfconf-4.14.3-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xfconf/4.14.3_x86_64/xfconf-4.14.3-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '14c0ea331495d775cefe7d47d0ad3b916ca1b32cee886dcd526f6577d9e8e846',
     armv7l: '14c0ea331495d775cefe7d47d0ad3b916ca1b32cee886dcd526f6577d9e8e846',
       i686: '477b34ac827fc9765cfd099ff63904eb05d1f028eee93e40aa67540812306516',
     x86_64: '9550ca9cf26bfd14b99997fd5cee8ef9b3b4045f3c7a88c9cb27e2f4a32d58c9'
  })

  depends_on 'gobject_introspection' # For --enable-gsettings-backend
  depends_on 'libxfce4util'
  depends_on 'vala' => :build

  def self.build
    system "./configure #{CREW_OPTIONS} --enable-gsettings-backend"
    system "make -j#{CREW_NPROC}"
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
