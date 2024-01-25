require 'package'

class Help2man < Package
  description "help2man produces simple manual pages from the '--help' and '--version' output of other commands."
  homepage 'https://www.gnu.org/software/help2man/'
  version '1.49.2'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/help2man/help2man-1.49.2.tar.xz'
  source_sha256 '9e2e0e213a7e0a36244eed6204d902b6504602a578b6ecd15268b1454deadd36'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5a452f26ce39181b52ca51fd3fcf0515b79fce7d70ddd51a980cd037a9e8337d',
     armv7l: '5a452f26ce39181b52ca51fd3fcf0515b79fce7d70ddd51a980cd037a9e8337d',
       i686: '198a0bfc1445dad68c2daf9fd877abc9944eabb29b8de91dff2eff475ef6e9fe',
     x86_64: '67d0aebdbc7fc6bb09aa346b95ce40838be4b3a5907870c66ba12ba0c681f5e1'
  })

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
