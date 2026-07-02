require 'buildsystems/autotools'

class Ragel < Autotools
  description 'Compiles finite state machines from regular languages into executable C, C++, Objective-C, or D code.'
  homepage 'https://www.colm.net/open-source/ragel/'
  version '7.0.4'
  license 'GPL-2.0-only'
  compatibility 'all'
  source_url "https://www.colm.net/files/ragel/ragel-#{version}.tar.gz"
  source_sha256 '84b1493efe967e85070c69e78b04dc55edc5c5718f9d6b77929762cb2abed278'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8edc2dfccadae1b99c06e7973bd17e6ac01f6fabd438d765751cbc964bd5f121',
     armv7l: '8edc2dfccadae1b99c06e7973bd17e6ac01f6fabd438d765751cbc964bd5f121',
       i686: 'a3f0f6bacf4b58504c3a2e90d22f4020d0d81bbc169448f2292385efa7cbb400',
     x86_64: 'ae7866fc233f5ec1706b9daaa954f833139d852b2cee8db1438ee3e5a76ca008'
  })

  depends_on 'colm' => :build
  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable

  autotools_pre_configure_options "CFLAGS+=' -std=gnu++98' CXXFLAGS+=' -std=gnu++98'"
end
