require 'package'

class Luajit < Package
  description 'LuaJIT is a Just-In-Time Compiler (JIT) for the Lua programming language.'
  homepage 'https://github.com/openresty/luajit2'
  version '2.1-f9140a6'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/LuaJIT/LuaJIT.git'
  git_hashtag 'f9140a622a0c44a99efb391cc1c2358bc8098ab7'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '59b8e347806d44304c7746ba9222769cf5cefb82ab180949ce8eea17df7861b9',
     armv7l: '59b8e347806d44304c7746ba9222769cf5cefb82ab180949ce8eea17df7861b9',
       i686: 'a40b5c16fbbabae3b0a88eb89b26dec6d35b441f2c20d9214f2e75ea5af8a93d',
     x86_64: '93ae9318e91b6d6c3ee2172209ebaa8d4e6dba7c36b72d73623309b3f624ea25'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  def self.build
    system 'make', "PREFIX=#{CREW_PREFIX}", "MULTILIB=#{ARCH_LIB}"
  end

  def self.install
    system 'make', "PREFIX=#{CREW_PREFIX}", "MULTILIB=#{ARCH_LIB}", "DESTDIR=#{CREW_DEST_DIR}", 'install'
    Dir.chdir("#{CREW_DEST_PREFIX}/bin") do
      Dir["luajit-#{version.split('-').first}*"].each do |f|
        FileUtils.ln_sf f, 'luajit'
      end
    end
  end
end
