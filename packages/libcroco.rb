require 'package'

class Libcroco < Package
  description 'Generic Cascading Style Sheet (CSS) parsing and manipulation toolkit.'
  homepage 'https://git.gnome.org/browse/libcroco/'
  version '0.6.13'
  license 'LGPL-2'
  compatibility 'all'
  source_url "http://ftp.gnome.org/pub/gnome/sources/libcroco/#{version.rpartition('.')[0]}/libcroco-#{version}.tar.xz"
  source_sha256 '767ec234ae7aa684695b3a735548224888132e063f92db585759b422570621d4'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '60fc1383b5e017354c7c2125a8357d5856c13eea76a765b92bf64e3f92df5341',
     armv7l: '60fc1383b5e017354c7c2125a8357d5856c13eea76a765b92bf64e3f92df5341',
       i686: '68afcab6e597a792079edfd6090a51ac49daac65cc45b20aca79c678e77328b7',
     x86_64: '2d3dd17c43cb509d6c4ed2f5b5e1b29e7f54d63f673c2cc2beac549efcd5e748'
  })

  depends_on 'gtk_doc'
  depends_on 'py3_six' => :build

  def self.build
    system 'sh autogen.sh'
    system "env CFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      CXXFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
