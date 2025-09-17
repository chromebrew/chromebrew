require 'buildsystems/autotools'

class Help2man < Autotools
  description "help2man produces simple manual pages from the '--help' and '--version' output of other commands."
  homepage 'https://www.gnu.org/software/help2man/'
  version '1.49.3'
  license 'GPL-3'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/help2man/help2man-#{version}.tar.xz"
  source_sha256 '4d7e4fdef2eca6afe07a2682151cea78781e0a4e8f9622142d9f70c083a2fd4f'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5a452f26ce39181b52ca51fd3fcf0515b79fce7d70ddd51a980cd037a9e8337d',
     armv7l: '5a452f26ce39181b52ca51fd3fcf0515b79fce7d70ddd51a980cd037a9e8337d',
       i686: '198a0bfc1445dad68c2daf9fd877abc9944eabb29b8de91dff2eff475ef6e9fe',
     x86_64: '80398327a3f399cd033bd1d0d093ee92f03ba28a81904d6c490d0f93ba72db54'
  })
end
