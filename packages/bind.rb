require 'package'

class Bind < Package
  description 'BIND is open source software that enables you to publish your Domain Name System (DNS) information on the Internet, and to resolve DNS queries for your users.'
  homepage 'https://www.isc.org/downloads/bind/'
  @_ver = '9.17.10'
  version @_ver
  compatibility 'all'
  source_url 'file:///dev/null'
  source_sha256 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/bind-9.17.10-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/bind-9.17.10-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/bind-9.17.10-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/bind-9.17.10-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '0655729fa11a71e11da25627a813aabb4110a1e8b694d0ac711adcdec7bf19c9',
     armv7l: '0655729fa11a71e11da25627a813aabb4110a1e8b694d0ac711adcdec7bf19c9',
       i686: '0fc34d77bd997d9b771ef9309f6a62a61cebbd4878889a383790e57f4b8fd0b4',
     x86_64: '052251db56246ff7701b00ad91e868b602e400bf1cba2001fff96026f2fc493a'
  })

  depends_on 'libcap'
  depends_on 'libseccomp'
  depends_on 'libuv'

  def self.build
    system 'git config --global advice.detachedHead false'
    @_ver_ = @_ver.gsub(/[.]/, '_')
    system "git clone --depth=1 -b v#{@_ver_} https://gitlab.isc.org/isc-projects/bind9.git"
    Dir.chdir 'bind9' do
      system 'pip3 install ply==3.11'
      system 'autoreconf -fi'
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
