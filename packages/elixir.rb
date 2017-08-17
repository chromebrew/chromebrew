require 'package'

class Elixir < Package
  description 'Elixir is a dynamic, functional language designed for building scalable and maintainable applications.'
  homepage 'http://elixir-lang.org/'
  version '1.5.0'
  source_url 'https://github.com/elixir-lang/elixir/releases/download/v1.5.0/Precompiled.zip'
  source_sha256 '01841d8f973e10ea2e8e29342193063efb5ebe2c598c21dc8a3b93ec8428466a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/elixir-1.5.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/elixir-1.5.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/elixir-1.5.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/elixir-1.5.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'a458311760be3d9ea9f16bfdf2e046fa791afca94e15bd9b0852271403ccef8d',
     armv7l: 'a458311760be3d9ea9f16bfdf2e046fa791afca94e15bd9b0852271403ccef8d',
       i686: '948d4aa81a02fd1bd16dbecce969005235beba009d508bf9da852ab765805d98',
     x86_64: 'f3dac90e7051c6c44ea2c6e0a0dad962efcbe05925718fba1c638d196da5f7f3',
  })

  depends_on 'erlang'
  depends_on 'unzip'

  def self.build
    # do noting
  end

  def self.install
    system "mkdir -p #{CREW_DEST_DIR}#{CREW_PREFIX}"
    system "mkdir -p #{CREW_DEST_DIR}#{CREW_PREFIX}/share"
    system "mv bin #{CREW_DEST_DIR}#{CREW_PREFIX}"
    system "mv lib #{CREW_DEST_DIR}#{CREW_PREFIX}"
    system "mv man #{CREW_DEST_DIR}#{CREW_PREFIX}/share"
  end
end
