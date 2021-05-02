require 'package'

class Bind < Package
  description 'BIND is open source software that enables you to publish your Domain Name System (DNS) information on the Internet, and to resolve DNS queries for your users.'
  homepage 'https://www.isc.org/downloads/bind/'
  @_ver = '9.17.11'
  version @_ver
  license 'Apache-2.0, BSD, BSD-2, GPL-2, HPND, ISC and MPL-2.0'
  compatibility 'all'
  source_url 'SKIP'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bind/9.17.11_armv7l/bind-9.17.11-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bind/9.17.11_armv7l/bind-9.17.11-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bind/9.17.11_i686/bind-9.17.11-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bind/9.17.11_x86_64/bind-9.17.11-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '732a27d1c4061ac070d159583b1b76068980799a3021999d39e11a6da79d6e84',
     armv7l: '732a27d1c4061ac070d159583b1b76068980799a3021999d39e11a6da79d6e84',
       i686: '7541e71a39abf95c510d78522e033637b8918fc1bbcb0880149a60d0b6b6cd39',
     x86_64: '4f075b386135f94a2508aa13e005033454662c608f23923b9e2f58bad7329377'
  })

  depends_on 'jsonc'
  depends_on 'libcap'
  depends_on 'libuv'

  def self.build
    system 'git config --global advice.detachedHead false'
    @_ver_ = @_ver.gsub(/[.]/, '_')
    system "git clone --depth=1 -b v#{@_ver_} https://gitlab.isc.org/isc-projects/bind9.git"
    Dir.chdir 'bind9' do
      system 'pip3 install ply==3.11'
      system 'autoreconf -fi'
      system 'filefix'
      system "env CFLAGS='-DDIG_SIGCHASE -flto=auto' \
        CXXFLAGS='-pipe -flto=auto' \
        LDFLAGS='-flto=auto' \
        ./configure \
        #{CREW_OPTIONS} \
         --enable-fixed-rrset \
         --enable-full-report \
         --with-openssl \
         --with-libidn2 \
         --disable-maintainer-mode"
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'bind9' do
      system "make DESTDIR=#{CREW_DEST_DIR} install"
      system 'pip3 uninstall -y ply'
      system "pip3 install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR} -I ply==3.11"
    end
  end
end
