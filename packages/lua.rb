# Adapted from Arch Linux lua PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/lua/

require 'package'

class Lua < Package
  description 'Lua is a powerful, efficient, lightweight, embeddable scripting language.'
  homepage 'https://www.lua.org/'
  @_ver = '5.4.6'
  @_ver_prelastdot = @_ver.rpartition('.')[0]
  version "#{@_ver}-1"
  license 'MIT'
  compatibility 'all'
  source_url 'https://www.lua.org/ftp/lua-5.4.6.tar.gz'
  source_sha256 '7d5ea1b9cb6aa0b59ca3dde1c6adcb57ef83a1ba8e5432c0ecd06bf439b3ad88'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lua/5.4.6-1_armv7l/lua-5.4.6-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lua/5.4.6-1_armv7l/lua-5.4.6-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lua/5.4.6-1_i686/lua-5.4.6-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lua/5.4.6-1_x86_64/lua-5.4.6-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '4bafd7a8d10d40b6f583568d210e2cfafc396cb37082cdacd9fcbf09ae5d7cf2',
     armv7l: '4bafd7a8d10d40b6f583568d210e2cfafc396cb37082cdacd9fcbf09ae5d7cf2',
       i686: '0bfdef68df71e5f73913881db30c73eeee7867cca043ab9f3744a52552b830af',
     x86_64: '8d97b026e1492cea3e3d35a469d881d08f79b8a6d172cbdd6121b89d2d71a86f'
  })

  depends_on 'glibc' # R
  depends_on 'readline' # R
  depends_on 'gcc_lib' # R

  def self.patch
    # Patch adapted from https://gitlab.archlinux.org/archlinux/packaging/packages/lua/-/blob/main/liblua.so.patch
    File.write 'arch-lua.patch', <<~ARCH_PATCH_EOF
      diff --git a/Makefile b/Makefile
      index 416f444..eeaff03 100644
      --- a/Makefile
      +++ b/Makefile
      @@ -52,7 +52,7 @@ R= $V.0
       all:	$(PLAT)
      #{' '}
       $(PLATS) help test clean:
      -	@cd src && $(MAKE) $@
      +	@cd src && $(MAKE) $@ V=$(V) R=$(R)
      #{' '}
       install: dummy
       	cd src && $(MKDIR) $(INSTALL_BIN) $(INSTALL_INC) $(INSTALL_LIB) $(INSTALL_MAN) $(INSTALL_LMOD) $(INSTALL_CMOD)
      diff --git a/src/Makefile b/src/Makefile
      index 514593d..372a6dc 100644
      --- a/src/Makefile
      +++ b/src/Makefile
      @@ -33,6 +33,7 @@ CMCFLAGS= -Os
       PLATS= guess aix bsd c89 freebsd generic linux linux-readline macosx mingw posix solaris
      #{' '}
       LUA_A=	liblua.a
      +LUA_SO= liblua.so
       CORE_O=	lapi.o lcode.o lctype.o ldebug.o ldo.o ldump.o lfunc.o lgc.o llex.o lmem.o lobject.o lopcodes.o lparser.o lstate.o lstring.o ltable.o ltm.o lundump.o lvm.o lzio.o
       LIB_O=	lauxlib.o lbaselib.o lcorolib.o ldblib.o liolib.o lmathlib.o loadlib.o loslib.o lstrlib.o ltablib.o lutf8lib.o linit.o
       BASE_O= $(CORE_O) $(LIB_O) $(MYOBJS)
      @@ -44,7 +45,7 @@ LUAC_T=	luac
       LUAC_O=	luac.o
      #{' '}
       ALL_O= $(BASE_O) $(LUA_O) $(LUAC_O)
      -ALL_T= $(LUA_A) $(LUA_T) $(LUAC_T)
      +ALL_T= $(LUA_A) $(LUA_T) $(LUAC_T) $(LUA_SO)
       ALL_A= $(LUA_A)
      #{' '}
       # Targets start here.
      @@ -60,6 +61,12 @@ $(LUA_A): $(BASE_O)
       	$(AR) $@ $(BASE_O)
       	$(RANLIB) $@
      #{' '}
      +$(LUA_SO): $(CORE_O) $(LIB_O)
      +	$(CC) -shared -ldl -Wl,-soname,$(LUA_SO).$(V) -o $@.$(R) $? -lm $(LDFLAGS)
      +	ln -sf $(LUA_SO).$(R) $(LUA_SO).$(V)
      +	ln -sf $(LUA_SO).$(R) $(LUA_SO)
      +
      +
       $(LUA_T): $(LUA_O) $(LUA_A)
       	$(CC) -o $@ $(LDFLAGS) $(LUA_O) $(LUA_A) $(LIBS)
    ARCH_PATCH_EOF
    # From https://gitlab.archlinux.org/archlinux/packaging/packages/lua/-/blob/main/lua.pc
    system 'patch -Np1 -i arch-lua.patch'
    @files = Dir.glob('*')
    FileUtils.mkdir 'lua++'
    FileUtils.cp_r @files, 'lua++'
    File.write 'lua.pc', <<~ARCH_LUA_PC_EOF
      V=#{@_ver_prelastdot}
      R=#{@_ver}

      prefix=#{CREW_PREFIX}
      INSTALL_BIN=${prefix}/bin
      INSTALL_INC=${prefix}/include
      INSTALL_LIB=#{CREW_LIB_PREFIX}
      INSTALL_MAN=${prefix}/man/man1
      INSTALL_LMOD=${prefix}/share/lua/${V}
      INSTALL_CMOD=${prefix}/lib/lua/${V}
      exec_prefix=${prefix}
      libdir=#{CREW_LIB_PREFIX}
      includedir=${prefix}/include

      Name: Lua
      Description: An Extensible Extension Language
      Version: ${R}
      Requires:#{' '}
      Libs: -L${libdir} -llua -lm
      Cflags: -I${includedir}
    ARCH_LUA_PC_EOF
    system "sed 's/-llua/-llua++/g' lua.pc > lua++.pc"
  end

  def self.build
    system "make MYCFLAGS='-fPIC' linux-readline -j#{CREW_NPROC}"
    Dir.chdir('lua++') do
      system "make MYCFLAGS='-fPIC' CC=g++ LUA_A=liblua++.a LUA_SO=liblua++.so linux-readline -j#{CREW_NPROC}"
    end
  end

  def self.install
    system "make PREFIX=#{CREW_PREFIX} \
            INSTALL_LIB=#{CREW_DEST_LIB_PREFIX} \
            INSTALL_MAN=#{CREW_DEST_MAN_PREFIX}/man1 \
            INSTALL_TOP=#{CREW_DEST_PREFIX} \
            TO_LIB='liblua.a liblua.so liblua.so.#{@_ver_prelastdot} liblua.so.#{@_ver}' \
            INSTALL_DATA='cp -d' \
            install"
    @lua_bin = %w[lua luac]
    @lua_bin.each do |bin|
      Dir.chdir("#{CREW_DEST_PREFIX}/bin") do
        FileUtils.ln_sf bin, "#{bin}#{@_ver_prelastdot}"
      end
    end
    Dir.chdir(CREW_DEST_LIB_PREFIX) do
      FileUtils.ln_sf "liblua.so.#{@_ver}", "liblua.so.#{@_ver_prelastdot}"
    end
    FileUtils.install 'lua.pc', "#{CREW_DEST_LIB_PREFIX}/pkgconfig/lua#{@_ver_prelastdot.gsub('.', '')}.pc", mode: 0o644
    Dir.chdir("#{CREW_DEST_LIB_PREFIX}/pkgconfig") do
      FileUtils.ln_sf "lua#{@_ver_prelastdot.gsub('.', '')}.pc", 'lua.pc'
      FileUtils.ln_sf "lua#{@_ver_prelastdot.gsub('.', '')}.pc", "lua#{@_ver_prelastdot}.pc"
      FileUtils.ln_sf "lua#{@_ver_prelastdot.gsub('.', '')}.pc", "lua-#{@_ver_prelastdot}.pc"
    end
    Dir.chdir('lua++') do
      system "make PREFIX=#{CREW_PREFIX} \
              INSTALL_LIB=#{CREW_DEST_LIB_PREFIX} \
              INSTALL_TOP=#{CREW_DEST_PREFIX} \
              TO_LIB='liblua++.a liblua++.so liblua++.so.#{@_ver_prelastdot} liblua++.so.#{@_ver}' \
              INSTALL_BIN=null INSTALL_INC=null INSTALL_MAN=../null \
              INSTALL_DATA='cp -d' \
              install"
    end
    Dir.chdir(CREW_DEST_LIB_PREFIX) do
      FileUtils.ln_sf "liblua++.so.#{@_ver}", "liblua.so.#{@_ver_prelastdot}"
    end
    FileUtils.install 'lua++.pc', "#{CREW_DEST_LIB_PREFIX}/pkgconfig/lua++#{@_ver_prelastdot.gsub('.', '')}.pc",
                      mode: 0o644
    Dir.chdir("#{CREW_DEST_LIB_PREFIX}/pkgconfig") do
      FileUtils.ln_sf "lua#{@_ver_prelastdot.gsub('.', '')}.pc", 'lua++.pc'
      FileUtils.ln_sf "lua#{@_ver_prelastdot.gsub('.', '')}.pc", "lua++#{@_ver_prelastdot}.pc"
      FileUtils.ln_sf "lua#{@_ver_prelastdot.gsub('.', '')}.pc", "lua++-#{@_ver_prelastdot}.pc"
    end
  end
end
