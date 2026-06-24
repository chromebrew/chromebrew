require 'buildsystems/autotools'

class Ragel < Autotools
  description 'Compiles finite state machines from regular languages into executable C, C++, Objective-C, or D code.'
  homepage 'https://www.colm.net/open-source/ragel/'
  version '6.10'
  license 'GPL-2.0-only'
  compatibility 'all'
  source_url "https://www.colm.net/files/ragel/ragel-#{version}.tar.gz"
  source_sha256 '5f156edb65d20b856d638dd9ee2dfb43285914d9aa2b6ec779dac0270cd56c3f'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8edc2dfccadae1b99c06e7973bd17e6ac01f6fabd438d765751cbc964bd5f121',
     armv7l: '8edc2dfccadae1b99c06e7973bd17e6ac01f6fabd438d765751cbc964bd5f121',
       i686: 'a3f0f6bacf4b58504c3a2e90d22f4020d0d81bbc169448f2292385efa7cbb400',
     x86_64: 'ae7866fc233f5ec1706b9daaa954f833139d852b2cee8db1438ee3e5a76ca008'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable

  autotools_pre_configure_options "CFLAGS+=' -std=gnu++98' CXXFLAGS+=' -std=gnu++98'"
end
