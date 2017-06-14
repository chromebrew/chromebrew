require 'package'

class Elixir < Package
  description 'Elixir is a dynamic, functional language designed for building scalable and maintainable applications.'
  homepage 'http://elixir-lang.org/'
  version '1.3.1'
  depends_on 'erlang'

  source_url 'https://github.com/elixir-lang/elixir/archive/v1.3.1.tar.gz'
  source_sha1 '29dc1b4da5e051ad71ad84b6886d7c184e4b9add'

  def self.build
    system 'make clean test'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
