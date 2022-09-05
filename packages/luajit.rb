require 'package'

class Luajit < Package
  description 'LuaJIT is a Just-In-Time Compiler (JIT) for the Lua programming language.'
  homepage 'https://github.com/openresty/luajit2'
  version '2.1-20220411'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/openresty/luajit2.git'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/luajit/2.1-20220411_armv7l/luajit-2.1-20220411-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/luajit/2.1-20220411_armv7l/luajit-2.1-20220411-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/luajit/2.1-20220411_i686/luajit-2.1-20220411-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/luajit/2.1-20220411_x86_64/luajit-2.1-20220411-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '18fbd6916f9f75db3b5939997af0ef447102f49439941852c044e079d82bb611',
     armv7l: '18fbd6916f9f75db3b5939997af0ef447102f49439941852c044e079d82bb611',
       i686: '747299199b1011f83b77c0e142052811bb0f4736a1ec834062ff6f1c36338951',
     x86_64: 'ad76e59f1079539a74159d81563ed7d23f5e333661d63a46cc3f6508d8fd8c5e'
  })

  git_hashtag "v#{version}"

  def self.build
    system 'make', "PREFIX=#{CREW_PREFIX}", "MULTILIB=#{ARCH_LIB}"
  end

  def self.install
    system 'make', "PREFIX=#{CREW_PREFIX}", "MULTILIB=#{ARCH_LIB}", "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
