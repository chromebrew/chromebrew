require 'package'

class Elixir < Package
  description 'Elixir is a dynamic, functional language designed for building scalable and maintainable applications.'
  homepage 'http://elixir-lang.org/'
  version '1.3.1'
  depends_on 'erlang'

  source_url 'https://github.com/elixir-lang/elixir/archive/v1.3.1.tar.gz'
  source_sha256 'c4ab90a0d8d7ed4159dd6b7e1bcbcdbdb8c6177a35328d774fccf00346b4b42c'

  def self.build
    system 'make clean test'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
