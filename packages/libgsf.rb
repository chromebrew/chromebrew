require 'package'

class Libgsf < Package
  description 'The G Structured File Library'
  homepage 'https://gitlab.gnome.org/GNOME/libgsf'
  version '1.14.50'
  license 'GPL-2 and LGPL-2'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/libgsf.git'
  git_hashtag "LIBGSF_#{version.gsub('.', '_')}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgsf/1.14.50_armv7l/libgsf-1.14.50-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgsf/1.14.50_armv7l/libgsf-1.14.50-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgsf/1.14.50_i686/libgsf-1.14.50-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgsf/1.14.50_x86_64/libgsf-1.14.50-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '3387aaef57bb436bc10337b988cb27a519a7c0625bd4d7922b392bd3bc995dc2',
     armv7l: '3387aaef57bb436bc10337b988cb27a519a7c0625bd4d7922b392bd3bc995dc2',
       i686: '17bb9b80ab65ceeac352c6c614fa2def76da03ea0545d12a55fd7cb6ffef28f1',
     x86_64: '291211e57a54c7618c563eb0d94c8940117a498fcdc7f5520e880cf45ce230bb'
  })

  depends_on 'gdk_pixbuf'
  depends_on 'gtk_doc'
  depends_on 'bz2' # R
  depends_on 'gcc_lib' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'icu4c' # R
  depends_on 'libxml2' # R
  depends_on 'zlibpkg' # R

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system "./configure #{CREW_OPTIONS} \
      --enable-shared=yes \
      --disable-maintainer-mode \
      --enable-introspection"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
