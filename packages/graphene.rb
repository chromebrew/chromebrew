require 'package'

class Graphene < Package
  description 'A thin layer of graphic data types'
  homepage 'https://github.com/ebassi/graphene'
  version '1.6.0'
  source_url 'https://github.com/ebassi/graphene/archive/1.6.0.tar.gz'
  source_sha256 '98970f859e452ce421b72726ca727fdf3ac27cb4804b62bfe520157fa46aa2fd'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/graphene-1.6.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/graphene-1.6.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/graphene-1.6.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/graphene-1.6.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'cf86736cfe01b752bc93366c84f92b135196d32cb5918b5e73c3b270fb7a4421',
     armv7l: 'cf86736cfe01b752bc93366c84f92b135196d32cb5918b5e73c3b270fb7a4421',
       i686: '40545e0b6b19f7f9bff26ca933f1bbfa601b3403bce2dfdec82af6a885b534a3',
     x86_64: 'efa9a4ea013fbd15604a86c2a858e6918327287390d467481ccc53df2276acd8',
  })

  depends_on 'meson'

  def self.build
    system "meson _build --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} -Denable-arm-neon=false"
  end

  def self.install
    Dir.chdir("_build") do
     system "ninja install"
    end
  end
  
  def self.check
    Dir.chdir("_build") do
     system "ninja test"
    end
  end  
  
end
