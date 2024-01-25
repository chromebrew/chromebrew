# Adapted from Arch Linux lua-bitop PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/lua-bitop/trunk/PKGBUILD

require 'package'

class Luajit_bitop < Package
  description 'Bitwise operations on numbers'
  homepage 'https://bitop.luajit.org/'
  version '1.0.2'
  license 'MIT'
  compatibility 'all'
  source_url 'https://bitop.luajit.org/download/LuaBitOp-1.0.2.tar.gz'
  source_sha256 '1207c9293dcd52eb9dca6538d1b87352bd510f4e760938f5048433f7f272ce99'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '63df810db9bf29d11a124d7b7097c41602009a79be424ac1aa7bc435d0332eee',
     armv7l: '63df810db9bf29d11a124d7b7097c41602009a79be424ac1aa7bc435d0332eee',
       i686: '537c01093f1ae3389d732123af0dd75fe2e41d46bcaa2707afe1fc9dabc89526',
     x86_64: '381bc79e24437a48a253e5227ab757775fcc18b36d591955a5b4d867e6b60bea'
  })

  depends_on 'luajit'

  def self.patch
    # Patch from https://github.com/LuaJIT/LuaJIT/issues/384#issue-290243677
    @lua53patch = <<~'PATCH_EOF'
      diff -ur LuaBitOp-1.0.2/bit.c LuaBitOp-1.0.3/bit.c
      --- LuaBitOp-1.0.2/bit.c	2012-05-08 15:15:00.000000000 -0400
      +++ LuaBitOp-1.0.3/bit.c	2018-01-20 21:41:00.037749052 -0500
      @@ -26,7 +26,7 @@
       ** [ MIT license: http://www.opensource.org/licenses/mit-license.php ]
       */

      -#define LUA_BITOP_VERSION	"1.0.2"
      +#define LUA_BITOP_VERSION	"1.0.3"

       #define LUA_LIB
       #include "lua.h"
      @@ -46,7 +46,7 @@

       typedef union {
         lua_Number n;
      -#ifdef LUA_NUMBER_DOUBLE
      +#if defined(LUA_NUMBER_DOUBLE) || defined(LUA_FLOAT_DOUBLE)
         uint64_t b;
       #else
         UBits b;
      @@ -63,24 +63,25 @@
       #else
         bn.n = luaL_checknumber(L, idx);
       #endif
      -#if defined(LUA_NUMBER_DOUBLE)
      +#if defined(LUA_NUMBER_DOUBLE) || defined(LUA_FLOAT_DOUBLE)
         bn.n += 6755399441055744.0;  /* 2^52+2^51 */
       #ifdef SWAPPED_DOUBLE
         b = (UBits)(bn.b >> 32);
       #else
         b = (UBits)bn.b;
       #endif
      -#elif defined(LUA_NUMBER_INT) || defined(LUA_NUMBER_LONG) || \
      -      defined(LUA_NUMBER_LONGLONG) || defined(LUA_NUMBER_LONG_LONG) || \
      -      defined(LUA_NUMBER_LLONG)
      +#elif defined(LUA_NUMBER_INT)       || defined(LUA_INT_INT) || \
      +      defined(LUA_NUMBER_LONG)      || defined(LUA_INT_LONG) || \
      +      defined(LUA_NUMBER_LONGLONG)  || defined(LUA_INT_LONGLONG) || \
      +      defined(LUA_NUMBER_LONG_LONG) || defined(LUA_NUMBER_LLONG)
         if (sizeof(UBits) == sizeof(lua_Number))
           b = bn.b;
         else
           b = (UBits)(SBits)bn.n;
      -#elif defined(LUA_NUMBER_FLOAT)
      +#elif defined(LUA_NUMBER_FLOAT) || defined(LUA_FLOAT_FLOAT)
       #error "A 'float' lua_Number type is incompatible with this library"
       #else
      -#error "Unknown number type, check LUA_NUMBER_* in luaconf.h"
      +#error "Unknown number type, check LUA_NUMBER_*, LUA_FLOAT_*, LUA_INT_* in luaconf.h"
       #endif
       #if LUA_VERSION_NUM < 502
         if (b == 0 && !lua_isnumber(L, idx)) {
      @@ -91,7 +92,11 @@
       }

       /* Return bit type. */
      +#if LUA_VERSION_NUM < 503
       #define BRET(b)  lua_pushnumber(L, (lua_Number)(SBits)(b)); return 1;
      +#else
      +#define BRET(b)  lua_pushinteger(L, (lua_Integer)(SBits)(b)); return 1;
      +#endif

       static int bit_tobit(lua_State *L) { BRET(barg(L, 1)) }
       static int bit_bnot(lua_State *L) { BRET(~barg(L, 1)) }
      @@ -163,11 +168,15 @@
       LUALIB_API int luaopen_bit(lua_State *L)
       {
         UBits b;
      +#if LUA_VERSION_NUM < 503
         lua_pushnumber(L, (lua_Number)1437217655L);
      +#else
      +  lua_pushinteger(L, (lua_Integer)1437217655L);
      +#endif
         b = barg(L, -1);
         if (b != (UBits)1437217655L || BAD_SAR) {  /* Perform a simple self-test. */
           const char *msg = "compiled with incompatible luaconf.h";
      -#ifdef LUA_NUMBER_DOUBLE
      +#if defined(LUA_NUMBER_DOUBLE) || defined(LUA_FLOAT_DOUBLE)
       #ifdef _WIN32
           if (b == (UBits)1610612736L)
             msg = "use D3DCREATE_FPU_PRESERVE with DirectX";
    PATCH_EOF
    File.write('lua53.patch', @lua53patch)
    system 'patch -p 1 -i lua53.patch'
    system "sed -i 's,LUA= lua,LUA= luajit,g' Makefile"
    @lua_cflags = `pkg-config --cflags luajit`.chomp
    system "sed -i 's,-I/usr/local/include,#{@lua_cflags},g' Makefile"
  end

  def self.build
    system "#{CREW_ENV_OPTIONS} make PREFIX=#{CREW_PREFIX} LIBDIR=#{CREW_LIB_PREFIX} LUA=#{CREW_PREFIX}/bin/luajit"
  end

  def self.install
    @lua_version = `luajit -e "print(_VERSION)" | awk '{print $2}'`.chomp
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/lib/lua/#{@lua_version}"
    FileUtils.install 'bit.so', "#{CREW_DEST_PREFIX}/lib/lua/#{@lua_version}/bit.so", mode: 0o755
  end
end
