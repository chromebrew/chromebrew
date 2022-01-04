require 'package'

class Libgpgerror < Package
  description 'Libgpg-error is a small library that defines common error values for all GnuPG components.'
  homepage 'https://www.gnupg.org/related_software/libgpg-error/index.html'
  @_ver = '1.43'
  version @_ver
  license 'GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url "https://www.gnupg.org/ftp/gcrypt/libgpg-error/libgpg-error-#{@_ver}.tar.bz2"
  source_sha256 'a9ab83ca7acc442a5bd846a75b920285ff79bdb4e3d34aa382be88ed2c3aebaf'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgpgerror/1.43_armv7l/libgpgerror-1.43-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgpgerror/1.43_armv7l/libgpgerror-1.43-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgpgerror/1.43_i686/libgpgerror-1.43-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgpgerror/1.43_x86_64/libgpgerror-1.43-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '9b13df6ff89698f3a1f72a56fbd39b26f7f7929f5a0952481485151b4038f39e',
     armv7l: '9b13df6ff89698f3a1f72a56fbd39b26f7f7929f5a0952481485151b4038f39e',
       i686: 'a755f774182fd094f1327b4767118f072d6fa39443e37fe139cb88bb9c966aa6',
     x86_64: '7eaf819b458f2ad35e66b1113fd9fdec0821d93289f41e670234e7137adb90da'
  })

  def self.patch
    # See https://dev.gnupg.org/T5008#136664
    @testmakefilepatch = <<~'TESTMAKEFILEPATCHEOF'
      --- a/tests/Makefile.in	2022-01-04 18:58:45.185918510 +0000
      +++ b/tests/Makefile.in	2022-01-04 18:55:16.184507622 +0000
      @@ -662,6 +662,10 @@ distclean-tags:
       check-TESTS: $(TESTS)
       	@failed=0; all=0; xfail=0; xpass=0; skip=0; \
       	srcdir=$(srcdir); export srcdir; \
      +	gpgerror_libdir=`dirname $$PWD`/src/.libs; \
      +	LD_LIBRARY_PATH=`echo "$$gpgerror_libdir:$$LD_LIBRARY_PATH" | $(SED) 's/:*$$//g'`; \
      +	DYLD_LIBRARY_PATH=`echo "$$gpgerror_libdir:$$DYLD_LIBRARY_PATH" | $(SED) 's/:*$$//g'`; \
      +	export LD_LIBRARY_PATH; export DYLD_LIBRARY_PATH; \
       	list=' $(TESTS) '; \
       	$(am__tty_colors); \
       	if test -n "$$list"; then \
    TESTMAKEFILEPATCHEOF
    File.write('testmakefile.patch', @testmakefilepatch)
    system 'patch -Np1 -i testmakefile.patch'
    system 'filefix'
  end

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system "./configure #{CREW_OPTIONS} #{CREW_ENV_OPTIONS} \
      --enable-static \
      --enable-shared \
      --disable-maintainer-mode"
    system 'make'
  end

  def self.check
    Dir.chdir 'tests' do
      system 'make check'
    end
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
