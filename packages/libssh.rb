require 'package'

class Libssh < Package
  description 'libssh is a multiplatform C library implementing the SSHv2 and SSHv1 protocol on client and server side.'
  homepage 'https://www.libssh.org/'
  @_ver = '0.9.5'
  version "#{@_ver}-1"
  compatibility 'all'
  @_ver_prelastdot = @_ver.rpartition('.')[0]
  source_url "https://www.libssh.org/files/#{@_ver_prelastdot}/libssh-#{@_ver}.tar.xz"
  source_sha256 'acffef2da98e761fc1fd9c4fddde0f3af60ab44c4f5af05cd1b2d60a3fa08718'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libssh-0.9.5-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libssh-0.9.5-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libssh-0.9.5-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libssh-0.9.5-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '7823ea3948867ed6b44ff1d62334aa011db8d3e07452c5a6312f5873a26d681c',
     armv7l: '7823ea3948867ed6b44ff1d62334aa011db8d3e07452c5a6312f5873a26d681c',
       i686: '07e75554e44aaef4210d9bf6a17b098953d03054ff5f2614dc4c4719d6936d8b',
     x86_64: 'a3f1c7727f88271291316d186698e2c94afd275493f3b27e93f2eb152679970e'
  })

  depends_on 'libgcrypt'

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "env CFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
        CXXFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
        LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
        cmake -G Ninja \
        #{CREW_CMAKE_OPTIONS} \
        -DWITH_STACK_PROTECTOR_STRONG=NO \
        -DWITH_STACK_CLASH_PROTECTION=NO \
        -DWITH_STACK_PROTECTOR=NO \
        -DWITH_GCRYPT=ON \
        .."
    end
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
