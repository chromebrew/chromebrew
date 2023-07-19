require 'package'

class Gsound < Package
  description 'GSound is a small library for playing system sounds.'
  homepage 'https://wiki.gnome.org/Projects/GSound'
  version '1.0.2'
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url "https://download.gnome.org/sources/gsound/#{version.rpartition('.')[0]}/gsound-#{version}.tar.xz"
  source_sha256 'bba8ff30eea815037e53bee727bbd5f0b6a2e74d452a7711b819a7c444e78e53'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gsound/1.0.2_armv7l/gsound-1.0.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gsound/1.0.2_armv7l/gsound-1.0.2-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gsound/1.0.2_i686/gsound-1.0.2-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gsound/1.0.2_x86_64/gsound-1.0.2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '01781a6b9044780e7e4401e16fa6ba3a3491cff618e640828445937dcce90155',
     armv7l: '01781a6b9044780e7e4401e16fa6ba3a3491cff618e640828445937dcce90155',
       i686: '468fe3ee02fd4899516fc7144b1454a0b7ee5296832f7983e5cd92c547f949e8',
     x86_64: '65a98713abd0ad892ba0f65a823d51c5aa1b9fd14751d998211f762724a2c444'
  })

  depends_on 'gobject_introspection'
  depends_on 'libcanberra'

  def self.build
    system './autogen.sh' if File.exist?('autogen.sh')
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end

  def self.check
    system 'make check'
  end
end
