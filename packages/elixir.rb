require 'package'

class Elixir < Package
  description 'Elixir is a dynamic, functional language designed for building scalable and maintainable applications.'
  homepage 'http://elixir-lang.org/'
  version '1.4.5'
  depends_on 'erlang'

  source_url 'https://github.com/elixir-lang/elixir/archive/v1.4.5.tar.gz'
  source_sha256 'bef1a0ea7a36539eed4b104ec26a82e46940959345ed66509ec6cc3d987bada0'

  def self.build
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
