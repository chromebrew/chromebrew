require 'package'

class Owl < Package
  description 'Owl Lisp is a functional dialect of the Scheme programming language.'
  homepage 'https://haltp.org/posts/owl.html'
  version '0.2.2'
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.com/owl-lisp/owl.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '564e84bdad63271e3b1c34d369e1895921ee9908f506629a3f624dc6594466ae',
     armv7l: '564e84bdad63271e3b1c34d369e1895921ee9908f506629a3f624dc6594466ae',
       i686: '3a9b4a731d8c6ba589cf550afb0f53d60b00a633143e2279b76a5889d2cd2873',
     x86_64: '7d9913c9d6aab7028eab4885e43832e35ad4a59954050dfc8906d7c8ab037c84'
  })

  depends_on 'glibc' # R

  def self.patch
    File.write 'owl.patch', <<~OWLPATCHEOF
      diff -Npaur a/Makefile b/Makefile
      --- a/Makefile	2025-09-29 14:30:45.866445331 -0400
      +++ b/Makefile	2025-09-29 14:31:46.552423404 -0400
      @@ -49,8 +49,9 @@ c/ol.c: fasl/ol.fasl
       bin/ol: c/ol.c
       	# compile the real owl repl binary
       	$(CC) $(CFLAGS) $(LDFLAGS) -o bin/olp $?
      -	CC="$(CC)" LDFLAGS="$(LDFLAGS)" CFLAGS="$(CFLAGS)" sh tests/run all bin/olp
      -	test '!' -f $@ || mv $@ bin/ol-old
      + # This breaks container builds.
      + #	CC="$(CC)" LDFLAGS="$(LDFLAGS)" CFLAGS="$(CFLAGS)" sh tests/run all bin/olp
      + #	test '!' -f $@ || mv $@ bin/ol-old
       	mv bin/olp $@

       c/ol-small.c: fasl/ol.fasl
    OWLPATCHEOF
    system 'patch -Np1 -i owl.patch'
  end

  def self.build
    system 'make', "PREFIX=#{CREW_PREFIX}"
  end

  def self.install
    system 'make', "PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
