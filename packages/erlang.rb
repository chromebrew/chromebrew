require 'package'

class Erlang < Package
  description 'Erlang is a programming language used to build massively scalable soft real-time systems with requirements on high availability.'
  homepage 'https://www.erlang.org/'
  version '25.0'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://erlang.org/download/otp_src_25.0.tar.gz'
  source_sha256 '3e1e2e55409e9484e69b316fcd00ff7e2ed606bcfb2c7cac514f9b9aeb9651e8'

  binary_url ({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/erlang/25.0_armv7l/erlang-25.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/erlang/25.0_armv7l/erlang-25.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/erlang/25.0_i686/erlang-25.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/erlang/25.0_x86_64/erlang-25.0-chromeos-x86_64.tar.zst',
  })
  binary_sha256 ({
    aarch64: '05dab34ca35b1cc29e31114ad88382b40477985927f93e4f6514e60a66f8d7f8',
     armv7l: '05dab34ca35b1cc29e31114ad88382b40477985927f93e4f6514e60a66f8d7f8',
       i686: '5218ffcd054d29bf5754aedec73777a62b061785358d8bf021a36434deb89b60',
     x86_64: '4d34f06850d5a5e6bdd6fc778eab27cdb72501086cd2d130d5ff4e663943ccbf',
  })

  depends_on 'jdk8'
  depends_on 'wxwidgets'

  def self.build
    ENV['ERL_OTP'] = Dir.pwd
    system "./configure #{CREW_OPTIONS} && make"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
