require 'package'

class Gsm < Package
  description 'Shared libraries for GSM 06.10 lossy speech compression'
  homepage 'http://www.quut.com/gsm/'
  @_ver = '1.0.19'
  version @_ver
  compatibility 'all'
  source_url "http://www.quut.com/gsm/gsm-#{@_ver}.tar.gz"
  source_sha256 '4903652f68a8c04d0041f0d19b1eb713ddcd2aa011c5e595b3b8bca2755270f6'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gsm-1.0.19-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gsm-1.0.19-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gsm-1.0.19-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gsm-1.0.19-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '4dc9c3426864671b7c61c08d846ff40fd524bf341163997c8e5caddab90c229d',
     armv7l: '4dc9c3426864671b7c61c08d846ff40fd524bf341163997c8e5caddab90c229d',
       i686: 'e5756a9fe38d9dc52bcdfe74dcaee3edc20eb702cd3c8f6e4b7ddd725166d1ad',
     x86_64: '791c1a029c92f1839398617a1b1633e960a21c58ac45b19ad057b0ef0d3ddcfe'
  })

  def self.patch
    # Patch from https://raw.githubusercontent.com/archlinux/svntogit-packages/packages/gsm/trunk/gsm-shared.patch
    @gsm_patch = <<~'GSM_PATCH_EOF'
      --- Makefile	2006-04-26 15:14:26.000000000 -0400
      +++ Makefile	2010-06-19 16:53:25.000000000 -0400
      @@ -96,11 +96,11 @@
       #  Other tools
       
       SHELL		= /bin/sh
      -LN		= ln
      +LN		= ln -s -f
       BASENAME 	= basename
       AR		= ar
       ARFLAGS		= cr
      -RMFLAGS		=
      +RMFLAGS		= -f
       FIND		= find
       COMPRESS 	= compress
       COMPRESSFLAGS 	= 
      @@ -139,7 +139,7 @@
       
       # Targets
       
      -LIBGSM	= $(LIB)/libgsm.a
      +LIBGSMSO = $(LIB)/libgsm.so
       
       TOAST	= $(BIN)/toast
       UNTOAST	= $(BIN)/untoast
      @@ -257,7 +257,7 @@
       # Install targets
       
       GSM_INSTALL_TARGETS =	\
      -		$(GSM_INSTALL_LIB)/libgsm.a		\
      +		$(GSM_INSTALL_LIB)/libgsm.so		\
          $(GSM_INSTALL_INC)/gsm.h		\
          $(GSM_INSTALL_MAN)/gsm.3		\
          $(GSM_INSTALL_MAN)/gsm_explode.3	\
      @@ -279,7 +279,7 @@
       
       # Target rules
       
      -all:		$(LIBGSM) $(TOAST) $(TCAT) $(UNTOAST)
      +all:		$(LIBGSMSO) $(TOAST) $(TCAT) $(UNTOAST)
          @-echo $(ROOT): Done.
       
       tst:		$(TST)/lin2cod $(TST)/cod2lin $(TOAST) $(TST)/test-result
      @@ -299,24 +299,23 @@
       
       # The basic API: libgsm
       
      -$(LIBGSM):	$(LIB) $(GSM_OBJECTS)
      -		-rm $(RMFLAGS) $(LIBGSM)
      -		$(AR) $(ARFLAGS) $(LIBGSM) $(GSM_OBJECTS)
      -		$(RANLIB) $(LIBGSM)
      -
      +$(LIBGSMSO): $(LIB) $(GSM_OBJECTS)
      +	$(LD) -shared -Wl,-soname,libgsm.so.1 -o $@.1.0.13 $(GSM_OBJECTS)
      +	$(LN) libgsm.so.1.0.13 $(LIBGSMSO).1
      +	$(LN) libgsm.so.1.0.13 $(LIBGSMSO)
       
       # Toast, Untoast and Tcat -- the compress-like frontends to gsm.
       
      -$(TOAST):	$(BIN) $(TOAST_OBJECTS) $(LIBGSM)
      -		$(LD) $(LFLAGS) -o $(TOAST) $(TOAST_OBJECTS) $(LIBGSM) $(LDLIB)
      +$(TOAST):	$(BIN) $(TOAST_OBJECTS) $(LIBGSMSO)
      +		$(LD) $(LFLAGS) -o $(TOAST) $(TOAST_OBJECTS) $(LIBGSMSO) $(LDLIB)
       
       $(UNTOAST):	$(BIN) $(TOAST)
          -rm $(RMFLAGS) $(UNTOAST)
      -		$(LN) $(TOAST) $(UNTOAST)
      +		$(LN) toast $(UNTOAST)
       
       $(TCAT):	$(BIN) $(TOAST)
          -rm $(RMFLAGS) $(TCAT)
      -		$(LN) $(TOAST) $(TCAT)
      +		$(LN) toast $(TCAT)
       
       
       # The local bin and lib directories
      @@ -351,53 +350,54 @@
          fi
       
       $(TOAST_INSTALL_BIN)/toast:	$(TOAST)
      -		-rm $@
      +		-rm $(RMFLAGS) $@
          cp $(TOAST) $@
          chmod 755 $@
       
       $(TOAST_INSTALL_BIN)/untoast:	$(TOAST_INSTALL_BIN)/toast
      -		-rm $@
      -		ln $? $@
      +		-rm $(RMFLAGS) $@
      +		$(LN) toast $@
       
       $(TOAST_INSTALL_BIN)/tcat:	$(TOAST_INSTALL_BIN)/toast
      -		-rm $@
      -		ln $? $@
      +		-rm $(RMFLAGS) $@
      +		$(LN) toast $@
       
       $(TOAST_INSTALL_MAN)/toast.1:	$(MAN)/toast.1
      -		-rm $@
      +		-rm $(RMFLAGS) $@
          cp $? $@
          chmod 444 $@
       
       $(GSM_INSTALL_MAN)/gsm.3:	$(MAN)/gsm.3
      -		-rm $@
      +		-rm $(RMFLAGS) $@
          cp $? $@
          chmod 444 $@
       
       $(GSM_INSTALL_MAN)/gsm_option.3:	$(MAN)/gsm_option.3
      -		-rm $@
      +		-rm $(RMFLAGS) $@
          cp $? $@
          chmod 444 $@
       
       $(GSM_INSTALL_MAN)/gsm_explode.3:	$(MAN)/gsm_explode.3
      -		-rm $@
      +		-rm $(RMFLAGS) $@
          cp $? $@
          chmod 444 $@
       
       $(GSM_INSTALL_MAN)/gsm_print.3:	$(MAN)/gsm_print.3
      -		-rm $@
      +		-rm $(RMFLAGS) $@
          cp $? $@
          chmod 444 $@
       
       $(GSM_INSTALL_INC)/gsm.h:	$(INC)/gsm.h
      -		-rm $@
      -		cp $? $@
      -		chmod 444 $@
      -
      -$(GSM_INSTALL_LIB)/libgsm.a:	$(LIBGSM)
      -		-rm $@
      +		-rm $(RMFLAGS) $@
          cp $? $@
          chmod 444 $@
       
      +$(GSM_INSTALL_LIB)/libgsm.so:	$(LIBGSMSO)
      +		-rm $(RMFLAGS) $@ $@.1 $@.1.0.13
      +		cp $?.1.0.13 $@.1.0.13
      +		chmod 755 $@.1.0.13
      +		$(LN) libgsm.so.1.0.13 $@
      +		$(LN) libgsm.so.1.0.13 $@.1
       
       # Distribution
       
      @@ -425,7 +425,7 @@
            -print | xargs rm $(RMFLAGS)
       
       clean:	semi-clean
      -		-rm $(RMFLAGS) $(LIBGSM) $(ADDTST)/add		\
      +		-rm $(RMFLAGS) $(LIBGSMSO)* $(ADDTST)/add		\
            $(TOAST) $(TCAT) $(UNTOAST)	\
            $(ROOT)/gsm-1.0.tar.Z
       
      @@ -473,22 +473,22 @@
       $(TST)/test-result:	$(TST)/lin2cod $(TST)/cod2lin $(TOAST) $(TST)/run
            ( cd $(TST); ./run ) 
       
      -$(TST)/lin2txt:		$(TST)/lin2txt.o $(LIBGSM)
      +$(TST)/lin2txt:		$(TST)/lin2txt.o $(LIBGSMSO)
            $(LD) $(LFLAGS) -o $(TST)/lin2txt \
      -				$(TST)/lin2txt.o $(LIBGSM) $(LDLIB)
      +				$(TST)/lin2txt.o $(LIBGSMSO) $(LDLIB)
       
      -$(TST)/lin2cod:		$(TST)/lin2cod.o $(LIBGSM)
      +$(TST)/lin2cod:		$(TST)/lin2cod.o $(LIBGSMSO)
            $(LD) $(LFLAGS) -o $(TST)/lin2cod \
      -				$(TST)/lin2cod.o $(LIBGSM) $(LDLIB)
      +				$(TST)/lin2cod.o $(LIBGSMSO) $(LDLIB)
       
      -$(TST)/gsm2cod:		$(TST)/gsm2cod.o $(LIBGSM)
      +$(TST)/gsm2cod:		$(TST)/gsm2cod.o $(LIBGSMSO)
            $(LD) $(LFLAGS) -o $(TST)/gsm2cod \
      -				$(TST)/gsm2cod.o $(LIBGSM) $(LDLIB)
      +				$(TST)/gsm2cod.o $(LIBGSMSO) $(LDLIB)
       
      -$(TST)/cod2txt:		$(TST)/cod2txt.o $(LIBGSM)
      +$(TST)/cod2txt:		$(TST)/cod2txt.o $(LIBGSMSO)
            $(LD) $(LFLAGS) -o $(TST)/cod2txt \
      -				$(TST)/cod2txt.o $(LIBGSM) $(LDLIB)
      +				$(TST)/cod2txt.o $(LIBGSMSO) $(LDLIB)
       
      -$(TST)/cod2lin:		$(TST)/cod2lin.o $(LIBGSM)
      +$(TST)/cod2lin:		$(TST)/cod2lin.o $(LIBGSMSO)
            $(LD) $(LFLAGS) -o $(TST)/cod2lin \
      -				$(TST)/cod2lin.o $(LIBGSM) $(LDLIB)
      +				$(TST)/cod2lin.o $(LIBGSMSO) $(LDLIB)
    GSM_PATCH_EOF
    IO.write('gsm-shared.patch', @gsm_patch)
    # system 'patch -p0 -i gsm-shared.patch'
    system 'curl -Ls https://raw.githubusercontent.com/archlinux/svntogit-packages/packages/gsm/trunk/gsm-shared.patch | patch -b'
  end

  def self.build
    system "env CXXFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
        LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
        make CCFLAGS='-c -fPIC -pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto'"
  end

  def self.install
    # Prepare directories
    @dirs = ['bin', 'lib', 'include/gsm', 'share/gsm', 'share/man/man1', 'share/man/man3']
    @dirs.each do |i|
      FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/#{i}"
    end
    system "make -j1 INSTALL_ROOT=#{CREW_DEST_PREFIX} \
      GSM_INSTALL_INC=#{CREW_DEST_PREFIX}/include/gsm \
      GSM_INSTALL_MAN=#{CREW_DEST_MAN_PREFIX}/man3 \
      TOAST_INSTALL_MAN=#{CREW_DEST_MAN_PREFIX}/man1 \
      install"
    FileUtils.mv "#{CREW_DEST_PREFIX}/lib", "#{CREW_DEST_PREFIX}/lib64" if ARCH == 'x86_64'
  end
end
