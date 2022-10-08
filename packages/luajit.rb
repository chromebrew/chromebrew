require 'package'

class Luajit < Package
  description 'LuaJIT is a Just-In-Time Compiler (JIT) for the Lua programming language.'
  homepage 'https://github.com/openresty/luajit2'
  version '2.1-20220915'
  license 'MIT'
  compatibility 'all'
  source_url "https://github.com/openresty/luajit2/archive/refs/tags/v#{version}.tar.gz"
  source_sha256 'a6104d4fa342d864ae00cb3313b07091af02dc61294b1d8fce1e17779998b497'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/luajit/2.1-20220915_armv7l/luajit-2.1-20220915-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/luajit/2.1-20220915_armv7l/luajit-2.1-20220915-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/luajit/2.1-20220915_i686/luajit-2.1-20220915-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/luajit/2.1-20220915_x86_64/luajit-2.1-20220915-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '8ece5b7a8d617e0b6f717ac3d7f999f75ae2fac85707d0f7f5da815aaffe15cd',
     armv7l: '8ece5b7a8d617e0b6f717ac3d7f999f75ae2fac85707d0f7f5da815aaffe15cd',
       i686: '945cb7a5d311ed4b124709ea30a3843b1997929a95c27322950fcb8b71a1fae0',
     x86_64: '8f446341a8e379d65d820709d70ba85c1cbb47f4dcbcf3f0f9e200fd60d5c565'
  })

  def self.build
    system 'make', "PREFIX=#{CREW_PREFIX}", "MULTILIB=#{ARCH_LIB}"
  end

  def self.install
    system 'make', "PREFIX=#{CREW_PREFIX}", "MULTILIB=#{ARCH_LIB}", "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
