require 'package'

class Musl_getaddrinfo_test < Package
  description 'musl getaddrinfo test.'
  homepage 'https://www.openwall.com/lists/musl/2021/07/19/1'
  version '1.0'
  license 'custom'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'musl_native_toolchain' => :build

  def self.build
    load "#{CREW_LIB_PATH}lib/musl.rb"
    @a_c = <<~'SOURCEEOF'
          #include <netdb.h>
          #include <stdio.h>
          #include <stdlib.h>
          #include <string.h>
          #include <arpa/inet.h>

          int
          main(int argc, char *argv[])
          {
              struct addrinfo hints;
              struct addrinfo *result, *rp;
              int r;
              char s[INET6_ADDRSTRLEN];

              memset(&hints, 0, sizeof(hints));
              if (argc > 2)
                  hints.ai_family = AF_INET;
              hints.ai_socktype = SOCK_DGRAM;

              r = getaddrinfo(argv[1], NULL, &hints, &result);
              if (r != 0) {
                  fprintf(stderr, "getaddrinfo: %s\n", gai_strerror(r));
                  exit(EXIT_FAILURE);
              }

              for (rp = result; rp != NULL; rp = rp->ai_next) {
                  switch (rp->ai_family) {
                  case AF_INET:
                      inet_ntop(AF_INET, &((struct sockaddr_in
      *)rp->ai_addr)->sin_addr, s, INET6_ADDRSTRLEN);
                      printf("AF_INET: %s\n", s);
                      break;
                  case AF_INET6:
                      inet_ntop(AF_INET6, &((struct sockaddr_in6
      *)rp->ai_addr)->sin6_addr, s, INET6_ADDRSTRLEN);
                      printf("AF_INET6: %s\n", s);
                      break;
                  }
              }

              freeaddrinfo(result);
          }
    SOURCEEOF
    File.write('a.c', @a_c)
    system "#{CREW_MUSL_PREFIX}/bin/#{ARCH}-linux-musl#{MUSL_ABI}-gcc \
      -isysroot=#{CREW_MUSL_PREFIX} -B#{CREW_MUSL_PREFIX}/include \
      -static --static \
      a.c -o musl_getaddrinfo_test"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_MUSL_PREFIX}/bin"
    FileUtils.cp 'musl_getaddrinfo_test', "#{CREW_DEST_MUSL_PREFIX}/bin/"
  end

  def self.check
    puts 'Testing the musl resolver to see if it can resolve google.com:'.lightblue
    system './musl_getaddrinfo_test google.com set_ai_family'
    system './musl_getaddrinfo_test google.com'
  end
end
